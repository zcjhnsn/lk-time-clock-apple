//
//  WelcomeView.swift
//  TimeClock
//
//  Created by Zac Johnson on 3/2/21.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to LK Time Tracker")
                .font(.largeTitle)
            
            Text("Add a timer from the left-hand menu")
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
