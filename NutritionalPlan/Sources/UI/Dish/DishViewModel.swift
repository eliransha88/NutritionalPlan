//
//  DishViewModel.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import Foundation
import Combine
import SwiftUI
import Observation

@Observable class DishViewModel {
    
    var isEditing: Bool
    var isAlertPresented: Bool = false
    
    var dish: Dish
    var nutritionalValues: NutritionalValues
    
    @ObservationIgnored
    var saveDishSubject: PassthroughSubject<Dish, Never> = .init()
    @ObservationIgnored
    lazy var saveDishPublisher: AnyPublisher<Dish, Never> = saveDishSubject.eraseToAnyPublisher()
    @ObservationIgnored
    var cancellables: Set<AnyCancellable> = .init()
    
    let amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        return formatter
    }()
    
    init(dish: Dish, isEditing: Bool) {
        self.dish = dish
        self.nutritionalValues = dish.nutritionalValues ?? .init(dish: dish)
        self.isEditing = isEditing
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
