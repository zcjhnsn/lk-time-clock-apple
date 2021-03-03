//
//  Task.swift
//  TimeClock
//
//  Created by Zac Johnson on 2/4/21.
//

import Foundation

class TaskItem: ObservableObject, Identifiable, Equatable {
    let id = UUID()
    @Published var name: String
    @Published var time: Int
    @Published var comment: String = ""
    @Published var activityTypeID: Int = -1
    
    static func == (lhs: TaskItem, rhs: TaskItem) -> Bool {
        lhs.id == rhs.id
    }
    
    init(name: String, time: Int) {
        self.name = name
        self.time = time
    }
}

class Tasks: ObservableObject {
    @Published var items = [TaskItem]()
}
