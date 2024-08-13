//
//  NutrutionChartDataStructure.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 02/08/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import Foundation

typealias NutrutionChartDataStructure = [NutrutionChartType: [NutrutionChartData]]

extension NutrutionChartDataStructure {
    
    var carbohydrateData: [NutrutionChartData] {
        get {
            return self[.carbohydrate] ?? []
        }
        set {
            self[.carbohydrate] = newValue
        }
    }
    
    var protienData: [NutrutionChartData] {
        get {
            return self[.protien] ?? []
        }
        set {
            self[.protien] = newValue
        }
    }
    
    var fatData: [NutrutionChartData] {
        get {
            return self[.fat] ?? []
        }
        set {
            self[.fat] = newValue
        }
    }
}

struct NutrutionChartData: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let amount: Double
}

enum NutrutionChartType {
    case carbohydrate, protien, fat
}
