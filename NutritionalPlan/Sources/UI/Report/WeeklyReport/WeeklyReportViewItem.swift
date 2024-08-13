//
//  WeeklyReportViewModel.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/08/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import Foundation
import Observation

class WeeklyReportViewItem {

    let reports: [DailyReport]
    
    var carbohydrateData: [NutrutionChartData] {
        data.carbohydrateData
    }
    
    var protienData: [NutrutionChartData] {
        data.protienData
    }
    
    var fatData: [NutrutionChartData] {
        data.fatData
    }
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    lazy var title: String = {
        let dates = weekReports.map { $0.date }
        guard let startDate = dates.first,
              let endDate = dates.last else {
            return ""
        }

        // Extract day, month, and year components
        let startDay = Self.dateFormatter.string(from: startDate)
        let endDay = Self.dateFormatter.string(from: endDate)

        return "\(startDay)-\(endDay)"
    }()
    
    lazy var totalWeeklyConsumation: NutritionalValues = {
        weekReports.reduce(into: .init()) {
            $0.carbohydrate += $1.totalNutritionalValues.carbohydrate
            $0.protein += $1.totalNutritionalValues.protein
            $0.fat += $1.totalNutritionalValues.fat
        }
    }()
    
    lazy var weeklyConsumation: DailyReportNutritionalValues = {
        let defaultValues = DailyReportNutritionalValues.defaultValues()
        return weekReports.reduce(into: .init()) {
            $0.carbohydrate += $1.dailyConsumation?.carbohydrate ?? defaultValues.carbohydrate
            $0.protein += $1.dailyConsumation?.protein ?? defaultValues.protein
            $0.fat += $1.dailyConsumation?.fat ?? defaultValues.fat
        }
    }()
    
    lazy var weekReports: [DailyReport] = {
        var weekReports = reports
        if weekReports.count < 7 {
            appendDummy(weekReports: &weekReports)
        }
        return weekReports.sorted(by: \.date, using: <)
    }()
        
    lazy var data: NutrutionChartDataStructure = {
        var data = NutrutionChartDataStructure()
        data.carbohydrateData = weekReports.map({ .init(date: $0.date,
                                                        amount: $0.totalNutritionalValues.carbohydrate) })
        data.protienData = weekReports.map({ .init(date: $0.date,
                                                        amount: $0.totalNutritionalValues.protein) })
        data.fatData = weekReports.map({ .init(date: $0.date,
                                                        amount: $0.totalNutritionalValues.fat) })
        return data
    }()
    
    init(reports: [DailyReport]) {
        self.reports = reports
    }
        
    func appendDummy(weekReports: inout [DailyReport]) {
        guard let date = weekReports.first?.date else {
            return
        }
        
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Set Sunday as the first day of the week. Change to 2 for Monday.
        
        // Find the weekday of the given date
        let weekday = calendar.component(.weekday, from: date)
        
        // Calculate the start of the week
        guard let startOfWeek = calendar.date(byAdding: .day,
                                              value: -(weekday - calendar.firstWeekday),
                                              to: date) else {
            return
        }
        
        for i in 0..<7 {
            if let weekDate = calendar.date(byAdding: .day, value: i, to: startOfWeek),
               !weekReports.contains(where: { $0.date == weekDate }) {
                weekReports.append(.init(date: weekDate))
            }
        }
    }
}
