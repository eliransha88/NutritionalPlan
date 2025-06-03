//
//  DiffUtilsTests.swift
//  Utilities_Tests
//
//  Created by Reuven Levitsky on 03/10/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import Utilities

class DiffUtilsTests: XCTestCase {
    
    // MARK: - Diff
    
    func testDiff_Common() {
        let comparator: (Int, String) -> Bool = { firstElement, secondElement in
            return Int(secondElement) == firstElement
        }
        let first: [Int] = [1, 2, 3, 4]
        let second: [String] = ["1", "2", "6", "3", "5"]
        
        let diff = DiffUtils.diff(first, second, with: comparator)
        
        let expectedResultCommon: [(Int, String)] = [(1, "1"), (2, "2"), (3, "3")]
        XCTAssertEqual(expectedResultCommon.count, diff.common.count)
        for (firstElement, secondElement) in diff.common {
            XCTAssertTrue(expectedResultCommon.contains { (f, s) -> Bool in
                return firstElement == f && secondElement == s
            })
        }
    }
    
    func testDiff_Removed() {
        let comparator: (Int, String) -> Bool = { firstElement, secondElement in
            return Int(secondElement) == firstElement
        }
        let first: [Int] = [1, 2, 3, 4]
        let second: [String] = ["1", "2", "6", "3", "5"]
        
        let diff = DiffUtils.diff(first, second, with: comparator)
        
        let expectedResultRemoved: [Int] = [4]
        XCTAssertEqual(expectedResultRemoved.count, diff.removed.count)
        for firstElement in diff.removed {
            XCTAssertTrue(expectedResultRemoved.contains { (f) -> Bool in
                return firstElement == f
            })
        }
    }
    
    func testDiff_Inserted() {
        let comparator: (Int, String) -> Bool = { firstElement, secondElement in
            return Int(secondElement) == firstElement
        }
        let first: [Int] = [1, 2, 3, 4]
        let second: [String] = ["1", "2", "6", "3", "5"]
        
        let diff = DiffUtils.diff(first, second, with: comparator)
        
        let expectedResultInserted: [String] = ["5", "6"]
        XCTAssertEqual(expectedResultInserted.count, diff.inserted.count)
        for secondElement in diff.inserted {
            XCTAssertTrue(expectedResultInserted.contains { (s) -> Bool in
                return secondElement == s
            })
        }
    }
    
    // MARK: - DiffEquatable
    
    func testDiffEquatable_Common() {
        let first: [Int] = [1, 2, 3, 4]
        let second: [Int] = [1, 2, 6, 3, 5]
        
        let diff = DiffUtils.diff(first, second)
        
        let expectedResultCommon = [(1, 1), (2, 2), (3, 3)]
        XCTAssertEqual(expectedResultCommon.count, diff.common.count)
        for (firstElement, secondElement) in diff.common {
            XCTAssertTrue(expectedResultCommon.contains { (f, s) -> Bool in
                return firstElement == f && secondElement == s
            })
        }
    }
    
    func testDiffEquatable_Removed() {
        let first: [Int] = [1, 2, 3, 4]
        let second: [Int] = [1, 2, 6, 3, 5]
        
        let diff = DiffUtils.diff(first, second)
        
        let expectedResultRemoved = [4]
        XCTAssertEqual(expectedResultRemoved, diff.removed)
    }
    
    func testDiffEquatable_Inserted() {
        let first: [Int] = [1, 2, 3, 4]
        let second: [Int] = [1, 2, 6, 3, 5]
        
        let diff = DiffUtils.diff(first, second)
        
        let expectedResultInserted = [6, 5]
        XCTAssertEqual(expectedResultInserted, diff.inserted)
    }
    
}
