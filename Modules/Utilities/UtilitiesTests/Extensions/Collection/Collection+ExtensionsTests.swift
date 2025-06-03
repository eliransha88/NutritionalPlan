//
//  Collection+ExtensionsTests.swift
//  Utilities_Example
//
//  Created by Reuven Levitsky on 31/12/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class Collection_ExtensionsTests: XCTestCase {
    
    // MARK: - subscript(safe i: Index)
    
    func test_subscriptSafe_inRange() {
        let testArray = [1, 2, 3]
        XCTAssertEqual(testArray[safe: 2], 3)
    }
    
    func test_subscriptSafe_outOfRange() {
        let testArray = [1, 2, 3]
        XCTAssertNil(testArray[safe: 3])
    }
    
    func test_subscriptSafe_emptyArray() {
        let testArray: [Int] = []
         XCTAssertNil(testArray[safe: 0])
     }

}
