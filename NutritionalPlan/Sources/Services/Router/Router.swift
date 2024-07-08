//
//  Router.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import Foundation
import SwiftUI
import Observation

@Observable final class Router {
    
    var navigationPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
