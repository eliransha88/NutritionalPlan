//
//  Date+Extension.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 02/08/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import Foundation

extension Date {
    
    var isDateInCurrentWeek: Bool {
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Get the week of year for the current date
        let currentWeekOfYear = calendar.component(.weekOfYear, from: currentDate)
        let currentYear = calendar.component(.yearForWeekOfYear, from: currentDate)
        
        // Get the week of year for the given date
        let givenWeekOfYear = calendar.component(.weekOfYear, from: self)
        let givenYear = calendar.component(.yearForWeekOfYear, from: self)
        
        // Compare the weeks and years
        return currentWeekOfYear == givenWeekOfYear && currentYear == givenYear
    }
    
    static var currentWeekDates: [Date] {
        // Get the current calendar
        let calendar = Calendar.current
        // Get the current date
        let today = Date()
        // Calculate the start of the week
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) else {
            return []
        }
        // Generate all days of the current week
        var weekDates: [Date] = []
        for dayOffset in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: weekInterval.start) {
                weekDates.append(date)
            }
        }
        
        return weekDates
    }
        
    var dayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
    
    func addingDays(_ number: Int) -> Date {
        let calendar = Calendar.current
        let today = Date()
        return calendar.date(byAdding: .day, value: number, to: today) ?? today
    }
    
}
