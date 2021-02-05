//
//  ActivityRingView.swift
//  TimeClock
//
//  Created by Zac Johnson on 2/4/21.
//

import SwiftUI

struct ActivityRingView: View {
    @Binding var progress: CGFloat
    var strokeWidth: CGFloat
    var ringDiameter: CGFloat
    var ringRadius: CGFloat {
        return ringDiameter / 2
    }
    
    var colors: [Color] = [Color.darkRed, Color.lightRed]
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.outlineRed, lineWidth: strokeWidth)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: colors),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360)
                    ),
                    style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round)
                ).rotationEffect(.degrees(-90))
            Circle()
                .frame(width: strokeWidth, height: strokeWidth)
                .foregroundColor(Color.darkRed)
                .offset(y: -ringRadius)
            Circle()
                .frame(width: strokeWidth, height: strokeWidth)
                .foregroundColor(progress > 0.95 ? Color.lightRed : Color.lightRed.opacity(0))
                .offset(y: -ringRadius)
                .rotationEffect(Angle.degrees(360 * Double(progress)))
                .shadow(color: progress > 0.96 ? Color.black.opacity(0.1) : Color.clear, radius: 3, x: 4, y: 0)
        }.frame(idealWidth: ringDiameter, idealHeight: ringDiameter, alignment: .center)
    }
}

struct ActivityRingView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRingView(progress: .constant(CGFloat(0.3)), strokeWidth: CGFloat(20), ringDiameter: CGFloat(300))
    }
}
