//
//  NutrutionChart.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 02/08/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import SwiftUI
import Charts

struct NutrutionChart: View {
    
    @Environment(\.layoutDirection) var layoutDirection
    
    let data: [NutrutionChartData]
    let goal: Double
    let color: Color
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Chart {
                
                RuleMark(y: .value("Goal", goal))
                    .lineStyle(.init(lineWidth: 1.0, dash: [5]))
                    .foregroundStyle(color.opacity(0.4))
                
                ForEach(data) {
                    BarMark(
                        x: .value("Date", $0.date.dayName),
                        y: .value("Amount", $0.amount)
                    )
                    .foregroundStyle(color.gradient)
                }
            }
            .frame(height: 100)
            .padding()
            
            HStack {
                Image(systemSymbol: .lineDiagonal)
                    .rotationEffect(.degrees(layoutDirection == .rightToLeft ? -45.0 : 45.0))
                    .foregroundStyle(color)
                
                Text(Strings.goal)
                    .foregroundStyle(.secondary)

            }
            .font(.caption2)
            .padding(.leading, 4.0)
        }
        .padding()
    }
    
}
