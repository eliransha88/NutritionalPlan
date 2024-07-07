//
//  SettingsView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI
import SFSafeSymbols

struct SettingsView: View {
    
    enum Field: Int, CaseIterable {
        case phoneNumber
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
    let dailyNutritionalValuesService: DailyNutritionalValuesService = .init()
    let shareWhatsappMessageService: ShareWhatsappMessageService = .init()
    
    var body: some View {
        List {
            
            Section(Strings.settingsViewShareSectionTitle) {
                EditTextField(title: Strings.settingsViewSharePhoneNumberTitle,
                              keyboardType: .phonePad,
                              text: shareWhatsappMessageService.$phoneNumber,
                              isEditable: true)
                .focused($focusedField, equals: .phoneNumber)
            }
            
            Section(Strings.dailyConsumption) {
                EditTextField(title: Strings.dailyNutritionalValuesCarbohydrate,
                              keyboardType: .decimalPad,
                              text: dailyNutritionalValuesService.$carbohydrateDailyConsumption,
                              isEditable: true)
                .focused($focusedField, equals: .carbohydrate)
                
                EditTextField(title: Strings.dailyNutritionalValuesProtein,
                              keyboardType: .decimalPad,
                              text: dailyNutritionalValuesService.$proteinDailyConsumption,
                              isEditable: true)
                .focused($focusedField, equals: .protein)
                
                EditTextField(title: Strings.dailyNutritionalValuesFat,
                              keyboardType: .decimalPad,
                              text: dailyNutritionalValuesService.$fatDailyConsumption,
                              isEditable: true)
                .focused($focusedField, equals: .fat)
            }

        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("", systemImage: SFSymbol.chevronUp.rawValue) {
                    focusedField = focusedField?.previousField
                }
                .disabled(focusedField == Field.allCases.first)
                
                Button("", systemImage: SFSymbol.chevronDown.rawValue) {
                    focusedField = focusedField?.nextField
                }
                .disabled(focusedField == Field.allCases.last)
                
                Spacer()
                
                Button(Strings.doneButton) {
                    focusedField = nil
                }
            }
        }
        .navigationTitle(Strings.settingsTitle)
        .toolbarRole(.editor)
        .onSubmit {
            focusedField = focusedField?.nextField
        }
    }
}
