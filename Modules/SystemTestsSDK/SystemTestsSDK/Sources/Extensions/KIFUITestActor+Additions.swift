//
//  KIFUITestActor+Additions.swift
//  SystemTestsSDK
//
//  Created by Reuven Levitsky on 05/11/2019.
//  Copyright © 2019 Chegg. All rights reserved.
//

import Foundation

import KIF

public typealias KIFUITestActorSimpleAsyncOperation = (@escaping () -> Void) -> Void

public extension KIFUITestActor {

    /// This method will test if view is visible
    /// It uses Apple's hitTest method to know if the view is shown or not, therefore it will work only for views with userInteraction enabled.
    ///
    /// It results with success if ALL of the following takes place:
    /// 1. Alpha > 0.01.
    /// 2. isHidden = false.
    /// 3. View is not blocked by other userInteraction enabled views.
    /// 4. The view is whithin it's parent's bounds.
    ///
    /// When animations are running while calling this method - it will look for the final frame of the animating views -
    /// so don't be scared if the test finish before the animation is done, it knows if the view will be tappable at the end of the animation or not.
    ///
    /// - Parameter id: AccessibilityIdentifier of the view to test against.
    func waitForVisibleView(withAccessibilityIdentifier id: String) {
        tester().waitForTappableView(withAccessibilityIdentifier: id)
    }

    /// This method will test to check if invisible - means not shown.
    /// It uses Apple's hitTest method to know if the view is shown or not, therefore it will work only for views with userInteraction enabled.
    ///
    /// It results with success if ONE of the following takes place:
    /// 1. Alpha = 0.
    /// 2. isHidden = true.
    /// 3. View is completely blocked by other view.
    /// 4. The view is off screen / or off it's parent's bounds.
    ///
    /// When animations are running while calling this method - it will look for the final frame of the animating views -
    /// so don't be scared if the test finish before the animation is done, it knows if the view will be tappable at the end of the animation or not.
    ///
    /// - Parameter id: AccessibilityIdentifier of the view to test against.
    func waitForInvisibleView(withAccessibilityIdentifier id: String) {
        tester().run { [weak self] (errorPointer) -> KIFTestStepResult in
            let error = NSError(domain: "KIFUITestActor",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Didn't find an invisible view with id: \(id)."])
            errorPointer?.pointee = error

            guard let self = self else { return .failure }

            let didFindTappableView = self.tester().tryFindingTappableView(withAccessibilityIdentifier: id)
            return didFindTappableView ? .wait : .success
        }
    }

    /// This method looks for a tapable view in the view hierarchy.
    /// - Parameter id: AccessibilityIdentifier of the view to test against.
    /// - Returns: true if the view with the given id isHidden=true and is tappable.
    func tryFindingTappableView(withAccessibilityIdentifier id: String) -> Bool {
        let predicate = NSPredicate(format: "accessibilityIdentifier = %@", id)

        guard let _ = try? UIAccessibilityElement.accessibilityElement(nil,
                                                                       view: nil,
                                                                       withElementMatching: predicate,
                                                                       tappable: true) else {
                                                                        return false
        }
        return true
    }

    /// This method verifies the status bar is hidden.
    func waitForStatusBar() {
        tester().run { [weak self] (errorPointer) -> KIFTestStepResult in
            let error = NSError(domain: "KIFUITestActor",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Statusbar is not showing although it should."])
            errorPointer?.pointee = error

            guard let _ = self else { return .failure }

            let isStatusBarHidden = UIApplication.shared.isStatusBarHidden
            return isStatusBarHidden ? .wait : .success
        }
    }

    /// This method verifies the status bar is hidden.
    func waitForAbsenceOfStatusBar() {
        tester().run { [weak self] (errorPointer) -> KIFTestStepResult in
            let error = NSError(domain: "KIFUITestActor",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Statusbar is showing although it shouldn't."])
            errorPointer?.pointee = error

            guard let _ = self else { return .failure }

            let isStatusBarHidden = UIApplication.shared.isStatusBarHidden
            return isStatusBarHidden ? .success : .wait
        }
    }

    /// This is a generic method you can use in order to wait for async operation with the KIF style -
    /// (KIF Style - It checks periodically if the operation is over, and adds timeout ability - more time efficient than just dispatch async)
    ///
    /// - Parameters:
    ///   - operation: The async operation to be performed.
    ///   - errorDescription: Error description to be thrown when the phase fails waiting.
    func waitForAsyncBlock(operation: @escaping KIFUITestActorSimpleAsyncOperation,
                           errorDescription: String) {
        var didFinishTask = false

        DispatchQueue.main.async {
            // Run the operation.
            operation {
                didFinishTask = true
            }
        }

        tester().run { [weak self] (errorPointer) -> KIFTestStepResult in
            guard let _ = self else { return .failure }

            let error = NSError(domain: "SystemTestsBase.waitForAsyncBlock",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: errorDescription])
            errorPointer?.pointee = error

            return didFinishTask ? .success : .wait
        }
    }

}
