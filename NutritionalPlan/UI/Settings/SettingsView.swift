//
//  SettingsView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI
import SFSafeSymbols

struct SettingsView: View {
    
    enum Field: Int {
        case carbohydrate
        case protein
        case fat
        
        var nextField: Field? {
            Field(rawValue: rawValue + 1)
        }
        
        var previousField: Field? {
            Field(rawValue: rawValue - 1)
        }
    }
    
    @FocusState private var focusedField: Field?
    
    @AppStorage("carbohydrateDailyConsumption") private var carbohydrateDailyConsumption : String = "4"
    @AppStorage("proteinDailyConsumption") private var proteinDailyConsumption : String = "3.4"
    @AppStorage("fatDailyConsumption") private var fatDailyConsumption : String = "3"
    
    var body: some View {
        List {
            Section("daily_consumption") {
                EditTextField(title: "daily_nutritional_values_carbohydrate",
                              placeholder: "insert_value",
                              keyboardType: .decimalPad,
                              text: $carbohydrateDailyConsumption,
                              isEditable: true)
                .focused($focusedField, equals: .carbohydrate)
                
                EditTextField(title: "daily_nutritional_values_protein",
                              placeholder: "insert_value",
                              keyboardType: .decimalPad,
                              text: $proteinDailyConsumption,
                              isEditable: true)
                .focused($focusedField, equals: .protein)
                
                EditTextField(title: "daily_nutritional_values_fat",
                              placeholder: "insert_value",
                              keyboardType: .decimalPad,
                              text: $fatDailyConsumption,
                              isEditable: true)
                .focused($focusedField, equals: .fat)
            }

        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("", systemImage: SFSymbol.chevronUp.rawValue) {
                    focusedField = focusedField?.previousField
                }
                .disabled(focusedField == .carbohydrate)
                
                Button("", systemImage: SFSymbol.chevronDown.rawValue) {
                    focusedField = focusedField?.nextField
                }
                .disabled(focusedField == .fat)
                
                Spacer()
                
                Button("done_button") {
                    focusedField = nil
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .onSubmit {
            focusedField = focusedField?.nextField
        }
    }
}
