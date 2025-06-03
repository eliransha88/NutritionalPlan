//
//  KIFExtensions.swift
//  CheggStudyUITests
//
//  Created by Roni Poyas on 05/06/2018.
//  Copyright © 2018 Chegg Inc. All rights reserved.
//

import Foundation
import XCTest
import KIF

public extension XCTestCase {
	func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
		return KIFUITestActor(inFile: file, atLine: line, delegate: self)
	}

	func system(file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
		return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
	}
}

public extension KIFTestActor {
	func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
		return KIFUITestActor(inFile: file, atLine: line, delegate: self)
	}

	func system(file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
		return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
	}
}
