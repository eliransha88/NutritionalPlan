//
//  CategoriesView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 30/06/2024.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {

    @Environment(\.modelContext) var modelContext: ModelContext
    @State private var searchString: String = ""
    
    @Bindable var meal: Meal
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
       CategoriesListView(searchString: searchString,
                          navigationPath: $navigationPath)
        .navigationTitle("קטגוריות")
        .toolbarRole(.editor)
        .navigationDestination(for: Category.self) {
            CategoryView(meal: meal,
                         category: $0,
                         navigationPath: $navigationPath)
        }
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

struct CategoriesListView: View {
    
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query() var categories: [Category]
    
    @Binding var navigationPath: NavigationPath
    
    init(searchString: String,
         navigationPath: Binding<NavigationPath>) {
        self._categories = Query(filter: #Predicate { category in
           if searchString.isEmpty {
               true
           } else {
               category.name.localizedStandardContains(searchString)
           }
       }, sort: \Category.name)
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        List {
            let sections = Dictionary(grouping: categories, by: \.type)
            ForEach(Array(CategoryType.allCases), id: \.rawValue) { key in
                if let categories = sections[key],
                   !categories.isEmpty {
                    Section(key.rawValue) {
                        ForEach(categories) { category in
                            HStack {
                                Text(category.name)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                navigationPath.append(category)
                            }
                        }
                    }
                }
            }
        }
    }
}
