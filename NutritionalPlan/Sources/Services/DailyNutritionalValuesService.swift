//
//  DailyNutritionalValuesService.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI

class DailyNutritionalValuesService {
    
    @AppStorage("carbohydrateDailyConsumption") var carbohydrateDailyConsumption : String = "4"
    @AppStorage("proteinDailyConsumption") var proteinDailyConsumption : String = "3.5"
    @AppStorage("fatDailyConsumption") var fatDailyConsumption : String = "3"
}
