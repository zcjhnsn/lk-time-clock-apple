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
    var task: TaskItem
    var progress: CGFloat = 0.3
    var id: UUID
    
    var startPauseAction: () -> Void
    
    var body: some View {
        HStack {
            Text("Time: \(task.time) ")
            Text("Index: \(id.uuidString)")
            Spacer()
            VStack {
                Text(isTimerPaused ? "Start" : "Pause")
                    .frame(maxWidth: 50)
                    .onTapGesture(perform: startPauseAction)
                    .padding(4)
                    .background(isTimerPaused ? Color.green : Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(isTimerPaused: true, task: TaskItem(name: "Hello", time: 0), id: UUID(), startPauseAction: {})
    }
}
