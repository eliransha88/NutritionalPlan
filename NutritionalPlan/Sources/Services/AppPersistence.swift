//
//  DailyNutritionalValuesService.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI

struct AppPersistence {
        
    init() {}
    
    @AppStorage("phoneNumber") var phoneNumber : String = "972544353679"
    @AppStorage("carbohydrateDailyConsumption") var carbohydrateDailyConsumption : Double = 3.5
    @AppStorage("proteinDailyConsumption") var proteinDailyConsumption : Double = 3.5
    @AppStorage("fatDailyConsumption") var fatDailyConsumption : Double = 2.0
    
}


struct AppPersistenceKey: EnvironmentKey {
    static let defaultValue: AppPersistence = .init()
}

extension EnvironmentValues {
    var appPersistence: AppPersistence {
        get { self[AppPersistenceKey.self] }
        set { self[AppPersistenceKey.self] = newValue }
    }
}
