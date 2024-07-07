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
    
    @EnvironmentObject var router: Router
    @Environment(\.modelContext) var modelContext: ModelContext
    @State private var searchString: String = ""
    
    @Bindable var meal: Meal
    @Query(sort: \Dish.name) var dishes: [Dish]
    @Query(sort: \Category.name) var categories: [Category]
    
    @State private var selectedFilter: Filter = .favorites
    
    var filteredDishes: [Dish] {
        dishes.filter {
            if searchString.isEmpty {
                switch selectedFilter {
                case .category(let categoryType):
                    if categoryType == .all || $0.category?.type == categoryType {
                        return true
                    }
                case .favorites:
                    if $0.isFavorite {
                        return true
                    }
                }
                return false
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        }
    }
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    var body: some View {
        
        list
            .backButton {
                validateMeal()
            }
            .navigationTitle(Strings.dishesSectionTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem {
                    Picker("", selection: $selectedFilter) {
                        ForEach(CategoryType.allCases, id: \.rawValue) {
                            Text($0.rawValue)
                                .tag(Filter.category($0))
                        }
                        Text(Strings.favoritesTitle)
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
            .onAppear {
                if filteredDishes.isEmpty && searchString.isEmpty {
                    selectedFilter = .category(.all)
                }
            }
    }
    
    var list: some View {
        List {
            ForEach(filteredDishes) { dish in
                DishCellView(dish: dish,
                             meal: $meal,
                             isSelected: meal.dishes.contains(dish),
                             onEditButtonTap: {
                    router.navigate(to: .dishView(dish))
                })
            }
            .onDelete(perform: deleteDish)
        }
        .searchable(text: $searchString)
        .autocorrectionDisabled()
    }
    
    func addReport() {
        let dish = Dish()
        router.navigate(to: .dishView(dish))
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
        router.navigateBack()
    }
}
