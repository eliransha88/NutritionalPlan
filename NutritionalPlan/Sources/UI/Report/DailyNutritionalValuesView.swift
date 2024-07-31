//
//  DailyNutritionalValuesView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI

struct DailyNutritionalValuesView: View {
    
    let report: DailyReport
    let dailyConsumation: DailyReportNutritionalValues
    
    init(report: DailyReport) {
        self.report = report
        self.dailyConsumation = report.dailyConsumation ?? .defaultValues(with: report)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.0) {
                Row(title: Strings.dailyNutritionalValuesCarbohydrate,
                    value: "\(report.totalNutritionalValues.carbohydrate)/\(dailyConsumation.carbohydrate)",
                    color: Colors.red1
                )
                Row(title: Strings.dailyNutritionalValuesProtein,
                    value: "\(report.totalNutritionalValues.protein)/\(dailyConsumation.protein)",
                    color: Colors.green1)
                Row(title: Strings.dailyNutritionalValuesFat,
                    value: "\(report.totalNutritionalValues.fat)/\(dailyConsumation.fat)",
                    color: Colors.teal1)
            }
            
            Spacer()
            
            DailyNutritionalProgressBarView(report: report,
                                            dailyConsumation: dailyConsumation)
            .padding()
        }
        .padding()
    }
    
    struct Row: View {
        
        let title: String
        let value: String
        let color: Color
        
        var body: some View {
            VStack(alignment: .leading, spacing: 2.0) {
                Text(title)
                    .font(.body)
                
                Text(value)
                    .font(.headline)
                    .foregroundStyle(color)
            }
        }
    }
}
