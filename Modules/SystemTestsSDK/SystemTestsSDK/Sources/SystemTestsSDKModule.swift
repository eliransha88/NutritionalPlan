//
//  SystemTestsSDKModule.swift
//  SystemTestsSDK
//
//  Created by Reuven Levitsky on 01/08/2019.
//  Copyright © 2019 Chegg. All rights reserved.
//

import Foundation
import CheggDI
import CheggCore
import UIComponents

class SystemTestsSDKModule: NSObject, CheggModuleProtocol {

    @LazyInject var configManager: CheggConfigurationManagerProtocol
    override init() {
        super.init()

        // We have to disable NewRelic very early for SystemTests because they cause many crashes making our tests flaky for all of our apps.
        disableNewRelic()
    }

    func disableNewRelic() {
        configManager.config.features.analytics.newRelic.enabled = false
    }
}
