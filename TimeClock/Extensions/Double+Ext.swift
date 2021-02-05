//
//  Double+Ext.swift
//  TimeClock
//
//  Created by Zac Johnson on 2/5/21.
//

import Foundation
import SwiftUI

extension Double {
    func toRadians() -> Double {
        return self * Double.pi / 180
    }
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}
