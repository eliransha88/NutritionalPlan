//
//  Scheme+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 24/05/2022.
//

import ProjectDescription

public extension Scheme {
    static func app(appName: String,
                    ref: Reference,
                    testingTargets: [TestableTarget]? = nil,
                    testPlans: [Path]? = nil,
                    runTarget: TargetReference? = nil) -> Scheme {
        
        self.app(appName: appName,
                 schemeName: ref.schemeName,
                 buildTarget: ref.targetReference,
                 testPlans: testPlans,
                 testingTargets: testingTargets,
                 runTarget: runTarget)
    }
    
    static func app(appName: String,
                    schemeName: String,
                    buildTarget: TargetReference,
                    testPlans: [Path]? = nil,
                    testingTargets: [TestableTarget]? = nil,
                    runTarget: TargetReference? = nil) -> Scheme {
        
        var defaultTestPlans: [Path] = []
        // Add debug dependencies based on "TUIST_TEST_PLAN" env variable
        // Can receive either {appName}UnitTests or {appName}SystemTests values
        // Used in the CI because currently it takes the default test plan instead of what we ask for
        // https://docs.tuist.io/guides/environment
        let testPlan = Environment.testPlan.getString(default: "")
        let appNameFromEnv = Environment.appName.getString(default: "")
        
        let appNameForTestPlan = appNameFromEnv.isEmpty ? appName : appNameFromEnv
        if testPlan.isEmpty {
            defaultTestPlans = [.relativeToAppResources("TestPlans/\(appNameForTestPlan)/\(appNameForTestPlan)UnitTests.xctestplan"),
                                            .relativeToAppResources("TestPlans/\(appNameForTestPlan)/\(appNameForTestPlan)SystemTests.xctestplan")]
        } else {
            defaultTestPlans = [.relativeToAppResources("TestPlans/\(appNameForTestPlan)/\(testPlan).xctestplan")]
        }

        let testPlans: [Path] = testPlans ?? defaultTestPlans
        
        return Scheme.scheme(
            name: schemeName,
            shared: true,
            hidden: false,
            buildAction: .buildAction(
                targets: [buildTarget],
                preActions: []
            ),
            testAction: testingTargets != nil ? .targets(testingTargets!) : .testPlans(testPlans),
            runAction: .runAction(executable: runTarget ?? buildTarget)
        )
    }
}
