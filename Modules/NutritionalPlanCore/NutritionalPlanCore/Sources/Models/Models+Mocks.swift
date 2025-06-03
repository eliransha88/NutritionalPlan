//
//  Models+Mocks.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import Foundation

public extension DailyReport {
    static let mock: DailyReport = .init(meals: [.mock, .mock], dailyConsumation: .defaultValues())
}

public extension Meal {
    static var mock: Meal = .init(dishes: [.carbohydrateMock, .fatMock])
}

public extension Category {
    static let carbohydrateMock: Category = .init(type: .carbohydrate, name: "לחמים", dishes: [.carbohydrateMock])
    static let proteinMock: Category = .init(type: .protein, name: "בשרי", dishes: [.proteinMock])
    static let fatMock: Category = .init(type: .fat, name: "שומן", dishes: [.fatMock])
}

public extension Dish {
    static let carbohydrateMock: Dish = .init(name: "פיתה קלה", amount: 1, unit: "יחידה", nutritionalValues: .carbohydrateMock)
    static let proteinMock: Dish = .init(name: "סינטה", amount: 200, nutritionalValues: .proteinMock)
    static let fatMock: Dish = .init(name: "טחינה גולמית", amount: 1, nutritionalValues: .fatMock)
}

public extension NutritionalValues {
    static let carbohydrateMock: NutritionalValues = .init(carbohydrate: 1, protein: 0, fat: 0)
    static let proteinMock: NutritionalValues = .init(carbohydrate: 0, protein: 1, fat: 0)
    static let fatMock: NutritionalValues = .init(carbohydrate: 0, protein: 0, fat: 1)
}
