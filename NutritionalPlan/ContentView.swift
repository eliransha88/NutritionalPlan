//
//  ContentView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) var modelContext: ModelContext
    @Query var categories: [Category]
    @State private var path: NavigationPath = .init()
    @State private var searchString: String = ""
    
    let nutritionalPlanService: NutritionalPlanService
    
    init(nutritionalPlanService: NutritionalPlanService) {
        self.nutritionalPlanService = nutritionalPlanService
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            DailyReportsView(navigationPath: $path)
            .onAppear {
                fetchAndSaveProducts()
            }
            .navigationDestination(for: DailyReport.self) {
                DailyReportView(report: $0,
                                navigationPath: $path)
            }
        }
    }
}

private extension ContentView {

    func fetchAndSaveProducts() {
        guard categories.isEmpty else {
            print("categories already fetched")
            return
        }
        do {
            let categories = try nutritionalPlanService.fetchRemoteCategories()
            categories.forEach {
                modelContext.insert($0)
            }
            print("fetch and save categories succeed")
        }
        catch {
            print("failed to fetch nutritional plan")
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return ContentView(nutritionalPlanService: .init())
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
