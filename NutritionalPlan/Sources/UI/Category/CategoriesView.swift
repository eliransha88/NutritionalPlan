//
//  CategoriesView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 30/06/2024.
//

import SwiftUI
import SwiftData
import SFSafeSymbols

struct CategoriesView: View {

    @Environment(Router.self) var router
    @Environment(\.modelContext) var modelContext: ModelContext
    @State private var searchString: String = ""
    @State private var newCategoryName: String = ""
    @State private var isNewCategoryAlertPresented: Bool = false
    
    @Bindable var dish: Dish
    
    var body: some View {
        CategoriesListView(searchString: searchString,
                           selectedCategory: dish.category,
                           onCategoryTap: select(category:))
        .navigationTitle(Strings.categoriesViewTitle)
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem {
                Button("",
                       systemImage: SFSymbol.plus.rawValue) {
                    newCategoryName = ""
                    isNewCategoryAlertPresented = true
                }
            }
        }
        .alert("", isPresented: $isNewCategoryAlertPresented) {
            TextField(Strings.addCategoryAlertTextfieldPlaceholder, text: $newCategoryName)
            Button(Strings.addCategoryAlertMessage) {
                addCategory()
            }
            .disabled(newCategoryName.isEmpty)
        } message: {
            Text(Strings.addCategoryAlertButtonTitle)
        }
    }

    
    func addCategory() {
        let category = Category(type: .unknown, name: newCategoryName)
        category.dishes?.append(dish)
        modelContext.insert(category)
    }
    
    func select(category: Category) {
        dish.category = category
        router.navigateBack()
    }
}
