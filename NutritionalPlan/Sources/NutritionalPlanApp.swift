//
//  NutritionalPlanApp.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import SwiftUI
import SwiftData

typealias Strings = NutritionalPlanStrings
typealias ImageAssets = NutritionalPlanAsset.Assets
@main
struct NutritionalPlanApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            DailyReport.self,
            Category.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema,
                                                    isStoredInMemoryOnly: false)

        do {
          //  return try ModelContainer(for: schema, migrationPlan: MigrationPlan.self, configurations: [modelConfiguration])
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        AppDIContainer.shared.setup()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)

    }
}
