//
//  KIFUITestActor+TextField.swift
//  SystemTestsSDK
//
//  Created by Reuven Levitsky on 07/11/2021.
//  Copyright © 2021 Chegg. All rights reserved.
//

import Foundation
import KIF

public extension KIFUITestActor {

    /// Please don't use KIF's enterText(intoViewWithAccessibilityIdentifier:) method, it sometimes causes view hierarchy to be retained until the test ends.
    /// Instead please use this method that forces autorelease after calling KIF's method.
    /// We could remove this if KIF will add `autoreleasepool` on their implementation.
    ///
    /// - Parameters:
    ///   - text: The text to enter.
    ///   - identifier: Accessibility identifier
    ///   - expectedResult: If given, this method will verify that that the text after entering equals to the given value.
    func safeEnterText(_ text: String,
                       intoViewWithAccessibilityIdentifier identifier: String,
                       expectedResult: String? = nil) {
        autoreleasepool {
            enterText(text,
                      intoViewWithAccessibilityIdentifier: identifier,
                      expectedResult: expectedResult)
        }
    }

}
