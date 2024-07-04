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
        VStack(alignment: .leading) {
            Row(title: Strings.dailyNutritionalValuesCarbohydrate, value: "\(report.totalNutritionalValues.carbohydrate)/\(dailyConsumation.carbohydrate)")
            Row(title: Strings.dailyNutritionalValuesProtein, value: "\(report.totalNutritionalValues.protein)/\(dailyConsumation.protein)")
            Row(title: Strings.dailyNutritionalValuesFat, value: "\(report.totalNutritionalValues.fat)/\(dailyConsumation.fat)")
        }
    }
    
    struct Row: View {
        
        let title: String
        let value: String
        
        var body: some View {
            HStack {
                Text(title)
                    .font(.headline)
                
                Text(value)
                    .font(.subheadline)
            }
        }
    }
}
