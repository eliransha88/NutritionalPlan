//
//  StringExtensionsTests.swift
//  Utilities_Tests
//
//  Created by Gal Orlanczyk on 26/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Utilities

class StringExtensionsTests: XCTestCase {
    
    func testToJsonString() {
        let jsonArrayString = "[ {\"name\": \"John\", \"age\": 21}, {\"name\": \"Bob\", \"age\": 35} ]"
        let jsonObjectString = "{\"name\": \"John\", \"age\": 21}"
    
        let dict: [String: Any] = jsonObjectString.toJsonDictionary() as! [String: Any]
        XCTAssertEqual(dict["name"] as! String, "John")
        XCTAssertEqual(dict["age"] as! Int, 21)
        
        let jsonObject = jsonArrayString.toJsonObject() as! [[String: Any]]
        XCTAssertEqual(jsonObject.count, 2)
        XCTAssertEqual(jsonObject[1]["name"] as! String, "Bob")
        XCTAssertEqual(jsonObject[1]["age"] as! Int, 35)
    }
    
    // MARK: - isEmptyOrWhitespaces
    
    func test_isEmptyOrWhitespaces_notEmpty() {
        XCTAssertFalse(" age \n".isEmptyOrWhitespaces)
    }
    
    func test_isEmptyOrWhitespaces_empty_withSpaces() {
        XCTAssertTrue("     ".isEmptyOrWhitespaces)
    }
    
    func test_isEmptyOrWhitespaces_empty_withNewLine() {
        XCTAssertTrue("\n\n\n".isEmptyOrWhitespaces)
    }
    
    // MARK: - unknownIfEmpty
    
    func test_unknownIfEmpty_isEmptyString() {
        XCTAssertEqual("".unknownIfEmpty, String.unknown)
    }
    
    func test_unknownIfEmpty_isNotEmptyString() {
        let testString = " "
        XCTAssertEqual(testString.unknownIfEmpty, testString)
    }
    
    // MARK: - unknownIfNil
    
    func test_unknownIfNil_isEmptyString() {
        let testString = ""
        XCTAssertEqual(String.unknownIfNil(testString), testString)
    }
    
    func test_unknownIfNil_isNil() {
        XCTAssertEqual(String.unknownIfNil(nil), String.unknown)
    }
    
    // MARK: - unknownIfEmptyOrNil
    
    func test_unknownIfEmptyOrNil_isEmptyString() {
        XCTAssertEqual(String.unknownIfEmptyOrNil(""), String.unknown)
    }
    
    func test_unknownIfEmptyOrNil_Nil() {
        XCTAssertEqual(String.unknownIfEmptyOrNil(nil), String.unknown)
    }
    
    func test_unknownIfEmptyOrNil_isNotEmptyString() {
        let testString = " "
        XCTAssertEqual(String.unknownIfEmptyOrNil(testString), testString)
    }
    
}
