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
    @State var timer: Timer? = nil
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.systemBackground
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                Text("total time: \(tasks.items.reduce(0) { $0 + $1.time })")
                
                LazyVStack(alignment: .center, spacing: 12, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                        ForEach(tasks.items) { item in
                            HStack {
                                Text("Time: \(item.time) ")
                                VStack {
                                    Button(action: {
                                        if let index = tasks.items.firstIndex(where: { $0.id == item.id }) {
                                            if isTimerPaused {
                                                startTimer(forTask: index)
                                            } else {
                                                pauseTimer()
                                            }
                                        }
                                    }, label: {
                                        Text(isTimerPaused ? "Start" : "Pause")
                                            .foregroundColor(Color.primary)
                                        
                                    })
                                    .background(isTimerPaused ? Color.green : Color.orange)
                                    .contentShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("Submit")
                                            .foregroundColor(Color.primary)
                                    })
                                    .background(Color.blue)
                                    .contentShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    Button(action: {
                                        if let index = tasks.items.firstIndex(where: { $0.id == item.id }) {
                                            if !isTimerPaused {
                                                pauseTimer()
                                            }
                                            self.removeItems(at: IndexSet(integer: index))
                                        }
                                    }, label: {
                                        Text("Remove")
                                            .foregroundColor(Color.primary)
                                    })
                                    .background(Color.red)
                                    .contentShape(RoundedRectangle(cornerRadius: 8))
                                }
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                )
            }
            .navigationTitle("Time Clock")
            .navigationBarItems(trailing:
                Button(action: {
                    withAnimation(.default) {
                        tasks.items.append(TaskItem(name: "New task \(tasks.items.count + 1)", time: 0))
                    }
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.primary)
                })
            )
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        tasks.items.remove(atOffsets: offsets)
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
        isTimerPaused.toggle()
    }
    
    func startTimer(forTask taskItem: Int) {
        if !isTimerPaused {
            pauseTimer()
        }
        
        isTimerPaused.toggle()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tasks.items[taskItem].time += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
