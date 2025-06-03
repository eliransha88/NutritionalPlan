//
//  EditTextField.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 30/06/2024.
//

import SwiftUI
import UIKit
import Utilities

public struct EditTextField: View {
    
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    @Binding var text: String
    let isEditable: Bool
    
    public init(title: String,
         placeholder: String = UIComponentsStrings.insertValue,
         keyboardType: UIKeyboardType = .default,
         text: Binding<String>,
         isEditable: Bool) {
        self.title = title
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self._text = text
        self.isEditable = isEditable
    }
    
    public var body: some View {
        
        HStack(spacing: 8.0) {
            Text(title + ":")
                .font(.headline)
            
            Group {
                if isEditable {
                    TextField(placeholder,
                              text: $text)
                    .textInputAutocapitalization(.never)
                    .textContentType(nil)
                    .keyboardType(.default)
                } else {
                    Text(text)
                }
            }
            .font(.subheadline)
        }
    }
}

public struct EditDoubleTextField: View {
        
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    @Binding var text: Double
    let formatter: Formatter
    let isEditable: Bool
    
    public init(title: String,
         placeholder: String = UIComponentsStrings.insertValue,
         keyboardType: UIKeyboardType = .decimalPad,
         text: Binding<Double>,
         formatter: Formatter,
         isEditable: Bool) {
        self.title = title
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self._text = text
        self.formatter = formatter
        self.isEditable = isEditable
    }
    
    public var body: some View {
        
        HStack(spacing: 8.0) {
            Text(title + ":")
                .font(.headline)
            
            Group {
                if isEditable {
                    TextField(placeholder,
                              value: $text,
                              formatter: formatter)
                    .textInputAutocapitalization(.never)
                    .textContentType(nil)
                    .keyboardType(.decimalPad)
                } else {
                    Text(text.asString)
                }
            }
            .font(.subheadline)
        }
    }
}
