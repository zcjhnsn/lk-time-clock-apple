//
//  Task.swift
//  TimeClock
//
//  Created by Zac Johnson on 2/4/21.
//

import Foundation

struct TaskItem: Identifiable {
    let id = UUID()
    var name: String
    var time: Int
}

class Tasks: ObservableObject {
    @Published var items = [TaskItem]()
}
