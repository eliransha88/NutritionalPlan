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
    let onShareButtonTap: VoidHandler
    
    var body: some View {
        HStack(spacing: 8.0) {
            HStack {
                Text(report.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                onCellTap()
            }
            .onLongPressGesture {
                UIPasteboard.general.string = report.description
            }
            
            if report.meals.isNotEmpty {
                
                Menu {
                    Button(Strings.reportMenuShareButtonTitle,
                           systemImage: SFSymbol.squareAndArrowUp.rawValue,
                           action: onShareButtonTap)
                    .foregroundColor(Color.primary)
                    
                    Button(Strings.reportMenuCopyButtonTitle,
                           systemImage: SFSymbol.squareAndArrowUp.rawValue) {
                        UIPasteboard.general.string = report.description
                    }
                           .foregroundColor(Color.primary)
                    
                } label: {
                    Image(systemSymbol: .ellipsisCircle)
                        .foregroundColor(Color.primary)
                }
            }
        }
        .padding()
    }
}
