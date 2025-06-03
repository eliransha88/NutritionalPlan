//
//  String+Extension.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 02/08/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import Foundation

public extension String {
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    var asDouble: Double {
        Double(self) ?? 0
    }
}
