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
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: progress)
                .overlay(alignment: .top) {
                    Image(systemSymbol: .arrowRight)
                        .resizable()
                        .scaledToFit()
                        .frame(size: Constants.arrowSize)
                        .padding(.top, -5)
                }
        }
    }
}

#Preview {
    CircularProgressBarView(progress: 0.6, color: .green)
}
