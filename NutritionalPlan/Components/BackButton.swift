//
//  BackButton.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 01/07/2024.
//

import SwiftUI

struct BackButtonModifier: ViewModifier {
    
    let action: VoidHandler
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("",
                           systemImage: "chevron.left",
                           action: action)
                }
            }
    }
}

extension View {
    
    func backButton(action: @escaping VoidHandler) -> some View {
        modifier(BackButtonModifier(action: action))
    }
}
