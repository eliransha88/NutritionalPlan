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
    
    @Inject var shareWhatsappMessageService: ShareWhatsappMessageServiceProtocol
    
    @Environment(Router.self) var router
    @Environment(\.modelContext) var modelContext
    @Environment(\.appPersistence) var appPersistence
    @Query var meals: [Meal]
    @Query(sort: \DailyReport.date, order: .reverse) var reports: [DailyReport]
    
    @Bindable var report: DailyReport
    
    var history: [DailyReport] {
        Array(reports.filter({ !Calendar.current.isDateInToday($0.date) }).prefix(3))
    }
    
    var filteredMeals: [Meal] {
        meals.filter({ $0.report == report })
    }
    
    let showHistory: Bool
    
    init(report: DailyReport, showHistory: Bool = true) {
        self.report = report
        self.showHistory = showHistory
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
                EditButton()
            }
        }
    }
}

private extension DailyReportView {
    
    var dailyConsumptionSection: some View {
        SectionView(Strings.dailyConsumption) {
            NutritionValuesConsumationView(totalConsumation: report.totalNutritionalValues,
                                           consumation: report.dailyConsumation ?? .defaultValues(with: report))
                .id(report.meals)
                .contentShape(Rectangle())
                .onTapGesture {
                    router.navigate(to: .weeklyReports(date: report.date))
                }
        }
    }
    
    var mealsSection: some View {
        SectionWithButtonView(Strings.mealsSectionTitle, content: {
            ForEach(filteredMeals, id: \.self) { meal in
                MealCellView(meal: meal)
                    .onTapGesture {
                        router.navigate(to: .mealView(meal))
                    }
            }
            .onDelete(perform: deleteMeal)
            .listRowInsets(.init(inset: 12.0))
        }, buttonContent: {
            Image(systemSymbol: .plus)
        }, onButtonTap: addMeal)
    }

    
    @ViewBuilder
    var historySection: some View {
        if showHistory, history.isNotEmpty {
            Section {
                ForEach(history, id: \.self) { report in
                    VStack(alignment: .leading) {
                        Text(report.dateString)
                            .font(.headline)
                        Text(report.meals?.first?.description ?? Strings.noMeals)
                            .font(.subheadline)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        router.navigate(to: .dailyReportView(report))
                    }
                }
                .listRowInsets(.init(inset: 12.0))
            } header: {
                HStack {
                    Text(Strings.historyTitle)
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
        try? modelContext.save()
        router.navigate(to: .mealView(meal))
    }
    
    func deleteMeal(at indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                let meal = filteredMeals[index]
                modelContext.delete(meal)
            }
            try? modelContext.save()
        }
    }
    
    func onShareButtonTap() {
        let message: String = Strings.shareToWhatsappMessage(report.description)
        shareWhatsappMessageService.shareWhatsapp(message: message, phoneNumber: appPersistence.phoneNumber)
    }
}
