//
//  DailyNutritionalProgressBarView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 08/07/2024.
//

import SwiftUI

struct DailyNutritionalProgressBarView: View {
    
    struct Constants {
        static let carbohydrateProgressSize: CGSize = 130.asSize
        static let proteinProgressSize: CGSize = 90.asSize
        static let fatProgressSize: CGSize = 50.asSize
    }
    
    @State private var carbohydrateProgress: Double = 0.0
    @State private var proteinProgress: Double = 0.0
    @State private var fatProgress: Double = 0.0
    
    let report: DailyReport
    let dailyConsumation: DailyReportNutritionalValues
    
    init(report: DailyReport, dailyConsumation: DailyReportNutritionalValues) {
        self.report = report
        self.dailyConsumation = dailyConsumation
    }
    
    var body: some View {
        ZStack {
            CircularProgressBarView(progress: carbohydrateProgress,
                                    color: .green)
            .frame(size: Constants.carbohydrateProgressSize)
            
            CircularProgressBarView(progress: proteinProgress,
                                    color: .red)
            .frame(size: Constants.proteinProgressSize)
            
            CircularProgressBarView(progress: fatProgress,
                                    color: .blue)
            .frame(size: Constants.fatProgressSize)
        }
        .onAppear {
            withAnimation(.spring().delay(1.0)) {
                carbohydrateProgress = report.totalNutritionalValues.carbohydrate / dailyConsumation.carbohydrate

                proteinProgress = report.totalNutritionalValues.protein / dailyConsumation.protein
     
                fatProgress = report.totalNutritionalValues.fat / dailyConsumation.fat
            }
        }
    }
}
