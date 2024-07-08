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
    
    private let shareWhatsappMessageService: ShareWhatsappMessageService = .init()
    
    @Environment(Router.self) var router
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query(sort: \DailyReport.date, order: .reverse) var reports: [DailyReport]
    
    var body: some View {
        List {
            ForEach(reports) { report in
                Section(report.dateString) {
                    DailyReportCellView(report: report,
                                        onCellTap: {
                        router.navigate(to: .dailyReportView(report))
                    },
                                        onShareButtonTap: {
                        let message: String = Strings.shareToWhatsappMessage(report.description)
                        shareWhatsappMessageService.shareWhatsapp(message: message)
                    })
                }
            }
            .onDelete(perform: deleteReport)
        }
        .toolbar {
            ToolbarItem {
                Button("",
                       systemImage: SFSymbol.plus.rawValue,
                       action: addReport)
            }
            
            ToolbarItem {
                EditButton()
            }
        }
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
