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
    
    var saveDishSubject: PassthroughSubject<Dish, Never> = .init()
    lazy var saveDishPublisher: AnyPublisher<Dish, Never> = saveDishSubject.eraseToAnyPublisher()
    
    var cancellables: Set<AnyCancellable> = .init()
    
    init(dish: Dish, isEditing: Bool) {
        self.dish = dish
        self.amount = dish.amount.asString
        self.carbohydrate = dish.nutritionalValues?.carbohydrate.asString ?? ""
        self.protein = dish.nutritionalValues?.protein.asString ?? ""
        self.fat = dish.nutritionalValues?.fat.asString ?? ""
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
                self?.dish.nutritionalValues?.carbohydrate = $0
            }
            .store(in: &cancellables)
        
        $protein
            .compactMap({ Double($0) })
            .sink { [weak self] in
                self?.dish.nutritionalValues?.protein = $0
            }
            .store(in: &cancellables)
        
        $fat
            .compactMap({ Double($0) })
            .sink { [weak self] in
                self?.dish.nutritionalValues?.fat = $0
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
    
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query var categories: [Category]
    @Binding var navigationPath: NavigationPath
    
    @FocusState private var focusedField: Field?
        
    init(isEditing: Bool,
         dish: Dish,
         navigationPath: Binding<NavigationPath>) {
        self._viewModel = StateObject(wrappedValue: DishViewModel(dish: dish, isEditing: isEditing))
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        Form {
            detailsSection
            notesSection
            nutritionalValuesSection
        }
        .toolbar {
            ToolbarItem {
                Button(viewModel.isEditing ? "שמירה" : "עריכה",
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
                
                Button("סיים") {
                    focusedField = nil
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .alert("שגיאה", isPresented: $viewModel.isAlertPresented) {
            Button(role: .cancel, action: {}, label: { Text("אוקי") })
        } message: {
            Text("אנא מלא את כל הפרטים הנדרשים: שם המנה, כמות וקטגוריה.")
                .font(.subheadline)
        }
        .onReceive(viewModel.saveDishPublisher, perform: { dish in
            modelContext.insert(dish)
        })
        .onSubmit {
            focusedField = focusedField?.nextField
        }
        .navigationDestination(for: Category?.self) { _ in
            CategoriesView(dish: viewModel.dish,
                           navigationPath: $navigationPath)
        }
    }
    
    var detailsSection: some View {
        Section("פרטי המנה") {
            EditTextField(title: "שם המנה",
                          placeholder: "הכנס שם",
                          text: $viewModel.dish.name,
                          isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .name)
            .textContentType(.name)
            .submitLabel(.next)
            
            EditTextField(title: "כמות",
                          placeholder: "הכנס כמות",
                          keyboardType: .decimalPad,
                          text: $viewModel.amount,
                          isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .amount)
            
            EditTextField(title: "מידת שקילה",
                          placeholder: "הכנס מידת שקילה",
                          text: $viewModel.dish.unit,
                          isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .unit)
            .submitLabel(.next)
            
            if viewModel.isEditing {
                HStack {
                  Text("קטגוריה:")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(viewModel.dish.category?.name ?? "לא ידוע")
                    
                    Image(systemSymbol: .chevronRight)
                }
                .onTapGesture {
                    navigationPath.append(viewModel.dish.category)
                }
            } else if let categoryName = viewModel.dish.category?.name  {
                HStack(spacing: 8.0) {
                    Text("קטגוריה" + ":")
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
        Section("ערכיים תזונתיים") {
            EditTextField(title: "פחמימה",
                          placeholder: "הכנס ערך",
                          keyboardType: .decimalPad,
                          text: $viewModel.carbohydrate,
                          isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .carbohydrate)
            
            EditTextField(title: "חלבון",
                          placeholder: "הכנס ערך",
                          keyboardType: .decimalPad,
                          text: $viewModel.protein,
                          isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .protein)
            
            EditTextField(title: "שומן",
                          placeholder: "הכנס ערך",
                          keyboardType: .decimalPad,
                          text: $viewModel.fat,
                          isEditable: viewModel.isEditing)
            .focused($focusedField, equals: .fat)
        }
    }
}
