//
//  Extensions.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 01/07/2024.
//

import Foundation
import SwiftUI
import SFSafeSymbols

typealias VoidHandler = () -> Void

extension Double {
    var asString: String {
        self == floor(self) ? Int(self).description : self.description
    }
}

extension Array {
    var isNotEmpty: Bool {
        !self.isEmpty
    }
}

extension String {
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    var asDouble: Double {
        Double(self) ?? 0
    }
}
