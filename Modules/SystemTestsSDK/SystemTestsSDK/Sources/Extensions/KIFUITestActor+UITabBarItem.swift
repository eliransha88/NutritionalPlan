//
//  KIFUITestActor+UITabBarItem.swift
//  SystemTestsSDK
//
//  Created by Reuven Levitsky on 17/04/2022.
//  Copyright © 2022 Chegg. All rights reserved.
//

import Foundation

import KIF

public extension KIFUITestActor {
        
    /// This method waits until the badge is visible AND shows the given value.
    ///
    /// - Parameters:
    ///   - tabBarItem: tabBarItem for test.
    ///   - value: the extpected value to show.
    func waitForTabBarItemBadgeToShow(for tabBarItem: UITabBarItem?,
                                      value: String) {
        guard let tabBarItem = tabBarItem else {
            let error = NSError(domain: "Chegg.KIFUITestActor",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "TabBarItem given is nil."])
            failWithError(error,
                          stopTest: true)
            return
        }
        
        tester().run { [weak self] (errorPointer) -> KIFTestStepResult in
            guard let _ = self else { return .failure }
            
            let error = NSError(domain: "Chegg.KIFUITestActor",
                                code: 0,
                                userInfo: [
                                    NSLocalizedDescriptionKey: "Badge was never showing the given value: \(value). Last check it showed: \(String(describing: tabBarItem.badgeValue))"
                                ])
            errorPointer?.pointee = error
            
            guard tabBarItem.badgeValue == value else {
                return .wait
            }
            
            return .success
        }
    }
        
    /// This method waits until the tabBarItem shows no badge.
    ///
    /// - Parameters:
    ///   - tabBarItem: tabBarItem for test.
    func waitForTabBarItemBadgeToNotShow(for tabBarItem: UITabBarItem?) {
        guard let tabBarItem = tabBarItem else {
            let error = NSError(domain: "Chegg.KIFUITestActor",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "TabBarItem given is nil."])
            failWithError(error,
                          stopTest: true)
            return
        }
        
        tester().run { [weak self] (errorPointer) -> KIFTestStepResult in
            guard let _ = self else { return .failure }
            
            let error = NSError(domain: "Chegg.KIFUITestActor",
                                code: 0,
                                userInfo: [
                                    NSLocalizedDescriptionKey: "Badge was showing: \(tabBarItem.badgeValue), and was never dismissed."
                                ])
            errorPointer?.pointee = error
            
            guard tabBarItem.badgeValue == nil else {
                return .wait
            }
            
            return .success
        }
    }
    
}
