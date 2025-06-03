//
//  Bundle+SystemTestsSDK.swift
//  SystemTestsSDK
//
//  Created by Reuven Levitsky on 10/11/2019.
//  Copyright © 2019 Chegg. All rights reserved.
//

import Foundation

public extension Bundle {

    private class DummySystemTestsSDKClass {}

    static private let bundleName = "SystemTestsSDKBundle"

    static var systemTestsSDK: Bundle {
        return SystemTestsSDKResources.bundle
    }
}
