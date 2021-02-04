//
//  ActivityRingView.swift
//  TimeClock
//
//  Created by Zac Johnson on 2/4/21.
//

import SwiftUI

struct ActivityRingView: View {
    @Binding var progress: CGFloat
    
    var colors: [Color] = [Color.darkRed, Color.lightRed]
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.outlineRed, lineWidth: 20)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: colors),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360)
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
        }.frame(idealWidth: 300, idealHeight: 300, alignment: .center)
    }
}

struct ActivityRingView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRingView(progress: .constant(CGFloat(0.3)))
    }
}
