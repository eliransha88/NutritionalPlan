//
//  MealCellView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 07/07/2024.
//

import SwiftUI

struct MealCellView: View {
    
    let meal: Meal
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(meal.description)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
            
            Text(meal.nutritionalValueString)
                .font(.caption)
                .multilineTextAlignment(.leading)
        }
        .padding(.vertical, 4.0)
    }
}
