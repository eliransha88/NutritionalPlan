//
//  DishView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import SwiftUI
import SwiftData
import SFSafeSymbols

struct DishView: View {
    
    struct Constants {
        static let rowInsets: EdgeInsets = .init(top: 0, leading: 12.0, bottom: 0, trailing: 12.0)
    }
    
    enum Field: Int, CaseIterable {
        case name
        case amount
        case unit
        case carbohydrate
        case protein
        case fat
        case notes
        
        var nextField: Field? {
            Field(rawValue: rawValue + 1)
        }
        
        var previousField: Field? {
            Field(rawValue: rawValue - 1)
        }
    }
    
    @State private var viewModel: DishViewModel
    
    @Environment(Router.self) var router
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query var categories: [Category]
    
    @FocusState private var focusedField: Field?
    
    init(isEditing: Bool,
         dish: Dish) {
        self._viewModel = State(wrappedValue: DishViewModel(dish: dish,
                                                            isEditing: isEditing))
    }
    
    var body: some View {
        Form {
            detailsSection
            nutritionalValuesSection
            notesSection
        }
        .toolbar {
            ToolbarItem {
                Button(viewModel.isEditing ? Strings.saveButtonTitle : Strings.editButtonTitle,
                       action: viewModel.onEditButtonTap)
            }
            
            ToolbarItemGroup(placement: .keyboard) {
                Button("", systemImage: SFSymbol.chevronUp.rawValue) {
                    focusedField = focusedField?.previousField
                }
                .disabled(focusedField == Field.allCases.first)
                
                Button("", systemImage: SFSymbol.chevronDown.rawValue) {
                    focusedField = focusedField?.nextField
                }
                .disabled(focusedField == Field.allCases.last)
                
                Spacer()
                
                Button(Strings.doneButton) {
                    focusedField = nil
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .alert(Strings.saveDishErrorTitle, isPresented: $viewModel.isAlertPresented) {
            Button(role: .cancel, action: {}, label: { Text(Strings.saveDishErrorButton) })
        } message: {
            Text(Strings.saveDishErrorMessage)
                .font(.subheadline)
        }
        .onReceive(viewModel.saveDishPublisher, perform: { dish in
            modelContext.insert(viewModel.nutritionalValues)
            modelContext.insert(dish)
        })
        .onSubmit {
            focusedField = focusedField?.nextField
        }
    }
    
    var detailsSection: some View {
        SectionView(Strings.dishDetails, rowInsets: Constants.rowInsets) {
            EditTextField(title: Strings.dishName,
                          text: $viewModel.dish.name,
                          isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .name)
            .textContentType(.name)
            .submitLabel(.next)
            
            EditDoubleTextField(title: Strings.dishAmout,
                                keyboardType: .decimalPad,
                                text: $viewModel.dish.amount,
                                formatter: viewModel.amountFormatter,
                                isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .amount)
            
            EditTextField(title: Strings.dishUnit,
                          text: $viewModel.dish.unit,
                          isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .unit)
            .submitLabel(.next)
            
            if viewModel.isEditing {
                HStack {
                    Text(Strings.category)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(viewModel.dish.category?.name ?? Strings.unknownCategory)
                    
                    AccessoryItem(style: .arrow)
                }
                .onTapGesture {
                    router.navigate(to: .selectDishCategory(viewModel.dish))
                }
            } else if let categoryName = viewModel.dish.category?.name  {
                HStack(spacing: 8.0) {
                    Text(Strings.category)
                        .font(.headline)
                    
                    Text(categoryName)
                        .font(.subheadline)
                }
            }
        }
    }
    
    var notesSection: some View {
        SectionView(Strings.addDishNotes, rowInsets: Constants.rowInsets) {
            TextEditor(text: $viewModel.dish.note)
                .frame(minHeight: 100)
                .disabled(!viewModel.isEditing)
                .focused($focusedField, equals: .notes)
        }
    }
    
    var nutritionalValuesSection: some View {
        SectionView(Strings.nutritionalValues, rowInsets: Constants.rowInsets) {
            EditDoubleTextField(title: Strings.nutritionalValuesCarbohydrate,
                                keyboardType: .decimalPad,
                                text: $viewModel.nutritionalValues.carbohydrate,
                                formatter: viewModel.amountFormatter,
                                isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .carbohydrate)
            
            EditDoubleTextField(title: Strings.nutritionalValuesProtein,
                                keyboardType: .decimalPad,
                                text: $viewModel.nutritionalValues.protein,
                                formatter: viewModel.amountFormatter,
                                isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .protein)
            
            EditDoubleTextField(title: Strings.nutritionalValuesFat,
                                keyboardType: .decimalPad,
                                text: $viewModel.nutritionalValues.fat,
                                formatter: viewModel.amountFormatter,
                                isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .fat)
        }
    }
}
