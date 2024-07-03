//
//  DishesView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 30/06/2024.
//

import SwiftUI
import SwiftData
import SFSafeSymbols

struct DishesListView: View {
    
    @Environment(\.modelContext) var modelContext: ModelContext
    @State private var searchString: String = ""
    
    @Bindable var meal: Meal
    @Binding var navigationPath: NavigationPath
    @Query(sort: \Dish.name) var dishes: [Dish]
    @Query(sort: \Category.name) var categories: [Category]
    
    @State private var selectedCategoryType: CategoryType = .all
    
    var filteredDishes: [Dish] {
        dishes.filter {
            guard selectedCategoryType == .all || $0.category?.type == selectedCategoryType else {
                return false
            }
            return searchString.isEmpty ? true : $0.name.localizedStandardContains(searchString)
        }
    }
    
    var filteredCategories: [Category] {
        guard selectedCategoryType == .all else {
            return categories
        }
        return categories.filter({ $0.type == selectedCategoryType })
    }
    
    init(meal: Meal,
         navigationPath: Binding<NavigationPath>) {
        self.meal = meal
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        
        list
            .backButton {
                validateMeal()
            }
            .navigationTitle("מנות")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem {
                    Picker("", selection: $selectedCategoryType) {
                        ForEach(CategoryType.allCases, id: \.rawValue) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                }
                
                ToolbarItem {
                    Button("",
                           systemImage: SFSymbol.plus.rawValue,
                           action: addReport)
                }
                
                ToolbarItem {
                    EditButton()
                }
            }
            .navigationDestination(for: Dish.self) {
                DishView(isEditing: true, dish: $0, navigationPath: $navigationPath)
            }
    }
    
    var list: some View {
        List {
            ForEach(filteredDishes) { dish in
                DishCellView(dish: dish,
                             meal: $meal,
                             isSelected: meal.dishes.contains(dish),
                             onEditButtonTap: {
                    navigationPath.append(dish)
                })
            }
            .onDelete(perform: deleteDish)
        }
        .searchable(text: $searchString)
        .autocorrectionDisabled()
    }
    
    func addReport() {
        let dish = Dish()
        navigationPath.append(dish)
    }
    
    func deleteDish(at indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                let dish = filteredDishes[index]
                modelContext.delete(dish)
            }
        }
    }
    
    func validateMeal() {
        if meal.dishes.isEmpty {
            modelContext.delete(meal)
        }
        navigationPath.removeLast()
    }
}
