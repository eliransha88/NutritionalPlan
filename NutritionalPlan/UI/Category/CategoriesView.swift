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

    @EnvironmentObject var router: Router
    @Environment(\.modelContext) var modelContext: ModelContext
    @State private var searchString: String = ""
    @State private var newCategoryName: String = ""
    @State private var isNewCategoryAlertPresented: Bool = false
    
    @Bindable var dish: Dish
    
    var body: some View {
        CategoriesListView(dish: dish,
                           searchString: searchString)
        .navigationTitle("בחר קטגוריה")
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
            TextField("שם הקטגוריה", text: $newCategoryName)
            Button("צור") {
                addCategory()
            }
            .disabled(newCategoryName.isEmpty)
        } message: {
            Text("הכנס את שם הקטגוריה")
        }
    }

    
    func addCategory() {
        let category = Category(type: .unknown, name: newCategoryName)
        category.dishes?.append(dish)
        modelContext.insert(category)
    }
}
