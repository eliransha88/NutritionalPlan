//
//  NutritionalProgressBarView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 31/07/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import SwiftUI

struct NutritionalProgressBarView: View {
    
    struct Constants {
        static let carbohydrateProgressSize: CGSize = 140.asSize
        static let proteinProgressSize: CGSize = 95.asSize
        static let fatProgressSize: CGSize = 50.asSize
    }
    
    @Binding var carbohydrateProgress: Double
    @Binding var proteinProgress: Double
    @Binding var fatProgress: Double
    
    var body: some View {
        ZStack {
            CircularProgressBarView(progress: carbohydrateProgress,
                                    color: Colors.red)
            .frame(size: Constants.carbohydrateProgressSize)
            
            CircularProgressBarView(progress: proteinProgress,
                                    color: Colors.green)
            .frame(size: Constants.proteinProgressSize)
            
            CircularProgressBarView(progress: fatProgress,
                                    color: Colors.teal)
            .frame(size: Constants.fatProgressSize)
        }
    }
}

#Preview {
    NutritionalProgressBarView(carbohydrateProgress: .constant(0.7),
                               proteinProgress: .constant(0.3),
                               fatProgress: .constant(0.8))
}
