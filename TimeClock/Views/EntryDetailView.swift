//
//  EntryDetailView.swift
//  TimeClock
//
//  Created by Zac Johnson on 3/2/21.
//

import SwiftUI

struct EntryDetailView: View {
    @Binding var task: TaskItem
    
    var body: some View {
            Form {
                Section(header: Text("Entry Details")) {
                    TextField("Label", text: $task.name)
                }
            }
        
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetailView(task: .constant(TaskItem(name: "test", time: 600)))
    }
}
