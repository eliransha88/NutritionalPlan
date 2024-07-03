//
//  DailyReportView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 01/07/2024.
//

import SwiftUI
import SwiftData

struct DailyReportView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var meals: [Meal]
    
    @Bindable var report: DailyReport
    @Binding var navigationPath: NavigationPath
    
    var filteredMeals: [Meal] {
        meals.filter({ $0.report == report })
    }
    
    var body: some View {
        VStack {
            List {
                
                Section("צריכה יומית") {
                    DailyNutritionalValues(nutritionalValues: report.totalNutritionalValues)
                }
                
                Section("ארוחות") {
                    ForEach(filteredMeals, id: \.self) { meal in
                        Text(meal.description)
                            .onTapGesture {
                                navigationPath.append(meal)
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
                       systemImage: "plus",
                       action: addMeal)
            }
            
            ToolbarItem {
                EditButton()
            }
            
        }
        .navigationDestination(for: Meal.self) {
            DishesListView(meal: $0,
                           navigationPath: $navigationPath)
        }
    }
    
    func addMeal() {
        let meal: Meal = .init(report: report)
        modelContext.insert(meal)
        navigationPath.append(meal)
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


struct DailyNutritionalValues: View {
    
    let nutritionalValues: NutritionalValues
    
    var body: some View {
        VStack(alignment: .leading) {
            Row(title: "פחמימות:", value: "\(nutritionalValues.carbohydrate)/4")
            Row(title: "חלבון:", value: "\(nutritionalValues.protein)/3.5")
            Row(title: "שומן:", value: "\(nutritionalValues.fat)/3")
        }
    }
    
    struct Row: View {
        
        let title: String
        let value: String
        
        var body: some View {
            HStack {
                Text(title)
                    .font(.headline)
                
                Text(value)
                    .font(.subheadline)
            }
        }
    }
}
