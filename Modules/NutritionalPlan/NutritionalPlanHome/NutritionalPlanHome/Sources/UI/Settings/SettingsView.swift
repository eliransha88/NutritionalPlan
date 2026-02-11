//
//  SettingsView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI
import SFSafeSymbols
import SwiftData
import UIComponents
import NutritionalPlanCore

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
    @State private var useMealsCounter: Bool = false
    
    var currentReport: DailyReport? {
        reports.first(where: { Calendar.current.isDateInToday($0.date) })
    }
    
    let amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        return formatter
    }()
    
    let rowInsets: EdgeInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
    
    var body: some View {
        Form {
            
            SectionView(Strings.settingsViewSettingsSectionTitle, rowInsets: rowInsets) {
                Toggle(isOn: $useMealsCounter) {
                    Text(Strings.settingsViewUseMealsCounter)
                }
            }
            
            SectionView(Strings.settingsViewShareSectionTitle, rowInsets: rowInsets) {
                EditTextField(title: Strings.settingsViewSharePhoneNumberTitle,
                              keyboardType: .phonePad,
                              text: appPersistence.$phoneNumber,
                              isEditable: true)
                .focused($focusedField, equals: .phoneNumber)
            }
            
            SectionView(Strings.dailyConsumption, rowInsets: rowInsets) {
                
                EditDoubleTextField(title: Strings.dailyNutritionalValuesCarbohydrate,
                                    keyboardType: .decimalPad,
                                    text: appPersistence.$carbohydrateDailyConsumption,
                                    formatter: amountFormatter,
                                    isEditable: true)
                .focused($focusedField, equals: .carbohydrate)
                
                EditDoubleTextField(title: Strings.dailyNutritionalValuesProtein,
                                    keyboardType: .decimalPad,
                                    text: appPersistence.$proteinDailyConsumption,
                                    formatter: amountFormatter,
                                    isEditable: true)
                .focused($focusedField, equals: .protein)
                
                EditDoubleTextField(title: Strings.dailyNutritionalValuesFat,
                                    keyboardType: .decimalPad,
                                    text: appPersistence.$fatDailyConsumption,
                                    formatter: amountFormatter,
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
        .onChange(of: useMealsCounter) { _, newValue in
            appPersistence.useMealsCounter = useMealsCounter
        }
        .task {
            useMealsCounter = appPersistence.useMealsCounter
        }
    }
}
