//
//  DailyNutritionalValuesView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI

struct DailyNutritionalValuesView: View {
    
    let report: DailyReport
    let dailyConsumation: DailtReportNutritionalValues
    
    init(report: DailyReport) {
        self.report = report
        self.dailyConsumation = report.dailyConsumation ?? .defaultValues(with: report)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.0) {
                Row(title: Strings.dailyNutritionalValuesCarbohydrate,
                    value: "\(report.totalNutritionalValues.carbohydrate)/\(dailyConsumation.carbohydrate)",
                    color: .green
                )
                Row(title: Strings.dailyNutritionalValuesProtein,
                    value: "\(report.totalNutritionalValues.protein)/\(dailyConsumation.protein)",
                    color: .red)
                Row(title: Strings.dailyNutritionalValuesFat,
                    value: "\(report.totalNutritionalValues.fat)/\(dailyConsumation.fat)",
                    color: .blue)
            }
            
            Spacer()
            
            DailyNutritionalProgressBarView(report: report,
                                            dailyConsumation: dailyConsumation)
            .padding()
        }
        .padding()
        .background(Color.secondary.opacity(0.2))
    }
    
    struct Row: View {
        
        let title: String
        let value: String
        let color: Color
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                
                Text(value)
                    .font(.subheadline)
                    .foregroundStyle(color)
            }
        }
    }
}
