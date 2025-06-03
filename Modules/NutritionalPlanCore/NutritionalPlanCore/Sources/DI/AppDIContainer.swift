//
//  AppDIContainer.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 14/07/2024.
//  Copyright © 2024 Eliran Sharabi. All rights reserved.
//

import Foundation
import Swinject

public class AppDIContainer {
    
    public static let shared = AppDIContainer()
    
    let container: Container = .init()
    
    private init() {}
    
    public func setup() {
        container.register(ShareWhatsappMessageServiceProtocol.self) { _ in ShareWhatsappMessageService() }
        container.register(NutritionalPlanServiceProtocol.self) { _ in NutritionalPlanService() }
    }
    
    func resolve<T>(_ protocolType: T.Type) -> T?  {
        container.resolve(protocolType)
    }
}
