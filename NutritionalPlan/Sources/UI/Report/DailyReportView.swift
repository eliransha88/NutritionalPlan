//
//  DailyReportView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 01/07/2024.
//

import SwiftUI
import SwiftData
import SFSafeSymbols

struct DailyReportView: View {
    
    @Environment(Router.self) var router
    @Environment(\.modelContext) var modelContext
    @Query var meals: [Meal]
    
    @Bindable var report: DailyReport
    
    var filteredMeals: [Meal] {
        meals.filter({ $0.report == report })
    }
    
    init(report: DailyReport) {
        self.report = report
    }
    
    var body: some View {
        VStack {
            List {
                
                Section(Strings.dailyConsumption) {
                    DailyNutritionalValuesView(report: report)
                        .id(report.meals)
                }
                
                Section(Strings.mealsSectionTitle) {
                    ForEach(filteredMeals, id: \.self) { meal in
                        MealCellView(meal: meal)
                            .onTapGesture {
                                router.navigate(to: .mealView(meal))
                            }
                    }
                    .onDelete(perform: deleteMeal)
                }
            }
        }
        .navigationTitle(report.dateString)
        .toolbarRole(.editor)
        .toolbar {
                    
            ToolbarItem {
                Button("",
                       systemImage: SFSymbol.plus.rawValue,
                       action: addMeal)
            }
            
            ToolbarItem {
                EditButton()
            }
            
        }
    }
    
    func addMeal() {
        let meal: Meal = .init(report: report)
        modelContext.insert(meal)
        router.navigate(to: .mealView(meal))
    }
    
    func deleteMeal(at indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                let meal = filteredMeals[index]
                modelContext.delete(meal)
            }
        }
    }
}
