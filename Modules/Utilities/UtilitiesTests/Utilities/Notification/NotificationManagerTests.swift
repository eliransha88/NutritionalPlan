//
//  NotificationManagerTests.swift
//  Utilities_Tests
//
//  Created by Gal Orlanczyk on 26/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Utilities

fileprivate extension Notification.Name {
    static let testNotification = Notification.Name("test.test.test")
}

class NotificationManagerTests: XCTestCase {

    let notificationManager = NotificationManager()

    override func tearDown() {
        self.notificationManager.removeAll()
    }

    func testNotification() {
        let asyncExpectation = expectation(description: "wait for notification")
        self.notificationManager.subscribe(notificationName: .testNotification) { (_) in
            asyncExpectation.fulfill()
        }
        NotificationCenter.default.post(name: .testNotification, object: nil)
        wait(for: [asyncExpectation], timeout: 5)
    }

    func testObserverRemoved() {
        let asyncExpectation = expectation(description: "wait for notification ")
        weak var observer = self.notificationManager.subscribe(notificationName: .testNotification) { (_) in
            XCTFail()
        }
        XCTAssertNotNil(observer)
        if let observer = observer {
            self.notificationManager.remove(observer: observer)
        }
        XCTAssertNil(observer)
        NotificationCenter.default.post(name: .testNotification, object: nil)
        let timeout: TimeInterval = 2
        DispatchQueue.main.asyncAfter(deadline: .now() + (timeout - 1)) {
            asyncExpectation.fulfill()
        }
        wait(for: [asyncExpectation], timeout: timeout)
    }
    
    func testObserverRemovedOnDeinit() {
        var notificationManager: NotificationManager? = NotificationManager()
        let asyncExpectation = expectation(description: "wait for notification ")
        weak var observer = notificationManager?.subscribe(notificationName: .testNotification) { (_) in
            XCTFail()
        }
        XCTAssertNotNil(observer)
        if let _ = observer {
            notificationManager = nil
        }
        XCTAssertNil(observer)
        NotificationCenter.default.post(name: .testNotification, object: nil)
        let timeout: TimeInterval = 2
        DispatchQueue.main.asyncAfter(deadline: .now() + (timeout - 1)) {
            asyncExpectation.fulfill()
        }
        wait(for: [asyncExpectation], timeout: timeout)
    }

}
