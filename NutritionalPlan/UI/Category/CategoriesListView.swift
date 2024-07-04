//
//  CategoriesListView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 03/07/2024.
//

import SwiftUI
import SwiftData
import SFSafeSymbols

struct CategoriesListView: View {
    
    @EnvironmentObject var router: Router
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query() var categories: [Category]
    
    @Bindable var dish: Dish
    
    init(dish: Dish,
         searchString: String) {
        self.dish = dish
        self._categories = Query(filter: #Predicate { category in
           if searchString.isEmpty {
               true
           } else {
               category.name.localizedStandardContains(searchString)
           }
       }, sort: \Category.name)
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
                                
                                if dish.category == category {
                                    Image(systemSymbol: .checkmark)
                                        .resizable()
                                        .foregroundStyle(Color.green)
                                        .frame(width: 16, height: 16)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                dish.category = category
                                router.navigateBack()
                            }
                        }
                    }
                }
            }
        }
    }
}

