//
//  DishView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import SwiftUI
import SwiftData
import Combine
import SFSafeSymbols

class DishViewModel: ObservableObject {
    
    @Published var amount: String
    @Published var isEditing: Bool
    
    @Published var carbohydrate: String
    @Published var protein: String
    @Published var fat: String
    
    @Published var isAlertPresented: Bool = false
    
    @Bindable var dish: Dish
    var nutritionalValues: NutritionalValues
    var saveDishSubject: PassthroughSubject<Dish, Never> = .init()
    lazy var saveDishPublisher: AnyPublisher<Dish, Never> = saveDishSubject.eraseToAnyPublisher()
    
    var cancellables: Set<AnyCancellable> = .init()
    
    init(dish: Dish, isEditing: Bool) {
        self.dish = dish
        self.nutritionalValues = dish.nutritionalValues ?? .init(dish: dish)
        self.amount = dish.amount.asString
        self.carbohydrate = nutritionalValues.carbohydrate.asString
        self.protein = nutritionalValues.protein.asString
        self.fat = nutritionalValues.fat.asString
        self.isEditing = isEditing
        setupObservables()
    }
    
    func setupObservables() {
        $amount
            .compactMap({ Double($0) })
            .sink { [weak self] in
                self?.dish.amount = $0
            }
            .store(in: &cancellables)
        
        $carbohydrate
            .compactMap({ Double($0) })
            .sink { [weak self] in
                self?.nutritionalValues.carbohydrate = $0
            }
            .store(in: &cancellables)
        
        $protein
            .compactMap({ Double($0) })
            .sink { [weak self] in
                self?.nutritionalValues.protein = $0
            }
            .store(in: &cancellables)
        
        $fat
            .compactMap({ Double($0) })
            .sink { [weak self] in
                self?.nutritionalValues.fat = $0
            }
            .store(in: &cancellables)
    }
    
    func onEditButtonTap() {
        if isEditing {
            validateDish()
        } else {
            withAnimation {
                isEditing.toggle()
            }
        }
    }
    
    func validateDish() {
        if dish.isValidate {
            dish.nutritionalValues = nutritionalValues
            saveDishSubject.send(dish)
            withAnimation{
                isEditing.toggle()
            }
        } else {
            isAlertPresented = true
        }
    }
}

struct DishView: View {
    
    enum Field: Int {
        case name
        case amount
        case unit
        case notes
        case carbohydrate
        case protein
        case fat
        
        var nextField: Field? {
            Field(rawValue: rawValue + 1)
        }
        
        var previousField: Field? {
            Field(rawValue: rawValue - 1)
        }
    }
    
    @StateObject private var viewModel: DishViewModel
    
    @EnvironmentObject var router: Router
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query var categories: [Category]
    
    @FocusState private var focusedField: Field?
        
    init(isEditing: Bool,
         dish: Dish) {
        self._viewModel = StateObject(wrappedValue: DishViewModel(dish: dish,
                                                                  isEditing: isEditing))
    }
    
    var body: some View {
        Form {
            detailsSection
            notesSection
            nutritionalValuesSection
        }
        .toolbar {
            ToolbarItem {
                Button(viewModel.isEditing ? Strings.editButtonTitle : Strings.saveButtonTitle,
                       action: viewModel.onEditButtonTap)
            }
            
            ToolbarItemGroup(placement: .keyboard) {
                Button("", systemImage: SFSymbol.chevronUp.rawValue) {
                    focusedField = focusedField?.previousField
                }
                .disabled(focusedField == .name)
                
                Button("", systemImage: SFSymbol.chevronDown.rawValue) {
                    focusedField = focusedField?.nextField
                }
                .disabled(focusedField == .fat)
                
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
        Section(Strings.dishDetails) {
            EditTextField(title: Strings.dishName,
                          text: $viewModel.dish.name,
                          isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .name)
            .textContentType(.name)
            .submitLabel(.next)
            
            EditTextField(title: Strings.dishAmout,
                          keyboardType: .decimalPad,
                          text: $viewModel.amount,
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
                    
                    Image(systemSymbol: .chevronRight)
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
        Section("הערות") {
            TextEditor(text: $viewModel.dish.note)
                .frame(minHeight: 100)
                .disabled(!viewModel.isEditing)
                .focused($focusedField, equals: .notes)
        }
    }
    
    var nutritionalValuesSection: some View {
        Section(Strings.nutritionalValues) {
            EditTextField(title: Strings.nutritionalValuesCarbohydrate,
                          keyboardType: .decimalPad,
                          text: $viewModel.carbohydrate,
                          isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .carbohydrate)
            
            EditTextField(title: Strings.nutritionalValuesProtein,
                          keyboardType: .decimalPad,
                          text: $viewModel.protein,
                          isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .protein)
            
            EditTextField(title: Strings.nutritionalValuesFat,
                          keyboardType: .decimalPad,
                          text: $viewModel.fat,
                          isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .fat)
        }
    }
}
