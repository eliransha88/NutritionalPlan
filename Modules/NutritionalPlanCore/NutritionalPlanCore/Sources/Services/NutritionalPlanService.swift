//
//  NutritionalPlanService.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import Foundation

public protocol NutritionalPlanServiceProtocol {
    func fetchRemoteCategories() async throws -> [Category]
}

public class NutritionalPlanService: NutritionalPlanServiceProtocol {
    
    public enum Error: LocalizedError {
        case failedToFetchJson
        case failedToDecode
        
        var erringMessage: String {
            switch self {
            case .failedToFetchJson:
                return "Failed to fetch json file"
            case .failedToDecode:
                return "Failed to decode json"
            }
        }
    }
    
    public init() {}
    
    public func fetchRemoteCategories() throws -> [Category] {
        guard let url = NutritionalPlanCoreResources.bundle.url(forResource: "nutritional_plan",
                                                                withExtension: "json") else {
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
