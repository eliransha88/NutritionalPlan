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
    let color: Color
    
    init(progress: Double, color: Color) {
        self.progress = progress
        self.color = color
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.4),
                        style: StrokeStyle(lineWidth: Constants.lineWidth))
            
            Circle()
                .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                .stroke(color, style: StrokeStyle(lineWidth: Constants.lineWidth, lineCap: .round))
                .rotationEffect(Angle(degrees: layoutDirection == .rightToLeft ? 90 : -90))
                .animation(.easeOut(duration: 2.0).delay(0.5), value: progress)
                .overlay(alignment: .top) {
                    Image(systemSymbol: .arrowRight)
                        .resizable()
                        .scaledToFit()
                        .frame(size: Constants.arrowSize)
                        .padding(5)
                        .background(color)
                        .clipShape(Circle())
                        .padding(.top, -10)
                        
                }
        }
    }
}

#Preview {
    CircularProgressBarView(progress: 0.0, color: .green)
}
