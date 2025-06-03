//
//  Tests.swift
//  CheggAnalytics-Unit-Source-Tests
//
//  Created by Alon Zilbershtein on 29/12/2020.
//

import XCTest
@testable import Utilities

class Tests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_is_count_changed() {
        let testIsCountChanged = isCountChanged()
        let arr1 = [1, 2, 3]
        let arr2 = [1, 2, 3]
        let arr3 = [1, 2]
        
        XCTAssertTrue(testIsCountChanged(arr1))
        XCTAssertFalse(testIsCountChanged(arr2))
        XCTAssertTrue(testIsCountChanged(arr3))
    }
    
}
