//
//  NutritionalPlanService.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import Foundation
import CloudKit

protocol NutritionalPlanServiceProtocol {
    func isFirstCloudSync() async throws -> Bool
    func fetchRemoteCategories() async throws -> [Category]
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
    
    func isFirstCloudSync() async throws -> Bool {
        
        let container = CKContainer.default()
        let cloudDB = container.privateCloudDatabase
        
        let pred = NSPredicate(value: true) //true -> return all records
        let query = CKQuery(recordType: "CD_Category",
                            predicate: pred)
        
        let (result, _) = try await cloudDB.records(matching: query,
                                                               resultsLimit: 1)
        return result.count == 0
        
    }
}
