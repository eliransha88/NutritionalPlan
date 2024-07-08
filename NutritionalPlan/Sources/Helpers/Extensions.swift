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
    
    
    var asSize: CGSize {
        .init(width: self, height: self)
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

extension View {

    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        self.frame(width: size.width, height: size.height, alignment: alignment)
    }
}

extension Int {
    
    var asSize: CGSize {
        .init(width: self, height: self)
    }
}

extension EdgeInsets {
    
    init(inset: CGFloat) {
        self.init(top: inset,
                  leading: inset,
                  bottom: inset,
                  trailing: inset)
    }
}
