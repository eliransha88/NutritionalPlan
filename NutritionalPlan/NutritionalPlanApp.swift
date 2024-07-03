//
//  NutritionalPlanApp.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import SwiftUI
import SwiftData

@main
struct NutritionalPlanApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            DailyReport.self,
            Category.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    let nutritionalPlanService: NutritionalPlanService = .init()

    var body: some Scene {
        WindowGroup {
            ContentView(nutritionalPlanService: nutritionalPlanService)
        }
        .modelContainer(sharedModelContainer)

    }
}
