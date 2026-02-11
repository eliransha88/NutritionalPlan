//
//  NutritionalPlanSchemeV2.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftData

public enum NutritionalPlanSchemeV1: VersionedSchema {
    public static var models: [any PersistentModel.Type] { [DailyReport.self] }
    
    public static var versionIdentifier: Schema.Version = .init(1, 0, 0)
}

public enum NutritionalPlanSchemeV2: VersionedSchema {
    public static var models: [any PersistentModel.Type] { [DailyReport.self, Category.self] }
    
    public static var versionIdentifier: Schema.Version = .init(1, 1, 0)
}

public enum NutritionalPlanSchemeV3: VersionedSchema {
    public static var models: [any PersistentModel.Type] { [DailyReport.self, Category.self, MigrationPlanV3Object.self] }
    
    public static var versionIdentifier: Schema.Version = .init(1, 2, 0)
}

public enum MigrationPlan: SchemaMigrationPlan {
    public static var schemas: [any VersionedSchema.Type] {
        [
            NutritionalPlanSchemeV3.self
        ]
    }
    
    public static var stages: [MigrationStage] {
        [migrateToV3]
    }
    
    public static let migrateToV2 = MigrationStage.custom(fromVersion: NutritionalPlanSchemeV1.self,
                                                   toVersion: NutritionalPlanSchemeV2.self,
                                                   willMigrate: nil) { context in
        let reports = try? context.fetch(FetchDescriptor<DailyReport>())
        reports?.forEach { $0.dailyConsumation = .defaultValues(with: $0) }
        try? context.save()
    }
    
    public static let migrateToV3 = MigrationStage.custom(fromVersion: NutritionalPlanSchemeV2.self,
                                                   toVersion: NutritionalPlanSchemeV3.self,
                                                   willMigrate: nil) { context in
        let reports = try? context.fetch(FetchDescriptor<DailyReport>())
        reports?.forEach {
            if $0.dailyConsumation == nil {
                $0.dailyConsumation = .defaultValues(with: $0)
            }
            $0.mealCounterConsumation = .init(report: $0)
        }
        try? context.save()
    }
    
}
