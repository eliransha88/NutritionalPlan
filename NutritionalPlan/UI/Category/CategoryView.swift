//
//  CategoryView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 30/06/2024.
//

import SwiftUI
import SwiftData

struct CategoryView: View {
    
    @Environment(\.modelContext) var modelContext: ModelContext
    
    @Bindable var meal: Meal
    @Bindable var category: Category
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        DishesListView(meal: meal,
                       navigationPath: $navigationPath)
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
        .backButton {
            validateMeal()
        }
    }
    
    func validateMeal() {
        if meal.dishes.isEmpty {
            modelContext.delete(meal)
        }
        navigationPath.removeLast()
    }
}
