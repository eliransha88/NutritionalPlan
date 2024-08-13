//
//  Numbers+Extension.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 02/08/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import Foundation

extension Double {
    var asString: String {
        self == floor(self) ? Int(self).description : self.description
    }
    
    
    var asSize: CGSize {
        .init(width: self, height: self)
    }
}

extension Int {
    
    var asSize: CGSize {
        .init(width: self, height: self)
    }
}
