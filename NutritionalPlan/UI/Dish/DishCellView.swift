//
//  DishCellView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 03/07/2024.
//

import SwiftUI
import SFSafeSymbols

struct DishCellView: View {
    
    @State private var isSelected: Bool
    
    @Bindable var meal: Meal
    let dish: Dish
    let onEditButtonTap: VoidHandler
    
    init(dish: Dish,
         meal: Bindable<Meal>,
         isSelected: Bool,
         onEditButtonTap: @escaping VoidHandler) {
        self._isSelected = State(wrappedValue: isSelected)
        self.dish = dish
        self._meal = meal
        self.onEditButtonTap = onEditButtonTap
    }
    
    var body: some View {
        HStack(spacing: 0) {
            
            Button {
                dish.isFavorite.toggle()
            } label: {
                Image(systemSymbol: dish.isFavorite ? .starFill : .star)
                    .resizable()
                    .foregroundStyle(isSelected ? .green : .primary)
                    .padding(4.0)
                    .frame(width: 32, height: 32)
            }
            
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
            
            Spacer()
            
            Button {
                isSelected.toggle()
            } label: {
                Image(systemName: isSelected ? "checkmark.circle" : "circle")
                    .resizable()
                    .foregroundStyle(isSelected ? .green : .primary)
                    .padding(4.0)
                    .frame(width: 32, height: 32)
            }
        }
        .swipeActions(edge: .leading) {
            Button("ערוך") {
                onEditButtonTap()
            }
            .tint(.green)
        }
        .onChange(of: isSelected) { _, newValue in
            if newValue {
                meal.dishes.append(dish)
            } else if let index = meal.dishes.firstIndex(of: dish) {
                meal.dishes.remove(at: index)
            }
        }
    }
}

