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
    
    private let shareWhatsappMessageService: ShareWhatsappMessageService = .init()
    
    @Environment(Router.self) var router
    @Environment(\.modelContext) var modelContext
    @Query var meals: [Meal]
    @Query(sort: \DailyReport.date, order: .reverse) var reports: [DailyReport]
    
    @Bindable var report: DailyReport
    
    var history: [DailyReport] {
        Array(reports.filter({ !Calendar.current.isDateInToday($0.date) }).prefix(3))
    }
    
    var filteredMeals: [Meal] {
        meals.filter({ $0.report == report })
    }
    
    init(report: DailyReport) {
        self.report = report
    }
    
    var body: some View {
        List {
            dailyConsumptionSection
            mealsSection
            historySection
        }
        .listRowSpacing(8.0)
        .navigationTitle(report.dateString)
        .toolbar {
            if report.meals?.isNotEmpty ?? false {
                ToolbarItem {
                    Button(Strings.reportMenuShareButtonTitle,
                           systemImage: SFSymbol.squareAndArrowUp.rawValue,
                           action: onShareButtonTap)
                    .foregroundColor(Color.primary)
                    
                }
            }
            
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
}

private extension DailyReportView {
    
    var dailyConsumptionSection: some View {
        SectionView(Strings.dailyConsumption) {
            DailyNutritionalValuesView(report: report)
                .id(report.meals)
        }
    }
    
    var mealsSection: some View {
        SectionView(Strings.mealsSectionTitle) {
            ForEach(filteredMeals, id: \.self) { meal in
                MealCellView(meal: meal)
                    .onTapGesture {
                        router.navigate(to: .mealView(meal))
                    }
            }
            .onDelete(perform: deleteMeal)
            .listRowInsets(.init(inset: 12.0))
        }
    }

    
    @ViewBuilder
    var historySection: some View {
        if history.isNotEmpty {
            Section {
                ForEach(history, id: \.self) { report in
                    VStack(alignment: .leading) {
                        Text(report.dateString)
                            .font(.headline)
                        Text(report.meals?.first?.description ?? Strings.noMeals)
                            .font(.subheadline)
                    }
                }
                .listRowInsets(.init(inset: 12.0))
            } header: {
                HStack {
                    Text(Strings.dailyReportTitle)
                        .font(.headline)
                        .foregroundStyle(Color.primary)
                        .padding(.vertical, 16.0)
                    
                    Spacer()
                    
                    Button {
                        router.navigate(to: .dailyReportsList)
                    } label: {
                        Text(Strings.showAllHistory)
                    }
                    
                }
            }
            .listRowInsets(.init(.zero))
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
    
    func onShareButtonTap() {
        let message: String = Strings.shareToWhatsappMessage(report.description)
        shareWhatsappMessageService.shareWhatsapp(message: message)
    }
}
