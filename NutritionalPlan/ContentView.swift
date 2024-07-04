//
//  ContentView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @StateObject private var router: Router = .init()
    
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query var categories: [Category]
    @State private var path: NavigationPath = .init()
    @State private var searchString: String = ""
    
    let nutritionalPlanService: NutritionalPlanService
    
    init(nutritionalPlanService: NutritionalPlanService) {
        self.nutritionalPlanService = nutritionalPlanService
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            DailyReportsView()
            .onAppear {
                fetchAndSaveProducts()
            }
            .navigationDestination(for: Router.Destination.self, destination: {
                switch $0 {
                case let .mealView(meal):
                    DishesListView(meal: meal)
                case let .dishView(dish, isEditing):
                    DishView(isEditing: isEditing, dish: dish)
                case let .selectDishCategory(dish):
                    CategoriesView(dish: dish)
                case let .dailyReportView(report):
                    DailyReportView(report: report)
                case .settings:
                    SettingsView()
                }
            })
        }
        .environmentObject(router)
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

//#Preview {
//    do {
//        let previewer = try Previewer()
//        return ContentView(nutritionalPlanService: .init())
//            .modelContainer(previewer.container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}
