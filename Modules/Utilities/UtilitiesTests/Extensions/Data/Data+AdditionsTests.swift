//
//  Data+AdditionsTests.swift
//  Utilities_Example
//
//  Created by Reuven Levitsky on 30/10/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class DataAdditionsTests: XCTestCase {
    
    // MARK: hexString() -> String
    
    func test_hexString_not_empty() {
        let data = Data(bytes: [0, 1, 127, 128, 255])
        let result = data.hexString()
        XCTAssertEqual(result, "00017f80ff")
    }
    
    func test_hexString_empty() {
        let data = Data()
        let result = data.hexString()
        XCTAssertEqual(result, "")
    }

}
