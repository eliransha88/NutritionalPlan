//
//  Row.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 31/07/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import SwiftUI

struct Row: View {
    
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2.0) {
            Text(title)
                .font(.body)
            
            Text(value)
                .font(.headline)
                .foregroundStyle(color)
        }
    }
}
