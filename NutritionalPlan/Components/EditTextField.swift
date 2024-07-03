//
//  EditTextField.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 30/06/2024.
//

import SwiftUI

struct EditTextField: View {
    
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    @Binding var text: String
    let isEditable: Bool
    
    init(title: String,
         placeholder: String,
         keyboardType: UIKeyboardType = .default,
         text: Binding<String>,
         isEditable: Bool) {
        self.title = title
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self._text = text
        self.isEditable = isEditable
    }
    
    var body: some View {
        
        HStack(spacing: 8.0) {
            Text(title + ":")
                .font(.headline)
            
            Group {
                if isEditable {
                    TextField(placeholder,
                              text: $text)
                    .keyboardType(keyboardType)
                } else {
                    Text(text)
                }
            }
            .font(.subheadline)
        }
    }
}
