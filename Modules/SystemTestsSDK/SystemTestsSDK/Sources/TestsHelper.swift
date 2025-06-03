//
// Created by Gal Orlanczyk on 23/04/2018.
// Copyright (c) 2018 Chegg. All rights reserved.
//

import Foundation

/// `StubsManager` provides a simple protocol to follow for each stubbing manager we will have.
public protocol StubsManager {

    /// Use this variable in order to add additional mocked hosts other than the shared ones.
    var customMockedHosts: [String]? { get set }

    /// Adds a stub and returns an object to be able to remove later if needed.
    ///
    /// - Parameter stub: The stub object containing all the need information for response and matchers.
    /// - Returns: An object to be used with remove(stub: _) later if needed.
    @discardableResult
    func add(stub: RequestStub) -> Any

    /// Adds multiple stubs in bulk
    ///
    /// - Parameter stubs: The stub objectt containing all the need information for response and matchers.
    func add(stubs: [RequestStub])

    /// Add a custom stub allowing with custom match handler and custom response, returns an opaque object to be able to remove later.
    ///
    /// - Parameters:
    ///   - matchHandler: custom match handler to check the matching of the stub from the url request.
    ///   - responseHandler: custom response handler, gives the ability to return different responses according to the url request.
    @discardableResult
    func addRequestStub(passingMatch matchHandler: @escaping (URLRequest) -> Bool, withResponse responseHandler: @escaping (URLRequest) -> RequestStubResponse) -> Any

    /// Removes a stub using the object provided from adding a stub.
    ///
    /// - Parameter stub: The opaque object received from adding the stub.
    func remove(stub: Any)

    /// Removes all added stubs.
    func removeAllStubs()
}

public protocol TestsHelper {
    var stubsManager: StubsManager { get set }
    func silentLogin()
}

extension TestsHelper {
    public func silentLogin() {
        // TODO: implement later on
    }
}

public class DefaultTestsHelper: TestsHelper {
    public var stubsManager: StubsManager

    public init(stubsManager: StubsManager = OHHTTPStubsManager()) {
        self.stubsManager = stubsManager
    }
}
