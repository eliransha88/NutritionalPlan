//
//  SettingsView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI
import SFSafeSymbols
import SwiftData

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
    
    @Query var reports: [DailyReport]
    @Environment(\.appPersistence) var appPersistence
    @FocusState private var focusedField: Field?
    
    var currentReport: DailyReport? {
        reports.first(where: { Calendar.current.isDateInToday($0.date) })
    }
    
    let amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        return formatter
    }()
    
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
                
                EditDoubleTextField(title: Strings.dailyNutritionalValuesCarbohydrate,
                                    keyboardType: .decimalPad,
                                    text: appPersistence.$carbohydrateDailyConsumption,
                                    formatter: amountFormatter,
                                    isEditable: true)
                .focused($focusedField, equals: .carbohydrate)
                .padding(.horizontal)
                
                EditDoubleTextField(title: Strings.dailyNutritionalValuesProtein,
                                    keyboardType: .decimalPad,
                                    text: appPersistence.$proteinDailyConsumption,
                                    formatter: amountFormatter,
                                    isEditable: true)
                .focused($focusedField, equals: .protein)
                .padding(.horizontal)
                
                EditDoubleTextField(title: Strings.dailyNutritionalValuesFat,
                                    keyboardType: .decimalPad,
                                    text: appPersistence.$fatDailyConsumption,
                                    formatter: amountFormatter,
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
        .onChange(of: appPersistence.carbohydrateDailyConsumption) { _, newValue in
            currentReport?.dailyConsumation?.carbohydrate = newValue
        }
        .onChange(of: appPersistence.proteinDailyConsumption) { _, newValue in
            currentReport?.dailyConsumation?.protein = newValue
        }
        .onChange(of: appPersistence.fatDailyConsumption) { _, newValue in
            currentReport?.dailyConsumation?.fat = newValue
        }
    }
}
