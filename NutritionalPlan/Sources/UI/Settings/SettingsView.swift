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
    
    @Environment(\.appPersistence) var appPersistence
    @FocusState private var focusedField: Field?
    
    var body: some View {
        List {
            
            SectionView(Strings.settingsViewShareSectionTitle) {
                EditTextField(title: Strings.settingsViewSharePhoneNumberTitle,
                              keyboardType: .phonePad,
                              text: appPersistence.$phoneNumber,
                              isEditable: true)
                .focused($focusedField, equals: .phoneNumber)
                .padding(.horizontal)
            }
            
            SectionView(Strings.dailyConsumption) {
                
                EditTextField(title: Strings.dailyNutritionalValuesCarbohydrate,
                              keyboardType: .decimalPad,
                              text: appPersistence.$carbohydrateDailyConsumption,
                              isEditable: true)
                .focused($focusedField, equals: .carbohydrate)
                .padding(.horizontal)
                
                EditTextField(title: Strings.dailyNutritionalValuesProtein,
                              keyboardType: .decimalPad,
                              text: appPersistence.$proteinDailyConsumption,
                              isEditable: true)
                .focused($focusedField, equals: .protein)
                .padding(.horizontal)
                
                EditTextField(title: Strings.dailyNutritionalValuesFat,
                              keyboardType: .decimalPad,
                              text: appPersistence.$fatDailyConsumption,
                              isEditable: true)
                .focused($focusedField, equals: .fat)
                .padding(.horizontal)
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
        .onSubmit {
            focusedField = focusedField?.nextField
        }
    }
}
