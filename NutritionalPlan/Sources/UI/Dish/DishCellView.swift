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
    let onDuplicateButtonTap: VoidHandler
    
    init(dish: Dish,
         meal: Bindable<Meal>,
         isSelected: Bool,
         onEditButtonTap: @escaping VoidHandler,
         onDuplicateButtonTap: @escaping VoidHandler) {
        self._isSelected = State(wrappedValue: isSelected)
        self.dish = dish
        self._meal = meal
        self.onEditButtonTap = onEditButtonTap
        self.onDuplicateButtonTap = onDuplicateButtonTap
    }
    
    var body: some View {
        HStack(spacing: 8.0) {

            Image(systemSymbol: dish.isFavorite ? .starFill : .star)
                .resizable()
                .foregroundStyle(dish.isFavorite ? Colors.green : .primary)
                .padding(4.0)
                .frame(width: 32, height: 32)
                .onTapGesture {
                    withAnimation {
                        dish.isFavorite.toggle()
                    }
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
                withAnimation {
                    isSelected.toggle()
                }
            } label: {
                Image(systemSymbol: isSelected ? .checkmarkCircle : .plusCircle)
                        .resizable()
                        .foregroundStyle(isSelected ? Colors.green : .primary)
                        .padding(4.0)
                        .frame(width: 32, height: 32)
            }
        }
        .swipeActions(edge: .leading) {
            Button(Strings.editButtonTitle) {
                onEditButtonTap()
            }
            .tint(Colors.green)
            
            Button(Strings.duplicateDishItem) {
                onDuplicateButtonTap()
            }
            .tint(Colors.teal)
        }
        .onChange(of: isSelected) { _, newValue in
            if newValue {
                meal.dishes?.append(dish)
            } else if let index = meal.dishes?.firstIndex(of: dish) {
                meal.dishes?.remove(at: index)
            }
        }
        .padding(.vertical, 4.0)
    }
}

