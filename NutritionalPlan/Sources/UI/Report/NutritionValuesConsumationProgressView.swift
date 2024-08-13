//
//  NutritionValuesConsumationProgressView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 31/07/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import SwiftUI

struct NutritionValuesConsumationProgressView: View {
    
    @State private var carbohydrateProgress: Double = 0.0
    @State private var proteinProgress: Double = 0.0
    @State private var fatProgress: Double = 0.0
    
    let totalConsumation: NutritionalValues
    let consumation: DailyReportNutritionalValues
        
    var body: some View {
        NutritionalProgressBarView(carbohydrateProgress: $carbohydrateProgress,
                                   proteinProgress: $proteinProgress,
                                   fatProgress: $fatProgress)
        .onAppear {
            withAnimation {
                carbohydrateProgress = totalConsumation.carbohydrate / consumation.carbohydrate
                proteinProgress =  totalConsumation.protein / consumation.protein
                fatProgress =  totalConsumation.fat / consumation.fat
            }
        }
    }
}
