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
    
    @Query() var categories: [Category]
        
    var selectedCategory: Category?
    var onCategoryTap: (Category) -> Void
    
    init(searchString: String,
         selectedCategory: Category?,
         onCategoryTap: @escaping (Category) -> Void) {
        self._categories = Query(filter: #Predicate { category in
           if searchString.isEmpty {
               true
           } else {
               category.name.localizedStandardContains(searchString)
           }
       }, sort: \Category.name)
        self.onCategoryTap = onCategoryTap
    }
    
    var body: some View {
        List {
            let sections = Dictionary(grouping: categories, by: \.type)
            ForEach(Array(CategoryType.allCases), id: \.rawValue) { key in
                if let categories = sections[key],
                   !categories.isEmpty {
                    SectionView(key.title) {
                        ForEach(categories) { category in
                            HStack {
                                Text(category.name)
                                Spacer()
                                
                                if selectedCategory == category {
                                    Image(systemSymbol: .checkmark)
                                        .resizable()
                                        .foregroundStyle(Color.green)
                                        .frame(width: 16, height: 16)
                                }
                            }
                            .padding()
                            .contentShape(Rectangle())
                            .onTapGesture {
                                onCategoryTap(category)
                            }
                        }
                    }
                }
            }
            .listRowInsets(.init(inset: 12.0))
        }
        .listRowSpacing(8.0)
    }
}

