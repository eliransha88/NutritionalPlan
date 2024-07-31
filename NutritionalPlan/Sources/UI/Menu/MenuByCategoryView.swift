//
//  MenuByCategoryView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI
import SFSafeSymbols
struct MenuByCategoryView: View {
        
    @Environment(\.modelContext) var modelContext
    @Environment(Router.self) var router
    @State private var searchString: String = ""
    @State private var sortDescriptor: SortDescriptor = SortDescriptor(\Dish.name)
    
    let category: Category
    
    var filteredDishes: [Dish] {
        guard let dishes = category.dishes else {
            return []
        }
        let filteredDishes = searchString.isEmpty ? dishes : dishes.filter({ $0.name.localizedStandardContains(searchString) })
        return filteredDishes.sorted(using: sortDescriptor)
    }
    
    var body: some View {
        
        List {
            ForEach(filteredDishes) { dish in
                MenuDishCell(dish: dish)
                    .onTapGesture {
                        router.navigate(to: .dishView(dish))
                    }
            }
            .onDelete(perform: deleteDish(at:))
            .listRowInsets(.init(inset: 12.0))
        }
        .listRowSpacing(12.0)
        .searchable(text: $searchString)
        .autocorrectionDisabled()
        .backButton {
            router.navigateBack()
        }
        .navigationTitle(category.name)
        .toolbar {
            ToolbarItem {
                Menu("", systemImage: SFSymbol.arrowUpArrowDown.rawValue) {
                    Picker("sort", selection: $sortDescriptor) {
                        Text(Strings.dishName)
                            .tag(SortDescriptor(\Dish.name))
                        
                        Text(Strings.dishAmout)
                            .tag(SortDescriptor(\Dish.amount, order: .reverse))
                    }
                }
            }
            
            ToolbarItem {
                Button("",
                       systemImage: SFSymbol.plus.rawValue,
                       action: addDish)
            }
        }
    }
    
    func addDish() {
        let dish = Dish()
        dish.category = category
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
    
}

struct MenuDishCell: View {
    
    let dish: Dish
    
    var body: some View {
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
