//
//  MenuByCategoryView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI

struct MenuByCategoryView: View {
    
    @Environment(Router.self) var router
    @State private var searchString: String = ""
    
    let category: Category
    
    var filteredDishes: [Dish] {
        guard let dishes = category.dishes else {
            return []
        }
        if searchString.isEmpty {
            return dishes
        } else {
            return dishes.filter({ $0.name.localizedStandardContains(searchString) })
        }
    }
    
    var body: some View {
        
        List {
            ForEach(filteredDishes) { dish in
                VStack(alignment: .leading, spacing: 0) {
                    Text(dish.description)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                    if dish.note.isNotEmpty {
                        Text(dish.note)
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                    }
                    Text(dish.nutritionalValues?.description ?? "")
                        .font(.caption)
                }
            }
            .listRowInsets(.init(inset: 12.0))
        }
        .listRowSpacing(12.0)
        .searchable(text: $searchString)
        .autocorrectionDisabled()
        .backButton {
            router.navigateBack()
        }
        .navigationTitle(category.name)
    }
}

