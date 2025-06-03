//
//  Previewer.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 30/06/2024.
//

import SwiftUI
import SwiftData

@MainActor
public struct Previewer {
    public let container: ModelContainer
    let nutritionalPlanService: NutritionalPlanService = .init()
    
    public init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: DailyReport.self, configurations: config)
        
        let categories = try nutritionalPlanService.fetchRemoteCategories()
        categories.forEach {
            container.mainContext.insert($0)
        }
    }
}
