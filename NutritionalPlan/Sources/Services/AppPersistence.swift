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
    @AppStorage("carbohydrateDailyConsumption") var carbohydrateDailyConsumption : String = "4"
    @AppStorage("proteinDailyConsumption") var proteinDailyConsumption : String = "3.5"
    @AppStorage("fatDailyConsumption") var fatDailyConsumption : String = "3"
    
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
