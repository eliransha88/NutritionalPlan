//
//  NutritionalPlanService.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import Foundation

protocol NutritionalPlanServiceProtocol {
    func fetchRemoteCategories() throws -> [Category]
}

class NutritionalPlanService: NutritionalPlanServiceProtocol {
    
    enum Error: Swift.Error {
        case failedToFetchJson
        case failedToDecode
    }
    
    func fetchRemoteCategories() throws -> [Category] {
        guard let url = Bundle.main.url(forResource: "nutritional_plan", withExtension: "json") else {
            throw Error.failedToFetchJson
        }
        let data = try Data(contentsOf: url)
        do {
            let plan = try JSONDecoder().decode(NutritionalPlan.self, from: data)
            return plan.categories
        }
        catch {
            throw Error.failedToDecode
        }
    }
}
