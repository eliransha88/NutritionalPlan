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
    
    enum Filter: Equatable, Hashable {
        case category(CategoryType)
        case favorites
    }
    
    @Environment(\.modelContext) var modelContext: ModelContext
    @State private var searchString: String = ""
    
    @Bindable var meal: Meal
    @Binding var navigationPath: NavigationPath
    @Query(sort: \Dish.name) var dishes: [Dish]
    @Query(sort: \Category.name) var categories: [Category]
    
    @State private var selectedFilter: Filter = .category(.all)
    
    var filteredDishes: [Dish] {
        dishes.filter {
            switch selectedFilter {
            case .category(let categoryType):
                if categoryType != .all && $0.category?.type != categoryType {
                    return false
                }
            case .favorites:
                if !$0.isFavorite {
                    return false
                }
            }
            return searchString.isEmpty ? true : $0.name.localizedStandardContains(searchString)
        }
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
                    Picker("", selection: $selectedFilter) {
                        ForEach(CategoryType.allCases, id: \.rawValue) {
                            Text($0.rawValue)
                                .tag(Filter.category($0))
                        }
                        Text("מעודפים")
                            .tag(Filter.favorites)
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
