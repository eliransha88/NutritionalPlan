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
    var id: String = UUID().uuidString
    let date: Date = Date.now
    var meals: [Meal]? = []
    var dailyConsumation: DailyReportNutritionalValues?
    
    enum CodingKeys: String, CodingKey {
        case id, date, meals, dailyConsumation
    }
    
    var totalNutritionalValues: NutritionalValues {
        guard let meals else {
            return .init()
        }
        return meals.compactMap({ $0.totalNutritionalValues })
            .reduce(.init(), +)
    }
    
    var description: String {
        guard let meals, meals.isNotEmpty else {
            return "תאכל משהו שלא תהיה רעב"
        }
        
        return meals.sorted() {
            $0.createdDate > $1.createdDate
        }.compactMap {
            $0.dishes?.map { $0.description }
                .joined(separator: ", ")
        }
        .joined(separator: "\n")
    }
    
    var dateString: String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return Strings.dateToday
        } else if calendar.isDateInYesterday(date) {
            return Strings.dateYesterday
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, d MMM"
            dateFormatter.locale = .current
            return dateFormatter.string(from: date)
        }
    }
    
    init(meals: [Meal]? = [],
         dailyConsumation: DailyReportNutritionalValues? = nil) {
        self.id = UUID().uuidString
        self.meals = meals
        self.dailyConsumation = dailyConsumation
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.date = try container.decode(Date.self, forKey: .date)
        self.meals = try container.decode([Meal]?.self, forKey: .meals)
        self.dailyConsumation = (try? container.decodeIfPresent(DailyReportNutritionalValues.self,
                                                                forKey: .dailyConsumation)) ?? DailyReportNutritionalValues.defaultValues(with: self)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(meals, forKey: .meals)
        try container.encode(dailyConsumation, forKey: .dailyConsumation)
    }
    
    func clearEmptyMeals() {
        meals?.removeAll(where: { $0.dishes?.isEmpty ?? true })
    }
}

@Model
final class Meal: Codable {
    var id: String = UUID().uuidString
    let createdDate: Date = Date.now
    
    var dishes: [Dish]? = []
    @Relationship(inverse: \DailyReport.meals) var report: DailyReport?
    
    enum CodingKeys: CodingKey {
        case id, createdDate, dishes, report
    }
    
    var description: String {
        dishes?.compactMap({ $0.description }).joined(separator: ", ") ?? ""
    }
    
    var nutritionalValueString: String {
        let dic = [
            Strings.dailyNutritionalValuesCarbohydrate: totalNutritionalValues.carbohydrate,
            Strings.dailyNutritionalValuesProtein: totalNutritionalValues.protein,
            Strings.dailyNutritionalValuesFat: totalNutritionalValues.fat
        ].filter({ $0.value > 0 })
        
        if dic.isEmpty {
            return ""
        } else {
            let keyValueString = dic.map({ "\($0.key): \($0.value)" }).joined(separator: ", ")
            return "(" + keyValueString + ")"
        }
    }
    
    var totalNutritionalValues: NutritionalValues {
        guard let dishes else {
            return .init()
        }
        return dishes.reduce(into: .init()) { partialResult, value in
            partialResult.carbohydrate += value.nutritionalValues?.carbohydrate ?? 0
            partialResult.protein += value.nutritionalValues?.protein ?? 0
            partialResult.fat += value.nutritionalValues?.fat ?? 0
        }
    }
    
    init(dishes: [Dish]? = [],
         report: DailyReport? = nil) {
        self.id = UUID().uuidString
        self.dishes = dishes
        self.report = report
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.createdDate = try container.decode(Date.self, forKey: .createdDate)
        self.dishes = try container.decode([Dish]?.self, forKey: .dishes)
        self.report = try container.decode(DailyReport.self, forKey: .report)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdDate, forKey: .createdDate)
        try container.encode(dishes, forKey: .dishes)
        try container.encode(report, forKey: .report)
    }
}

final class NutritionalPlan: Codable {
    var carbohydrate: [Category] = []
    var protein: [Category] = []
    var fat: [Category] = []
    var other: [Category] = []
    
    enum CodingKeys: String, CodingKey {
        case carbohydrate, protein, fat, other
    }
    
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
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(carbohydrate, forKey: .carbohydrate)
        try container.encode(protein, forKey: .protein)
        try container.encode(fat, forKey: .fat)
        try container.encode(other, forKey: .other)
    }
}

@Model
final class Category: Codable, Equatable {

    enum CategoryType: String, Codable, CaseIterable {
        case all
        case carbohydrate
        case protein
        case fat
        case other
        case unknown
        
        var title: String {
            switch self {
            case .all: return Strings.categoryTypeAllTitle
            case .carbohydrate: return Strings.categoryTypeCarbohydrateTitle
            case .protein: return Strings.categoryTypeProteinTitle
            case .fat: return Strings.categoryTypeFatTitle
            case .other: return Strings.categoryTypeOtherTitle
            case .unknown: return Strings.categoryTypeUnknownTitle
            }
        }
    }

    var id: String = UUID().uuidString
    var type: CategoryType = CategoryType.unknown
    var name: String = ""
    var dishes: [Dish]? = []

