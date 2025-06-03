//
//  SharedCleanupHelper.swift
//  SystemTestsSDK
//
//  Created by Reuven Levitsky on 04/02/2020.
//  Copyright © 2020 Chegg. All rights reserved.
//

import Foundation
import CheggDI
import CheggCore

class SharedCleanupHelper: NSObject {

    @LazyInject var configManager: CheggConfigurationManagerProtocol
    @LazyInject var coreConfigManager: CheggCoreConfigurationManagerProtocol
    @LazyInject var subscriptionStatusService: SubscriptionStatusServiceProtocol? // It's optional since not all the app has iap framework that has the implementation.
    var authHelper = AuthenticationHelper.shared

    /// This method should include all the cleanups in our shared frameworks that might cause tests to be flaky.
    func cleanSharedCodeBeforeTest() {
        // Without cleaning this service `self.refreshInProgress` might stay stuck on true before KIF will have the chance to set the stub. That might result in endless loading after sign in.
        subscriptionStatusService?.clearUserPurchases()        
        disableRio()
        disableLogs()
        disableAnalytics()
        self.authHelper.setSharedCredentialsToDisabled()
    }

}

// MARK: General helpers
extension SharedCleanupHelper {

    func disableRio() {
        let configManager = AppDIContainer.shared.resolve(CheggConfigurationManagerProtocol.self)!
        configManager.config.features.analytics.rio.enabled = false
    }

    func disableLogs() {
        self.coreConfigManager.config.logging.newRelic.enabled = false
        self.coreConfigManager.config.logging.cheggLogger.enabled = false
    }

    func disableAnalytics() {
        self.coreConfigManager.config.features.analytics.newRelic.enabled = false
    }
}
