//
//  Router.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import Foundation
import SwiftUI
import Observation

@Observable public final class Router {
    
    public var navigationPath = NavigationPath()
    
    public init() {}
    
    public func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }
    
    public func navigateBack() {
        navigationPath.removeLast()
    }
    
    public func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
