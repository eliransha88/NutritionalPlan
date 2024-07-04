//
//  DishViewModel.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import Foundation
import Combine
import SwiftUI

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
