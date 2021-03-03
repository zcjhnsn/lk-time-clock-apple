//
//  EntryDetailView.swift
//  TimeClock
//
//  Created by Zac Johnson on 3/2/21.
//

import SwiftUI
import Combine

extension DateComponentsFormatter {
    static var time: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter
    }
}

struct EntryDetailView: View {
    @Binding var task: TaskItem
    @EnvironmentObject var timerHelper: TimerHelper
//    @State var timeString: String
    @State var activityTypeHelper = ActivityTypeHelper()
    

    
    var body: some View {
            Form {
                Section(header: Text("Entry Details")) {
                    TextField("Label", text: $task.name)
                    TextEditor(text: $task.comment)
                    
                    HStack {
                        Picker("Activity Type", selection: $task.activityTypeID) {
                            ForEach(activityTypeHelper.activities.indices) { index in
                                Text(activityTypeHelper.activities[index].name)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        Spacer()
                        
                        Text()
                    }
                    
                }
                
            }
        
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetailView(task: .constant(TaskItem(name: "test", time: 600)))
    }
}
