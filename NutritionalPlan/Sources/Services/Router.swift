//
//  Router.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    
    public enum Destination: Hashable {
        case mealView(_ meal: Meal)
        case dishView(_ dish: Dish, isEditing: Bool = true)
        case selectDishCategory(_ dish: Dish)
        case dailyReportView(_ dailyRpeort: DailyReport)
        case settings
    }
    
    @Published var navigationPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
