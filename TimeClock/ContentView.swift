//
//  ContentView.swift
//  TimeClock
//
//  Created by Zac Johnson on 2/4/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var tasks = Tasks()
    
    @State var isTimerPaused: Bool = true
    @State var activeTask: UUID = UUID()
    @State var timer: Timer? = nil
    @State private var redmineKey = UserDefaults.standard.string(forKey: SaveKey.redmineKey.rawValue)
    @State private var showModal: Bool = UserDefaults.standard.string(forKey: SaveKey.redmineKey.rawValue) == nil
    @State private var showingAlert: Bool = false
    
    init() {
//        UITableView.appearance().backgroundColor = UIColor.systemBackground
    }
    
    var body: some View {
        NavigationView {
            Group {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Total: \(timeString(time: TimeInterval(tasks.items.reduce(0) { $0 + $1.time })))")
                            .font(.title)
                            .foregroundColor(isTimerPaused ? Color.red : Color.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                        
                        if isTimerPaused {
                            Text("(Paused)")
                                .foregroundColor(.red)
                                .padding(.trailing, 16)
                        }
                    }
                    
                    
                    Text("RM Key: \(redmineKey ?? "none")")
                        .padding(.leading, 16)
                }
                List {
                    ForEach(tasks.items) { item in
                        EntryView(isTimerPaused: activeTask.uuidString != item.id.uuidString, task: item, progress: CGFloat(Double(item.time)/3600.0), id: item.id, startPauseAction: {
                            if isTimerPaused {
                                startTimer(forTask: item.id)
                            } else if !isTimerPaused && activeTask != item.id {
                                startTimer(forTask: item.id)
                            } else {
                                pauseTimer()
                            }
                        })

                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Spacer()
                
                Button(action: {
                    if tasks.items.isEmpty || redmineKey == nil {
                        self.showingAlert = true
                    }
                }, label: {
                    Text("Submit Time")
                        .frame(maxWidth: .infinity, maxHeight: 36)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding()
                })
                .alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("Cannot Submit Time"), message: Text("Must have at least one time entry and a Redmine API Key."), dismissButton: .default(Text("Okay")))
                })
                
            }
            .navigationTitle("Time Clock")
            .navigationBarItems(leading:
                                    Button(action: {
                                        showModal = true
                                    }, label: {
                                        Image(systemName: "gear")
                                            .foregroundColor(.primary)
                                    }),trailing:
                Button(action: {
                    withAnimation(.default) {
                        tasks.items.append(TaskItem(name: "New task \(tasks.items.count + 1)", time: 0))
                    }
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.primary)
                })
            )
        }.sheet(isPresented: $showModal, content: {
            RedmineKeyView(shouldShow: $showModal)
        })
        
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
        isTimerPaused.toggle()
        activeTask = UUID()
    }
    
    func startTimer(forTask taskID: UUID) {
        if !isTimerPaused {
            pauseTimer()
        }
        
        isTimerPaused.toggle()
        activeTask = taskID
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            guard let index = self.tasks.items.firstIndex(where: { $0.id == taskID }) else {
                pauseTimer()
                return
            }
            
            self.tasks.items[index].time += 1
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        
        // return formated string
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
