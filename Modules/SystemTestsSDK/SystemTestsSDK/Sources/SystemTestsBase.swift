//
//  KIFTesterExtensions.swift
//  CheggStudyUITests
//
//  Created by Roni Poyas on 24/05/2018.
//  Copyright © 2018 Chegg Inc. All rights reserved.
//

import Foundation
import KIF
import CheggDI
import CheggUI
import CheggCore
import CheggNetwork

open class SystemTestsBase: KIFTestCase {

    struct Constants {
        static let defaultTimeOut: TimeInterval = 30.0
    }

    @Inject var modulesProvider: ApplicationModulesProviderProtocol!

	public var testMockingHelper = DefaultTestsHelper()
	public var authHelper = AuthenticationHelper.shared
    @LazyInject var cheggApiClient: CheggApiClientProtocol    

    /// This method runs once before executing the first test in the class.
    /// This should be used for navigating to the starting point in the app where all tests will start from. Because this method is not guaranteed to run in the same instance as tests, it should not be used for setting up instance variables but can be used for setting up static variables.
    /// When you override this method please call superclass implementation.
    open override func beforeAll() {
        super.beforeAll()
        
        tester().executionBlockTimeout = Constants.defaultTimeOut
        KIFUITestActor.setDefaultTimeout(Constants.defaultTimeOut)
        
        // Please don't do additional cleanups or configuration change here, instead please add it in `SharedCleanupHelper`.
    }

    /// This method runs before each test.
    /// This should be used for any common tasks required before each test.  Because this method is guaranteed to run in the same instance as tests,
    /// it can be used for setting up instance variables. When you override this method please call superclass implementation.
    open override func beforeEach() {
        super.beforeEach()

        resetAppState()
        
        // We have a problem that sometimes tests are failed due to "Application is ignoring interaction events", we add this to prevent this from happening
        UIApplication.shared.endIgnoringInteractionEvents()
        
        // Please don't do additional cleanups or configuration change here, instead please add it in `SharedCleanupHelper`.
	}

    /// This method runs after each test.
    /// This should be used for restoring the app to the state it was in before the test. This could include conditional logic to recover from failed tests.
	open override func afterEach() {
		super.afterEach()
    }

    open override func afterAll() {
        super.afterAll()
    }

    /// Resets the app's state before the test.
    /// Please don't change this flow / add new steps unless you have to. It should stay very simple and general.
    func resetAppState() {

        // Wait for animations to finish before dismissing the current rootViewController in order to try and avoid VC parallel dismissal.
        tester().waitForAnimationsToFinish()
        // In order to avoid memory leaks of the rootViewController we make sure to dismiss all it's modals before replacing the root.
        // See this link for more details: https://tech.showmax.com/2019/02/uiviewcontroller-memory-leak/
        tester().waitForAsyncBlock(operation: dismissAllModalViewControllers,
                                   errorDescription: "Failed dismissAllModalViewControllers")
        tester().waitForAsyncBlock(operation: cleanAppWindowRootViewController,
                                   errorDescription: "Failed cleanAppWindowRootViewController")

        cheggApiClient.cancelAllRequests()
        self.testMockingHelper.stubsManager.removeAllStubs()
        waitForLogOutIfNeeded()

        // Any other cleanups to shared code should be done in `SharedCleanupHelper`.
        SharedCleanupHelper().cleanSharedCodeBeforeTest()
    }

    /// This method is waiting until logout is done.
    /// You can override this method if you need a different implementation. Leaving it empty will skip this phase in the test.
    open func waitForLogOutIfNeeded() {
        tester().waitForAsyncBlock(operation: self.authHelper.clearAuthenticationStateIfNeeded,
                                   errorDescription: "Failed waitForLogOutIfNeeded.")
    }

    open func readyForTests() {
        tester().waitForAsyncBlock(operation: setAppNewRootVC,
                                   errorDescription: "Failed setAppNewRootVC.")
    }

    /// Replaces the App's windows's rootviewcontroller back to main viewController (home screen).
    ///
    /// - Parameter completion: completion to be invoked when replacing the rootViewController was done.
    open func replaceAppWindowRootViewController(rootVC: UIViewController,
                                                 completion: @escaping () -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let rootWindow = appDelegate.window!

        // Removes any window on top - for example the SSHUDView's window when signing in.
        rootWindow.makeKeyAndVisible()

        let oldRootViewController = rootWindow.rootViewController
        rootWindow.rootViewController = rootVC
        appDelegate.mainAppContainer = rootVC

        // In order to properly allow the previous root VC be deallocated we need to dismiss it async from the new root replacement.
        DispatchQueue.main.async { [weak self] in
            guard let _ = self else { return }

            oldRootViewController?.dismiss(animated: false,
                                           completion: nil)
            completion()
        }
    }

    open func setAppNewRootVC(completion: @escaping () -> Void) {
        let mainModule = self.modulesProvider.mainPresentableModule
        let newRootVC = mainModule!.entryPoint!

        replaceAppWindowRootViewController(rootVC: newRootVC,
                                           completion: completion)
    }

    func cleanAppWindowRootViewController(completion: @escaping () -> Void) {
        replaceAppWindowRootViewController(rootVC: UIViewController(),
                                           completion: completion)
    }

    /// Dismisses all the modals currently visible.
    ///
    /// - Parameter completion: completion that should be invoked when all modals are dimissed.
    open func dismissAllModalViewControllers(completion: @escaping () -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window = appDelegate.window!
        let rootVC = window.rootViewController

        if rootVC?.presentedViewController != nil {
            rootVC?.dismiss(animated: false,
                            completion: completion)
        } else {
            completion()
        }
    }

    public func addSharedStubs(loginType: LoginType = .subscriber, exclude: [RequestStub.Type] = []) {
        let stubs = SharedStubsHelper().getSharedStubs(loginType: loginType, exclude: exclude)
        self.testMockingHelper.stubsManager.add(stubs: stubs)
    }
}

extension SystemTestsBase {

    // MARK: Assertion
    
    open func cheggXCTAssertTrue(_ expression: Bool, _ errorMessage: String? = nil) {
        if !expression {
            tester().failWithError(NSError(domain: "chegg",
                                           code: 1,
                                           userInfo: [NSLocalizedDescriptionKey: errorMessage ?? "\(expression)"]),
                                   stopTest: true)
        }
    }
    
    public func cheggXCTAssertEqual<T: Equatable>(_ first: T, _ second: T, _ errorMessage: String? = nil) {
        cheggXCTAssertTrue(first == second,
                           errorMessage ?? "Not equal. First: \(first), second: \(second)")
    }
    
}
