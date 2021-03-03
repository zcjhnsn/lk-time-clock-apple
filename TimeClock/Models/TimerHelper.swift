//
//  TimerHelper.swift
//  TimeClock
//
//  Created by Zac Johnson on 3/3/21.
//

import Foundation

class TimerHelper: ObservableObject {
    @Published var isTimerPaused: Bool = true
    @Published var activeTask: UUID = UUID()
    @Published var timer: Timer? = nil
    @Published var totalTime: Int = 0
}
