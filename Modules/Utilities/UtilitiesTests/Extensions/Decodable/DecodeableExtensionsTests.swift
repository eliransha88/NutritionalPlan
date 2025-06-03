//
//  DecodeableExtensionsTests.swift
//  Utilities_Tests
//
//  Created by Gal Orlanczyk on 26/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import Utilities

class DecodeableExtensionsTests: XCTestCase {
    
    struct Test: Decodable {
        let name: String
        let age: Int
    }
    
    func testObjectFromJsonObject() {
        let jsonObjectString = "{\"name\": \"John\", \"age\": 21}".toJsonObject()
        let test = try! Test.object(from: jsonObjectString!)
        XCTAssertEqual(test.name, "John")
        XCTAssertEqual(test.age, 21)
    }
    
    func testInvalidJsonObjectThrowsError() {
        let invalidJsonObject = ["test_key": InvalidJsonObject_TestClass()]
        
        do {
            _ = try Test.object(from: invalidJsonObject)
            XCTFail("Should have got error thrown.")
        } catch {
            guard let jsonDecodingError = error as? JSONDecodableError else {
                XCTFail("The error received is unexpected.")
                return
            }
            
            guard case .invalidJsonObject = jsonDecodingError else {
                XCTFail("The jsonDecodingError received is unexpected.")
                return
            }
        }
        
    }
    
    class InvalidJsonObject_TestClass {
        
    }

}
