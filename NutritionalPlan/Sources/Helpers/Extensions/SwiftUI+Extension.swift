//
//  View+Extension.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 02/08/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import SwiftUI

typealias VoidHandler = () -> Void

extension View {
    
    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        self.frame(width: size.width, height: size.height, alignment: alignment)
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
