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
    
    @Environment(\.modelContext) var modelContext: ModelContext
    @Query(sort: \DailyReport.date, order: .reverse) var reports: [DailyReport]
    
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        List {
            ForEach(reports) { report in
                Section(report.dateString) {
                    DailyReportCellView(report: report,
                                        onCellTap: {
                        navigationPath.append(report)
                    },
                                        onShareButtonTap: {
                        let message: String = "סיכום יומי:" + "\n" + report.description
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
        .navigationTitle("סיכום יומי")
        .onAppear {
            clearEmptyMeals()
        }
    }
    
    func addReport() {
        let report = DailyReport()
        modelContext.insert(report)
        navigationPath.append(report)
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

struct DailyReportCellView: View {
    
    let report: DailyReport
    let onCellTap: VoidHandler
    let onShareButtonTap: VoidHandler
    
    var body: some View {
        HStack(spacing: 8.0) {
            HStack {
                Text(report.description)
                    .font(.subheadline)
                    .padding()
                
                Spacer()
            }
            .onTapGesture {
                onCellTap()
            }
            
            if report.meals.isNotEmpty {
                Button("",
                       systemImage: SFSymbol.squareAndArrowUp.rawValue,
                       action: onShareButtonTap)
            }
        }
    }
}
