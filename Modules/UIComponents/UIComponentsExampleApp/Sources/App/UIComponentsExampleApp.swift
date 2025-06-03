//
//  UIComponentsExampleApp.swift
//  UIComponentsExampleApp
//
//  Created by Itamar Manor on 25/01/2024.
//

import SwiftUI

@main
struct UIComponentsExampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                UIComponentsExampleAppRootView()
            }.navigationViewStyle(.stack)
        }
    }
}