    enum CodingKeys: CodingKey {
        case id, type, name, dishes
    }
    
    init(type: CategoryType,
         name: String,
         dishes: [Dish]? = []) {
        self.id = UUID().uuidString
        self.type = type
        self.name = name
        self.dishes = dishes
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decodeIfPresent(CategoryType.self, forKey: .type) ?? .unknown
        self.name = try container.decode(String.self, forKey: .name)
        self.dishes = try container.decode([Dish]?.self, forKey: .dishes)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(dishes, forKey: .dishes)
    }
}

@Model
final class Dish: Codable {
    var id: String = UUID().uuidString
    var name: String = ""
    var amount: Double = 0
    var unit: String = ""
    var note: String = ""
    @Relationship(deleteRule: .cascade) var nutritionalValues: NutritionalValues?
    @Relationship(inverse: \Category.dishes) var category: Category?
    @Relationship(inverse: \Meal.dishes) var meals: [Meal]? = []
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
        case id, name, amount, unit, note, category, meals, isFavorite
        case nutritionalValues = "nutritional_values"
    }
    
    init(name: String = "",
         amount: Double = 0,
         unit: String = "",
         note: String = "",
         nutritionalValues: NutritionalValues? = nil,
         category: Category? = nil,
         meals: [Meal]? = [],
         isFavorite: Bool = false) {
        self.id = UUID().uuidString
        self.name = name
        self.amount = amount
        self.unit = unit
        self.note = note
        self.nutritionalValues = nutritionalValues
        self.category = category
        self.meals = meals
        self.isFavorite = isFavorite
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.unit = (try? container.decode(String?.self, forKey: .unit)) ?? ""
        self.note = (try? container.decode(String?.self, forKey: .note)) ?? ""
        self.nutritionalValues = try container.decode(NutritionalValues.self, forKey: .nutritionalValues)
        self.category = try? container.decodeIfPresent(Category.self, forKey: .category)
        self.meals = (try? container.decodeIfPresent([Meal]?.self, forKey: .meals)) ?? []
        self.isFavorite = (try? container.decodeIfPresent(Bool.self, forKey: .isFavorite)) ?? false
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(amount, forKey: .amount)
        try container.encode(unit, forKey: .unit)
        try container.encode(note, forKey: .note)
        try container.encode(nutritionalValues, forKey: .nutritionalValues)
        try container.encode(category, forKey: .category)
        try container.encode(meals, forKey: .meals)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
}

@Model
final class NutritionalValues: Codable {
    var id: String = UUID().uuidString
    var carbohydrate: Double = 0
    var protein: Double = 0
    var fat: Double = 0
    var dish: Dish?
    
    enum CodingKeys: String, CodingKey {
        case id, carbohydrate, protein, fat, dish
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
        self.id = UUID().uuidString
        self.carbohydrate = carbohydrate
        self.protein = protein
        self.fat = fat
        self.dish = dish
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.carbohydrate = try container.decode(Double.self, forKey: .carbohydrate)
        self.protein = try container.decode(Double.self, forKey: .protein)
        self.fat = try container.decode(Double.self, forKey: .fat)
        self.dish = try? container.decodeIfPresent(Dish.self, forKey: .carbohydrate)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(carbohydrate, forKey: .carbohydrate)
        try container.encode(protein, forKey: .protein)
        try container.encode(fat, forKey: .fat)
        try container.encode(dish, forKey: .dish)
    }
    
    static func + (lhs: NutritionalValues, rhs: NutritionalValues) -> NutritionalValues {
        return .init(carbohydrate: lhs.carbohydrate + rhs.carbohydrate,
                                 protein: lhs.protein + rhs.protein,
                                 fat: lhs.fat + rhs.fat)
    }
}

@Model
final class DailyReportNutritionalValues: Codable {
    
    var id: String = UUID().uuidString
    var carbohydrate: Double = 0
    var protein: Double = 0
    var fat: Double = 0
    var report: DailyReport?
        
    enum CodingKeys: String, CodingKey {
        case id, carbohydrate, protein, fat, report
    }
    
    init(carbohydrate: Double,
         protein: Double,
         fat: Double,
         report: DailyReport? = nil) {
        self.id = UUID().uuidString
        self.carbohydrate = carbohydrate
        self.protein = protein
        self.fat = fat
        self.report = report
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.carbohydrate = try container.decode(Double.self, forKey: .carbohydrate)
        self.protein = try container.decode(Double.self, forKey: .protein)
        self.fat = try container.decode(Double.self, forKey: .fat)
        self.report = try? container.decodeIfPresent(DailyReport.self, forKey: .report)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(carbohydrate, forKey: .carbohydrate)
        try container.encode(protein, forKey: .protein)
        try container.encode(fat, forKey: .fat)
        try container.encode(report, forKey: .report)
    }
    
    static func defaultValues(with report: DailyReport? = nil) -> DailyReportNutritionalValues {
        let appPersistence = AppPersistence()
        return .init(carbohydrate: appPersistence.carbohydrateDailyConsumption.asDouble,
                     protein: appPersistence.proteinDailyConsumption.asDouble,
                     fat: appPersistence.fatDailyConsumption.asDouble,
                     report: report)
    }
}
