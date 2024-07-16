//
//  ContentView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 29/06/2024.
//

import SwiftUI
import SwiftData
import SFSafeSymbols

struct ContentView: View {
    
    @State private var router: Router = .init()
    
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query var categories: [Category]
    @Query var reports: [DailyReport]
    
    @State private var path: NavigationPath = .init()
    @State private var searchString: String = ""
    @State private var id: UUID = .init()
    @State private var isLoading: Bool = true
    @State private var degreesRotating = 0.0
    
    @Inject var nutritionalPlanService: NutritionalPlanServiceProtocol
    
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
    
    var body: some View {
        Group {
            if isLoading {
                loadingView
            } else {
                contentView
            }
            
        }
        .task {
            await fetchAndSaveProducts()
        }
        
    }
}

private extension ContentView {
    
    var loadingView: some View {
        ImageAssets.logo.swiftUIImage
            .clipShape(Circle())
            .rotationEffect(.degrees(degreesRotating))
            .onAppear {
                withAnimation(.linear(duration: 1)
                     .speed(0.1).repeatForever(autoreverses: false)) {
                         degreesRotating = 360.0
                     }
            }
    }
    
    var contentView: some View {
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
                .id(id)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification), perform: { _  in
                    // when back from background if we pass the report date we reload the view and create a new report
                    if !Calendar.current.isDateInToday(report.date) {
                        id = UUID()
                    }
                })
        }
        .environment(router)
        .tint(Color.green)
    }
    
    func fetchAndSaveProducts() async {

        defer {
            Task {
                await setIsLoading(false)
            }
        }
        
        guard (try? await nutritionalPlanService.isFirstCloudSync()) ?? false else {
            return
        }
        
        guard categories.isEmpty else {
            return
        }
        do {
            let categories = try await nutritionalPlanService.fetchRemoteCategories()
            
            categories.forEach {
                modelContext.insert($0)
            }
            print("fetch and save categories succeed")
        }
        catch {
            print("failed to fetch nutritional plan")
        }
    }
    
    @MainActor
    func setIsLoading(_ isLoading: Bool) {
        withAnimation(.linear(duration: 1.0)) {
            self.isLoading = isLoading
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return ContentView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
