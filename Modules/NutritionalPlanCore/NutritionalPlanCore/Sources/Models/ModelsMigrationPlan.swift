//
//  NutritionalPlanSchemeV2.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftData

public enum NutritionalPlanSchemeV1: VersionedSchema {
    public static var models: [any PersistentModel.Type] { [DailyReport.self, Category.self] }
    
    public static var versionIdentifier: Schema.Version = .init(1, 0, 0)
}

public enum NutritionalPlanSchemeV2: VersionedSchema {
    public static var models: [any PersistentModel.Type] { [DailyReport.self, Category.self] }
    
    public static var versionIdentifier: Schema.Version = .init(1, 1, 0)
}

public enum MigrationPlan: SchemaMigrationPlan {
    public static var schemas: [any VersionedSchema.Type] {
        [
            NutritionalPlanSchemeV2.self
        ]
    }
    
    public static var stages: [MigrationStage] {
        [migrateToV2]
    }
    
    public static let migrateToV2 = MigrationStage.custom(fromVersion: NutritionalPlanSchemeV1.self,
                                                   toVersion: NutritionalPlanSchemeV2.self,
                                                   willMigrate: nil) { context in
        let reports = try? context.fetch(FetchDescriptor<DailyReport>())
        reports?.forEach({ $0.dailyConsumation = .defaultValues(with: $0) })
        try? context.save()
    }
    
}
