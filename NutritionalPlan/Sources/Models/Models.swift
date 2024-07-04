//
//  Models.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import Foundation
import SwiftData

typealias CategoryType = Category.CategoryType

@Model
final class DailyReport: Codable {
    let id: String = UUID().uuidString
    let date: Date
    var meals: [Meal]
    var dailyConsumation: DailtReportNutritionalValues?
    
    enum CodingKeys: String, CodingKey {
        case date, meals, dailyConsumation
    }
    
    var totalNutritionalValues: NutritionalValues {
        let dishesNutritionalValues = meals.compactMap({
            $0.dishes.compactMap({
                $0.nutritionalValues
            })
        }).flatMap({ $0 })
        return dishesNutritionalValues.reduce(into: .init()) { partialResult, value in
            partialResult.carbohydrate += value.carbohydrate
            partialResult.protein += value.protein
            partialResult.fat += value.fat
        }
    }
    
    var description: String {
        guard meals.isNotEmpty else {
            return "תאכל משהו שלא תהיה רעב"
        }
        
        return meals.map {
            $0.dishes.map { $0.name }
                .joined(separator: ", ")
            }
        .joined(separator: "\n")
    }
    
    var dateString: String {
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = .current
        return dateFormatter.string(from: date)
    }
    
    init(meals: [Meal] = []) {
        self.date = Date()
        self.meals = meals
        self.dailyConsumation = dailyConsumation
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
        self.meals = try container.decode([Meal].self, forKey: .meals)
        self.dailyConsumation = (try? container.decodeIfPresent(DailtReportNutritionalValues.self,
                                                                forKey: .dailyConsumation)) ?? DailtReportNutritionalValues.defaultValues(with: self)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(meals, forKey: .meals)
        try container.encode(dailyConsumation, forKey: .dailyConsumation)
    }
    
    func clearEmptyMeals() {
        meals.removeAll(where: { $0.dishes.isEmpty })
    }
}

@Model
final class Meal: Codable {
    let id: String = UUID().uuidString
    var dishes: [Dish]
    var report: DailyReport?
    
    enum CodingKeys: CodingKey {
        case dishes
    }
    
    var description: String {
        dishes.compactMap({ $0.name }).joined(separator: ", ")
    }
    
    init(dishes: [Dish] = [],
         report: DailyReport? = nil) {
        self.dishes = dishes
        self.report = report
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dishes = try container.decode([Dish].self, forKey: .dishes)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dishes, forKey: .dishes)
    }
}

final class NutritionalPlan: Codable {
    var carbohydrate: [Category]
    var protein: [Category]
    var fat: [Category]
    var other: [Category]
    
    var categories: [Category] {
        [carbohydrate, protein, fat, other].flatMap({ $0 })
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let carbohydrate = try container.decode([Category].self, forKey: .carbohydrate)
        let protein = try container.decode([Category].self, forKey: .protein)
        let fat = try container.decode([Category].self, forKey: .fat)
        let other = try container.decode([Category].self, forKey: .other)
        
        carbohydrate.forEach({ $0.type = .carbohydrate })
        protein.forEach({ $0.type = .protein })
        fat.forEach({ $0.type = .fat })
        other.forEach({ $0.type = .other })
        
        self.carbohydrate = carbohydrate
        self.protein = protein
        self.fat = fat
        self.other = other
    }
}

@Model
final class Category: Codable, Equatable {

    enum CategoryType: String, Codable, CaseIterable {
        case all = "הכל"
        case carbohydrate = "פחמימה"
        case protein = "חלבון"
        case fat = "שומן"
        case other = "לאכול בחוץ"
        case unknown = "אחר"
    }

    @Attribute(.unique) let id: String = UUID().uuidString
    var type: CategoryType
    var name: String
    var dishes: [Dish]? = []

    enum CodingKeys: CodingKey {
        case type, name, dishes
    }
    
    init(type: CategoryType,
         name: String,
         dishes: [Dish] = []) {
        self.type = type
        self.name = name
        self.dishes = dishes
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(CategoryType.self, forKey: .type) ?? .unknown
        self.name = try container.decode(String.self, forKey: .name)
        self.dishes = try container.decode([Dish].self, forKey: .dishes)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(dishes, forKey: .dishes)
    }
}

