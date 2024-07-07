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
        Text(meal.description)
            .font(.subheadline) +
        Text(" ") +
        Text(meal.nutritionalValueString)
            .font(.caption)
    }
}
