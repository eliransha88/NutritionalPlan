//
//  MenuView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        CategoriesListView(searchString: "",
                           selectedCategory: nil,
                           onCategoryTap: select(category:))
        .navigationTitle(Strings.menuTitle)
    }
    
    func select(category: Category) {
        router.navigate(to: .menuByCategory(category))
    }
}

#Preview {
    
    let previewer = try? Previewer()
    return NavigationStack {
        MenuView()
            .modelContainer(previewer!.container)
    }
    
}
