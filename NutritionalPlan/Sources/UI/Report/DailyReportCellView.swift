//
//  DailyReportCellView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 07/07/2024.
//

import SwiftUI
import SFSafeSymbols

struct DailyReportCellView: View {
    
    let report: DailyReport
    let onCellTap: VoidHandler
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(report.dateString)
                .font(.headline)
            
            HStack {
                Text(report.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onCellTap()
        }
    }
}
