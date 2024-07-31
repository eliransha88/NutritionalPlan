//
//  CircularProgressBarView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 08/07/2024.
//

import SwiftUI
import SFSafeSymbols

struct CircularProgressBarView: View {
    
    struct Constants {
        static let lineWidth: CGFloat = 20.0
        static let arrowSize: CGSize = 10.asSize
    }
    
    @Environment(\.layoutDirection) var layoutDirection
    
    let progress: Double
    let colors: [Color]
    
    init(progress: Double, colors: [Color]) {
        self.progress = progress
        self.colors = colors
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(colors.first!.opacity(0.4),
                        style: StrokeStyle(lineWidth: Constants.lineWidth))
            
            Circle()
                .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                .stroke(AngularGradient(colors: colors,
                                        center: .center),
                        style: StrokeStyle(lineWidth: Constants.lineWidth,
                                           lineCap: .round))
                .rotationEffect(Angle(degrees: layoutDirection == .rightToLeft ? 90 : -90))
                .animation(.easeOut(duration: 2.0).delay(0.5), value: progress)
                .overlay(alignment: .top) {
                    Image(systemSymbol: .arrowRight)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.black)
                        .frame(size: Constants.arrowSize)
                        .padding(5)
                        .background(colors.first)
                        .clipShape(Circle())
                        .padding(.top, -10)
                        
                }
        }
    }
}

#Preview {
    CircularProgressBarView(progress: 0.8, colors:  [Colors.red1, Colors.red2, Colors.red3, Colors.red4])
        .padding()
}
