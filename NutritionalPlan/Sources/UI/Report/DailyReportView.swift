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
    @Query var reports: [DailyReport]
    
    @Bindable var report: DailyReport
    
    var history: [DailyReport] {
        Array(reports.filter({ $0.date != report.date }).prefix(3))
    }
    
    var filteredMeals: [Meal] {
        meals.filter({ $0.report == report })
    }
    
    init(report: DailyReport) {
        self.report = report
    }
    
    var body: some View {
        List {
            
            SectionView(Strings.dailyConsumption) {
                DailyNutritionalValuesView(report: report)
                    .id(report.meals)
            }
            
            SectionView(Strings.mealsSectionTitle) {
                ForEach(filteredMeals, id: \.self) { meal in
                    MealCellView(meal: meal)
                        .onTapGesture {
                            router.navigate(to: .mealView(meal))
                        }
                }
                .onDelete(perform: deleteMeal)
                .listRowInsets(.init(inset: 12.0))
                .listRowBackground(Color.secondary.opacity(0.4))
            }
            
            Section {
                ForEach(history, id: \.self) { report in
                    VStack(alignment: .leading) {
                        Text(report.dateString)
                            .font(.headline)
                        Text(report.meals.first?.description ?? Strings.noMeals)
                            .font(.subheadline)
                    }
                }
                .listRowInsets(.init(inset: 12.0))
                .listRowBackground(Color.secondary.opacity(0.4))
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
        .listRowSpacing(8.0)
        .preferredColorScheme(.dark)
        .navigationTitle(report.dateString)
        .toolbarRole(.editor)
        .toolbar {
            
            if report.meals.isNotEmpty {
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
