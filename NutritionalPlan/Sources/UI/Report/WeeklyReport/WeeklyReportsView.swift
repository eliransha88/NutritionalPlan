//
//  WeeklyReportsView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/08/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import SwiftUI
import SwiftData

struct WeeklyReportsView: View {
    
    @State private var title: String = ""
    @State private var activeWeekReportIndex: Int?
    @Query var reports: [DailyReport]
    
    let date: Date
    
    var weeklyReportViewModels: [WeeklyReportViewItem] {
        let calendar = Calendar.current
        var weeks: [Int: [DailyReport]] = [:]
        reports.forEach {
            let weekOfYear = calendar.component(.weekOfYear, from: $0.date)
            
            // Append the date to the corresponding week's array
            if weeks[weekOfYear] == nil {
                weeks[weekOfYear] = [$0]
            } else {
                weeks[weekOfYear]?.append($0)
            }
        }
        
        return weeks.keys.sorted()
            .compactMap { weeks[$0] }
            .map({ WeeklyReportViewItem(reports: $0) })
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0, content: {
                ForEach(Array(weeklyReportViewModels.enumerated()), id: \.offset) { index, viewModel in
                    WeeklyReportView(viewModel: viewModel)
                        .id(index)
                }
                .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
            })
            .scrollTargetLayout()
        }
        .scrollPosition(id: $activeWeekReportIndex)
        .scrollIndicators(.never)
        .scrollTargetBehavior(.viewAligned)
        .overlay(alignment: .bottom) {
            pagingControl
                .safeAreaPadding(.bottom)
        }
        .onAppear {
            activeWeekReportIndex = weeklyReportViewModels.firstIndex(where: {
                $0.reports.contains(where: { $0.date == date })
            })
        }
        .onChange(of: activeWeekReportIndex, { _, newValue in
            guard let newValue, newValue < weeklyReportViewModels.count else {
                return
            }
            withAnimation {
                title = weeklyReportViewModels[newValue].title
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(title)
        .contentMargins(.horizontal, 0, for: .scrollContent)
        .contentMargins(.vertical, 60, for: .scrollContent)
        .ignoresSafeArea()
    }
}

private extension WeeklyReportsView {
    
    @ViewBuilder
    var pagingControl: some View {
        if weeklyReportViewModels.count > 1 {
            HStack(spacing: 8.0) {
                ForEach(Array(weeklyReportViewModels.enumerated()), id: \.offset) { index, _ in
                    Button {
                        withAnimation {
                            activeWeekReportIndex = index
                        }
                    } label: {
                        Image(systemSymbol: activeWeekReportIndex == index ? .circleFill : .circle)
                            .resizable()
                            .foregroundStyle(Color.primary)
                            .frame(size: 12.0.asSize)
                    }
                }
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(Color.primary.opacity(0.1))
        }
    }
}
