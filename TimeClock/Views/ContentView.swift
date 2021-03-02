//
//  ContentView.swift
//  TimeClock
//
//  Created by Zac Johnson on 2/4/21.
//

import SwiftUI

// https://medium.com/@drevathy/custom-themes-with-color-assets-in-swift-9e64f91ee45d
struct ContentView: View {
    @ObservedObject var tasks = Tasks()
    
    @State var isTimerPaused: Bool = true
    @State var activeTask: UUID = UUID()
    @State var timer: Timer? = nil
    @State private var totalTime: Int = 0
    @State private var redmineKey = UserDefaults.standard.string(forKey: SaveKey.redmineKey.rawValue)
    @State private var showModal: Bool = UserDefaults.standard.string(forKey: SaveKey.redmineKey.rawValue) == nil
    @State private var showingAlert: Bool = false
    
    init() {
        UITableView.appearance().separatorStyle = .none
        if #available(iOS 13.0, *) {
            UITableViewCell.appearance().selectionStyle = .none
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                Group {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Total: \(TimeInterval(totalTime).timeString())")
                                .font(.title)
                                .foregroundColor(isTimerPaused ? Color.red : Color.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 16)
                            
                            if isTimerPaused {
                                Text("(Paused)")
                                    .foregroundColor(.darkRed)
                                    .padding(.trailing, 16)
                            }
                        }
                        
                        
                        Text("RM Key: \(redmineKey ?? "none")")
                            .padding(.leading, 16)
                    }
                    List {
                        ForEach(tasks.items.indices, id: \.self) { index in
                            NavigationLink(destination: EntryDetailView(task: self.$tasks.items[index])) {
                                EntryView(isTimerPaused: activeTask.uuidString != self.tasks.items[index].id.uuidString, task: self.$tasks.items[index], id: self.tasks.items[index].id, startPauseAction: {
                                    if isTimerPaused {
                                        startTimer(forTask: self.tasks.items[index].id)
                                    } else if !isTimerPaused && activeTask != self.tasks.items[index].id {
                                        startTimer(forTask: self.tasks.items[index].id)
                                    } else {
                                        pauseTimer()
                                    }
                                })
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    
                    Spacer()
                    
                    Button(action: {
                        
                        //self.tasks.objectWillChange.send()
                        for item in tasks.items {
                            print("\(item.name) \(item.time)")
                        }
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
                .navigationBarItems(
                    leading:
                        Button(action: {
                            showModal = true
                        }, label: {
                            Image(systemName: "gear")
                                .foregroundColor(.primary)
                        }),
                    trailing:
                        Button(action: {
                            withAnimation(.default) {
                                tasks.items.append(TaskItem(name: "", time: 0))
                            }
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.primary)
                        })
                )
                
                WelcomeView()
            }
            .phoneOnlyStackNavigationView()
            .accentColor(.primary)
            .sheet(isPresented: $showModal, content: {
                RedmineKeyView(shouldShow: $showModal)
            })
        }
        

        
        
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
            self.totalTime += 1
            self.tasks.items[index].time += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.preferredColorScheme(.dark)
    }
}
