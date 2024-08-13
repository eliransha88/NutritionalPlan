//
//  WeeklyReportView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 31/07/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import SwiftUI
import SFSafeSymbols
import SwiftData

struct WeeklyReportView: View {
    
    @Environment(\.appPersistence) var appPersistence
    @State private var viewModel: WeeklyReportViewItem
    
    init(viewModel: WeeklyReportViewItem) {
        self._viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            SectionView(Strings.weeklyConsumption) {
                NutritionValuesConsumationView(totalConsumation: viewModel.totalWeeklyConsumation,
                                               consumation: viewModel.weeklyConsumation)
            }
            
            SectionView(Strings.nutritionalValuesCarbohydrate) {
                NutrutionChart(data: viewModel.carbohydrateData,
                               goal: appPersistence.carbohydrateDailyConsumption,
                               color: Colors.red)
            }
            
            SectionView(Strings.nutritionalValuesProtein) {
                NutrutionChart(data: viewModel.protienData,
                               goal: appPersistence.proteinDailyConsumption,
                               color: Colors.green)
            }
            
            SectionView(Strings.nutritionalValuesFat) {
                NutrutionChart(data: viewModel.fatData,
                               goal: appPersistence.fatDailyConsumption,
                               color: Colors.teal)
            }
        }
        .padding(.top, 48.0)
    }
    
}
