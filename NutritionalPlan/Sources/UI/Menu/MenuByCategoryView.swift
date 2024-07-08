//
//  MenuByCategoryView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI

struct MenuByCategoryView: View {
    
    @Environment(Router.self) var router
    let category: Category
    
    var body: some View {
        
        List {
            ForEach(category.dishes ?? []) { dish in
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
        }
        .backButton {
            router.navigateBack()
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

