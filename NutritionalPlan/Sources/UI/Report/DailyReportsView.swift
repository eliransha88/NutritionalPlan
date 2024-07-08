//
//  DailyReportsView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 01/07/2024.
//

import SwiftUI
import SwiftData
import SFSafeSymbols

struct DailyReportsView: View {
    
    @Environment(Router.self) var router
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query(sort: \DailyReport.date, order: .reverse) var reports: [DailyReport]
    
    var body: some View {
        List {
            ForEach(reports) { report in
                DailyReportCellView(report: report) {
                    router.navigate(to: .dailyReportView(report))
                }
            }
            .onDelete(perform: deleteReport)
            .listRowInsets(.init(inset: 12.0))
        }
        .listRowSpacing(12.0)
        .navigationTitle(Strings.dailyReportTitle)
        .onAppear {
            clearEmptyMeals()
        }
    }
    
    func addReport() {
        let report = DailyReport()
        modelContext.insert(report)
        router.navigate(to: .dailyReportView(report))
    }
    
    func clearEmptyMeals() {
        reports.forEach({ $0.clearEmptyMeals() })
    }
    
    func deleteReport(at indexSet: IndexSet) {
        for index in indexSet {
            let report = reports[index]
            modelContext.delete(report)
        }
    }
}
