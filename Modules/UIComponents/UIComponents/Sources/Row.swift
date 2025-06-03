//
//  Row.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 31/07/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import SwiftUI

public struct Row: View {
    
    let title: String
    let value: String
    let color: Color
    
    public init(title: String, value: String, color: Color) {
        self.title = title
        self.value = value
        self.color = color
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 2.0) {
            Text(title)
                .font(.body)
            
            Text(value)
                .font(.headline)
                .foregroundStyle(color)
        }
    }
}
