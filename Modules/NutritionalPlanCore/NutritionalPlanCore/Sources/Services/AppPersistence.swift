//
//  DailyNutritionalValuesService.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI

public struct AppPersistence {
        
    public init() {}
    
    @AppStorage("phoneNumber") public var phoneNumber : String = "972544353679"
    @AppStorage("carbohydrateDailyConsumption") public var carbohydrateDailyConsumption : Double = 3.5
    @AppStorage("proteinDailyConsumption") public var proteinDailyConsumption : Double = 3.5
    @AppStorage("fatDailyConsumption") public var fatDailyConsumption : Double = 2.0
    
}

public struct AppPersistenceKey: EnvironmentKey {
    public static let defaultValue: AppPersistence = .init()
}

public extension EnvironmentValues {
    var appPersistence: AppPersistence {
        get { self[AppPersistenceKey.self] }
        set { self[AppPersistenceKey.self] = newValue }
    }
}
