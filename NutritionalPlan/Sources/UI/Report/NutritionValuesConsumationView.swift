//
//  NutritionValuesConsumationView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI

struct NutritionValuesConsumationView: View {
    
    let totalConsumation: NutritionalValues
    let consumation: DailyReportNutritionalValues
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.0) {
                Row(title: Strings.dailyNutritionalValuesCarbohydrate,
                    value: "\(totalConsumation.carbohydrate)/\(consumation.carbohydrate)",
                    color: Colors.red
                )
                Row(title: Strings.dailyNutritionalValuesProtein,
                    value: "\(totalConsumation.protein)/\(consumation.protein)",
                    color: Colors.green)
                Row(title: Strings.dailyNutritionalValuesFat,
                    value: "\(totalConsumation.fat)/\(consumation.fat)",
                    color: Colors.teal)
            }
            
            Spacer()
            
            NutritionValuesConsumationProgressView(totalConsumation: totalConsumation,
                                                   consumation: consumation)
            .padding()
        }
        .padding()
    }
}
