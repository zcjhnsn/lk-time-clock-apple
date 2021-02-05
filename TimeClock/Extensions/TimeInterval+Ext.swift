//
//  TimeInterval+Ext.swift
//  TimeClock
//
//  Created by Zac Johnson on 2/5/21.
//

import Foundation

extension TimeInterval {
    func timeString() -> String {
        let hour = Int(self) / 3600
        let minute = Int(self) / 60 % 60
        let second = Int(self) % 60
        
        // return formated string
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
}
