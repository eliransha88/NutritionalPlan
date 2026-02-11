//
//  MealCounter.swift
//  NutritionalPlanHome
//
//  Created by Eliran Sharabi on 24/07/2025.
//

import SwiftUI
import NutritionalPlanCore

struct MealCounter: View {
    
    @Bindable var report: DailyReport
    
    var body: some View {
        VStack(spacing: 4) {

            Stepper(
                value: $report.mealCounterConsumation.carbohydrate,
                in: 0...100,
                step: 0.5
            ) {
                Text(String(format:"%@: %.1f", Strings.nutritionalValuesCarbohydrate,
                            report.mealCounterConsumation.carbohydrate))
                    .font(.caption)
            }
            
            // Protein Stepper
            Stepper(
                value: $report.mealCounterConsumation.protein,
                in: 0...100,
                step: 0.5
            ) {
                Text(String(format:"%@: %.1f", Strings.nutritionalValuesProtein,
                            report.mealCounterConsumation.protein))
                    .font(.caption)
            }
            
            // Fat Stepper
            Stepper(
                value: $report.mealCounterConsumation.fat,
                in: 0...100,
                step: 0.5
            ) {
                Text(String(format:"%@: %.1f", Strings.nutritionalValuesFat,
                            report.mealCounterConsumation.fat))
                    .font(.caption)
            }
        }
        .padding()
    }
}
