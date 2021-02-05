//
//  Color+Ext.swift
//  TimeClock
//
//  Created by Zac Johnson on 2/4/21.
//

import SwiftUI

extension Color {
    public static var outlineRed: Color {
        return Color(decimalRed: 34, green: 0, blue: 3)
    }
    
    public static var darkRed: Color {
        return Color(decimalRed: 227, green: 6, blue: 37)
    }
    
    public static var lightRed: Color {
        return Color(decimalRed: 253, green: 52, blue: 137)
    }
    
    public static var skyBlue: Color {
        return Color(decimalRed: 0, green: 186, blue: 224)
    }
    
    public static var cyan: Color {
        return Color(decimalRed: 0, green: 252, blue: 208)
    }
    
    public static var limeGreen: Color {
        return Color(decimalRed: 111, green: 236, blue: 0)
    }
    
    public static var neonGreen: Color {
        return Color(decimalRed: 181, green: 255, blue: 9)
    }
    
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
    
    #if os(macOS)
    static let background = Color(NSColor.windowBackgroundColor)
    static let secondaryBackground = Color(NSColor.underPageBackgroundColor)
    static let tertiaryBackground = Color(NSColor.controlBackgroundColor)
    #else
    static let background = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
    #endif
}
