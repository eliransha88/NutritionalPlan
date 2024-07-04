//
//  Router + Destination.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import Foundation

extension Router {
    
    enum Destination: Hashable {
        case mealView(_ meal: Meal)
        case dishView(_ dish: Dish, isEditing: Bool = true)
        case selectDishCategory(_ dish: Dish)
        case dailyReportView(_ dailyRpeort: DailyReport)
        case settings
        case menu
        case menuByCategory(Category)
    }
}
