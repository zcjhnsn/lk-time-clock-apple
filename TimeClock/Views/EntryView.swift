//
//  EntryView.swift
//  TimeClock
//
//  Created by Zac Johnson on 2/4/21.
//

import SwiftUI

struct EntryView: View {
    @State private var showingAlert = false
    
    var isTimerPaused: Bool
    @ObservedObject var task: TaskItem
    @State private var title: String = "" {
        didSet {
            self.task.name = title
        }
    }
    var id: UUID
    var percentage: Double {
        return Double(task.time) / 3600.0 * 100
    }
    var darkColor: Color {
        return isTimerPaused ? .darkRed : .skyBlue
    }
    var lightColor: Color {
        return isTimerPaused ? .lightRed : .cyan
    }
    var startPauseAction: () -> Void
    
    var body: some View {
        HStack {
            VStack() {
                
                PercentageRing(ringWidth: 15, percent: Double(task.time) / 3600.0 * 100, backgroundColor: darkColor.opacity(0.2), foregroundColors: [darkColor, lightColor])
                    .frame(width: 100, height: 100)
                
                Text("\(TimeInterval(task.time).timeString())")
            }
            VStack {
                TextField("New Task", text: $title, onCommit:  {
                    self.task.name = title
                    self.hideKeyboard()
                })
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Spacer()
                
                Button(action: {
                    self.startPauseAction()
                }, label: {
                    Text(isTimerPaused ? "Start" : "Stop")
                        .frame(maxWidth: .infinity, maxHeight: 36)
                })
                .buttonStyle(PlainButtonStyle())
                .contentShape(Rectangle())
                .background(isTimerPaused ? Color.skyBlue : Color.darkRed)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
//                Text(isTimerPaused ? "Start" : "Stop")
//                    .frame(maxWidth: .infinity)
//                    .onTapGesture(perform: startPauseAction)
//                    .padding(4)
//                    .background(isTimerPaused ? Color.skyBlue : Color.darkRed)
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
    
            
            }
        }
        .padding()
        .background(Color.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onTapGesture {
            self.task.name = title
            self.hideKeyboard()
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(isTimerPaused: true, task: TaskItem(name: "Hello", time: 0), id: UUID(), startPauseAction: {})
            .preferredColorScheme(.dark)
    }
}
