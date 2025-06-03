//
//  Array+ExtensionsTests.swift
//  Utilities_Tests
//
//  Created by Reuven Levitsky on 31/12/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class Array_ExtensionsTests: XCTestCase {

    // MARK: - second
    
    func test_second_returnsItem() {
        let testArray = [1, 2, 3]
        XCTAssertEqual(testArray.second, 2)
    }
    
    func test_second_oneItem() {
        let testArray = [1]
        XCTAssertNil(testArray.second)
    }
    
    // MARK: - third
    
    func test_third_returnsItem() {
        let testArray = [1, 2, 3]
        XCTAssertEqual(testArray.third, 3)
    }
    
    func test_third_twoItems() {
        let testArray = [1, 2]
        XCTAssertNil(testArray.third)
    }

}