@Model
final class Dish: Codable {
    @Attribute(.unique) let id: String
    var name: String
    var amount: Double
    var unit: String
    var note: String
    @Relationship(deleteRule: .cascade) var nutritionalValues: NutritionalValues?
    var category: Category?
    var reports: [DailyReport]? = []
    
    var isFavorite: Bool = false
    
    var description: String {
        [amount.asString, unit, name].compactMap({ $0 }).joined(separator: " ")
    }
    
    var isValidate: Bool {
        name.isNotEmpty &&
        amount > 0 &&
        category != nil
    }
    
    enum CodingKeys: String, CodingKey {
        case name, amount, unit, note
        case nutritionalValues = "nutritional_values"
    }
    
    init(name: String = "",
         amount: Double = 0,
         unit: String = "",
         note: String = "",
         nutritionalValues: NutritionalValues? = nil,
         category: Category? = nil,
         reports: [DailyReport]? = [],
         isFavorite: Bool = false) {
        self.id = UUID().uuidString
        self.name = name
        self.amount = amount
        self.unit = unit
        self.note = note
        self.nutritionalValues = nutritionalValues
        self.category = category
        self.reports = reports
        self.isFavorite = isFavorite
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.name = try container.decode(String.self, forKey: .name)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.unit = (try? container.decode(String?.self, forKey: .unit)) ?? ""
        self.note = (try? container.decode(String?.self, forKey: .note)) ?? ""
        self.nutritionalValues = try container.decode(NutritionalValues.self, forKey: .nutritionalValues)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(amount, forKey: .amount)
        try container.encode(unit, forKey: .unit)
        try container.encode(note, forKey: .note)
        try container.encode(nutritionalValues, forKey: .nutritionalValues)
    }
}

@Model
final class NutritionalValues: Codable {
    @Attribute(.unique) let id: String = UUID().uuidString
    var carbohydrate: Double
    var protein: Double
    var fat: Double
    var dish: Dish? = nil
    
    enum CodingKeys: String, CodingKey {
        case carbohydrate, protein, fat
    }
       
    var description: String {
        Strings.dishNutritionalValuesDescription(carbohydrate.asString,
                                                 protein.asString,
                                                 fat.asString)
    }
    
    init(carbohydrate: Double = 0,
         protein: Double = 0,
         fat: Double = 0,
         dish: Dish? = nil) {
        self.carbohydrate = carbohydrate
        self.protein = protein
        self.fat = fat
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.carbohydrate = try container.decode(Double.self, forKey: .carbohydrate)
        self.protein = try container.decode(Double.self, forKey: .protein)
        self.fat = try container.decode(Double.self, forKey: .fat)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(carbohydrate, forKey: .carbohydrate)
        try container.encode(protein, forKey: .protein)
        try container.encode(fat, forKey: .fat)
    }
}

@Model
final class DailtReportNutritionalValues: Codable {
    @Attribute(.unique) let id: String = UUID().uuidString
    var carbohydrate: Double
    var protein: Double
    var fat: Double
    var report: DailyReport? = nil
        
    enum CodingKeys: String, CodingKey {
        case carbohydrate, protein, fat
    }
    
    init(carbohydrate: Double,
         protein: Double,
         fat: Double,
         report: DailyReport? = nil) {
        self.carbohydrate = carbohydrate
        self.protein = protein
        self.fat = fat
        self.report = report
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.carbohydrate = try container.decode(Double.self, forKey: .carbohydrate)
        self.protein = try container.decode(Double.self, forKey: .protein)
        self.fat = try container.decode(Double.self, forKey: .fat)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(carbohydrate, forKey: .carbohydrate)
        try container.encode(protein, forKey: .protein)
        try container.encode(fat, forKey: .fat)
    }
    
    static func defaultValues(with report: DailyReport? = nil) -> DailtReportNutritionalValues {
        let dailyNutritionalValuesService = DailyNutritionalValuesService()
        return .init(carbohydrate: dailyNutritionalValuesService.carbohydrateDailyConsumption.asDouble,
                     protein: dailyNutritionalValuesService.proteinDailyConsumption.asDouble,
                     fat: dailyNutritionalValuesService.fatDailyConsumption.asDouble,
                     report: report)
    }
}
