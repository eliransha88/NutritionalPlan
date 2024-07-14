//
//  ContentView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import SwiftUI
import SwiftData
import SFSafeSymbols
import CloudKit

struct ContentView: View {
    
    @State private var router: Router = .init()
    
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query var categories: [Category]
    @Query var reports: [DailyReport]
    
    @State private var path: NavigationPath = .init()
    @State private var searchString: String = ""
    
    let nutritionalPlanService: NutritionalPlanService
    
    var report: DailyReport {
        guard let report = reports.first(where: {
            Calendar.current.isDateInToday($0.date)
        }) else {
            let report = DailyReport()
            modelContext.insert(report)
            return report
        }
        return report
    }
    
    init(nutritionalPlanService: NutritionalPlanService) {
        self.nutritionalPlanService = nutritionalPlanService
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            DailyReportView(report: report)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("",
                               systemImage:  SFSymbol.gearshape.rawValue) {
                            router.navigate(to: .settings)
                        }
                        
                        Button("",
                               systemImage:  SFSymbol.menucard.rawValue) {
                            router.navigate(to: .menu)
                        }
                    }
                }
                .task {
                    await fetchAndSaveProducts()
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
                        DailyReportView(report: report, showHistory: false)
                    case .settings:
                        SettingsView()
                    case .menu:
                        MenuView()
                    case let .menuByCategory(category):
                        MenuByCategoryView(category: category)
                    case .dailyReportsList:
                        DailyReportsView()
                    }
                })
            
        }
        .environment(router)
        .tint(Color.green)
        
    }
}

private extension ContentView {
    
    func fetchAndSaveProducts() async {
        guard categories.isEmpty else {
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
