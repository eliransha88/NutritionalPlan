// MARK: - Mocks generated from file: Utilities/Sources/Utilities/TextToSpeech/TTSEngine.swift at 2022-09-06 18:34:00 +0000

//
//  TTSEngine.swift
//  Utilities
//
//  Created by Maor Karo on 17/12/2020.
//  Copyright © 2020 Chegg Inc. All rights reserved.
//

import Cuckoo
@testable import Utilities

import AVFoundation
import Foundation

 class MockTTSEngineProtocol: TTSEngineProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = TTSEngineProtocol
    
     typealias Stubbing = __StubbingProxy_TTSEngineProtocol
     typealias Verification = __VerificationProxy_TTSEngineProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)
    
    private var __defaultImplStub: TTSEngineProtocol?

     func enableDefaultImplementation(_ stub: TTSEngineProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
     var currentState: TTSEngineState {
        get {
            return cuckoo_manager.getter("currentState",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.currentState)
        }
        
    }
    
     var onStateChangeObserver: ((TTSEngineState) -> Void)? {
        get {
            return cuckoo_manager.getter("onStateChangeObserver",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onStateChangeObserver)
        }
        
        set {
            cuckoo_manager.setter("onStateChangeObserver",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onStateChangeObserver = newValue)
        }
        
    }
    
     var onSpeechProgressObserver: ((NSRange) -> Void)? {
        get {
            return cuckoo_manager.getter("onSpeechProgressObserver",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onSpeechProgressObserver)
        }
        
        set {
            cuckoo_manager.setter("onSpeechProgressObserver",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onSpeechProgressObserver = newValue)
        }
        
    }
    
     var availableVoices: [TTSEngineSpeechVoice] {
        get {
            return cuckoo_manager.getter("availableVoices",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.availableVoices)
        }
        
    }
    
     var currentVoice: TTSEngineSpeechVoice? {
        get {
            return cuckoo_manager.getter("currentVoice",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.currentVoice)
        }
        
        set {
            cuckoo_manager.setter("currentVoice",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.currentVoice = newValue)
        }
        
    }
    
     var readingRate: Float {
        get {
            return cuckoo_manager.getter("readingRate",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.readingRate)
        }
        
        set {
            cuckoo_manager.setter("readingRate",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.readingRate = newValue)
        }
        
    }
    
     func setup() {
        
    return cuckoo_manager.call(
    """
    setup()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
     func play(text: String) {
        
    return cuckoo_manager.call(
    """
    play(text: String)
    """,
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.play(text: text))
        
    }
    
     func pause() -> Bool {
        
    return cuckoo_manager.call(
    """
    pause() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.pause())
        
    }
    
     func resume() -> Bool {
        
    return cuckoo_manager.call(
    """
    resume() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.resume())
        
    }
    
     func stop() -> Bool {
        
    return cuckoo_manager.call(
    """
    stop() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.stop())
        
    }

     struct __StubbingProxy_TTSEngineProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var currentState: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTTSEngineProtocol, TTSEngineState> {
            return .init(manager: cuckoo_manager, name: "currentState")
        }
        
        var onStateChangeObserver: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockTTSEngineProtocol, ((TTSEngineState) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onStateChangeObserver")
        }
        
        var onSpeechProgressObserver: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockTTSEngineProtocol, ((NSRange) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onSpeechProgressObserver")
        }
        
        var availableVoices: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTTSEngineProtocol, [TTSEngineSpeechVoice]> {
            return .init(manager: cuckoo_manager, name: "availableVoices")
        }
        
        var currentVoice: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockTTSEngineProtocol, TTSEngineSpeechVoice> {
            return .init(manager: cuckoo_manager, name: "currentVoice")
        }
        
        var readingRate: Cuckoo.ProtocolToBeStubbedProperty<MockTTSEngineProtocol, Float> {
            return .init(manager: cuckoo_manager, name: "readingRate")
        }
        
        func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngineProtocol.self, method:
    """
    setup()
    """, parameterMatchers: matchers))
        }
        
        func play<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngineProtocol.self, method:
    """
    play(text: String)
    """, parameterMatchers: matchers))
        }
        
        func pause() -> Cuckoo.ProtocolStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngineProtocol.self, method:
    """
    pause() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func resume() -> Cuckoo.ProtocolStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngineProtocol.self, method:
    """
    resume() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func stop() -> Cuckoo.ProtocolStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngineProtocol.self, method:
    """
    stop() -> Bool
    """, parameterMatchers: matchers))
        }
        
    }

     struct __VerificationProxy_TTSEngineProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        var currentState: Cuckoo.VerifyReadOnlyProperty<TTSEngineState> {
            return .init(manager: cuckoo_manager, name: "currentState", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var onStateChangeObserver: Cuckoo.VerifyOptionalProperty<((TTSEngineState) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onStateChangeObserver", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var onSpeechProgressObserver: Cuckoo.VerifyOptionalProperty<((NSRange) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onSpeechProgressObserver", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var availableVoices: Cuckoo.VerifyReadOnlyProperty<[TTSEngineSpeechVoice]> {
            return .init(manager: cuckoo_manager, name: "availableVoices", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentVoice: Cuckoo.VerifyOptionalProperty<TTSEngineSpeechVoice> {
            return .init(manager: cuckoo_manager, name: "currentVoice", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var readingRate: Cuckoo.VerifyProperty<Float> {
            return .init(manager: cuckoo_manager, name: "readingRate", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func setup() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    setup()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func play<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
            return cuckoo_manager.verify(
    """
    play(text: String)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func pause() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    pause() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func resume() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    resume() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func stop() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    stop() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }
}

 class TTSEngineProtocolStub: TTSEngineProtocol {
    
     var currentState: TTSEngineState {
        get {
            return DefaultValueRegistry.defaultValue(for: (TTSEngineState).self)
        }
        
    }
    
     var onStateChangeObserver: ((TTSEngineState) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((TTSEngineState) -> Void)?).self)
        }
        
        set { }
        
    }
    
     var onSpeechProgressObserver: ((NSRange) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((NSRange) -> Void)?).self)
        }
        
        set { }
        
    }
    
     var availableVoices: [TTSEngineSpeechVoice] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([TTSEngineSpeechVoice]).self)
        }
        
    }
    
     var currentVoice: TTSEngineSpeechVoice? {
        get {
            return DefaultValueRegistry.defaultValue(for: (TTSEngineSpeechVoice?).self)
        }
        
        set { }
        
    }
    
     var readingRate: Float {
        get {
            return DefaultValueRegistry.defaultValue(for: (Float).self)
        }
        
        set { }
        
    }
    
     func setup() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func play(text: String) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func pause() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     func resume() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     func stop() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
}

 class MockTTSEngine: TTSEngine, Cuckoo.ClassMock {
    
     typealias MocksType = TTSEngine
    
     typealias Stubbing = __StubbingProxy_TTSEngine
     typealias Verification = __VerificationProxy_TTSEngine

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)
    
    private var __defaultImplStub: TTSEngine?

     func enableDefaultImplementation(_ stub: TTSEngine) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
     override var currentState: TTSEngineState {
        get {
            return cuckoo_manager.getter("currentState",
                superclassCall:
                    
                    super.currentState
                    ,
                defaultCall: __defaultImplStub!.currentState)
        }
        
        set {
            cuckoo_manager.setter("currentState",
                value: newValue,
                superclassCall:
                    
                    super.currentState = newValue
                    ,
                defaultCall: __defaultImplStub!.currentState = newValue)
        }
        
    }
    
     override var askedToStopWithoutClosingAudioSession: Bool {
        get {
            return cuckoo_manager.getter("askedToStopWithoutClosingAudioSession",
                superclassCall:
                    
                    super.askedToStopWithoutClosingAudioSession
                    ,
                defaultCall: __defaultImplStub!.askedToStopWithoutClosingAudioSession)
        }
        
        set {
            cuckoo_manager.setter("askedToStopWithoutClosingAudioSession",
                value: newValue,
                superclassCall:
                    
                    super.askedToStopWithoutClosingAudioSession = newValue
                    ,
                defaultCall: __defaultImplStub!.askedToStopWithoutClosingAudioSession = newValue)
        }
        
    }
    
     override var askedToStopSynthesizer: Bool {
        get {
            return cuckoo_manager.getter("askedToStopSynthesizer",
                superclassCall:
                    
                    super.askedToStopSynthesizer
                    ,
                defaultCall: __defaultImplStub!.askedToStopSynthesizer)
        }
        
        set {
            cuckoo_manager.setter("askedToStopSynthesizer",
                value: newValue,
                superclassCall:
                    
                    super.askedToStopSynthesizer = newValue
                    ,
                defaultCall: __defaultImplStub!.askedToStopSynthesizer = newValue)
        }
        
    }
    
     override var onStateChangeObserver: ((TTSEngineState) -> Void)? {
        get {
            return cuckoo_manager.getter("onStateChangeObserver",
                superclassCall:
                    
                    super.onStateChangeObserver
                    ,
                defaultCall: __defaultImplStub!.onStateChangeObserver)
        }
        
        set {
            cuckoo_manager.setter("onStateChangeObserver",
                value: newValue,
                superclassCall:
                    
                    super.onStateChangeObserver = newValue
                    ,
                defaultCall: __defaultImplStub!.onStateChangeObserver = newValue)
        }
        
    }
    
     override var onSpeechProgressObserver: ((NSRange) -> Void)? {
        get {
            return cuckoo_manager.getter("onSpeechProgressObserver",
                superclassCall:
                    
                    super.onSpeechProgressObserver
                    ,
                defaultCall: __defaultImplStub!.onSpeechProgressObserver)
        }
        
        set {
            cuckoo_manager.setter("onSpeechProgressObserver",
                value: newValue,
                superclassCall:
                    
                    super.onSpeechProgressObserver = newValue
                    ,
                defaultCall: __defaultImplStub!.onSpeechProgressObserver = newValue)
        }
        
    }
    
     override var currentAVSpeechVoice: AVSpeechSynthesisVoice? {
        get {
            return cuckoo_manager.getter("currentAVSpeechVoice",
                superclassCall:
                    
                    super.currentAVSpeechVoice
                    ,
                defaultCall: __defaultImplStub!.currentAVSpeechVoice)
        }
        
        set {
            cuckoo_manager.setter("currentAVSpeechVoice",
                value: newValue,
                superclassCall:
                    
                    super.currentAVSpeechVoice = newValue
                    ,
                defaultCall: __defaultImplStub!.currentAVSpeechVoice = newValue)
        }
        
    }
    
     override var currentUtterance: AVSpeechUtterance? {
        get {
            return cuckoo_manager.getter("currentUtterance",
                superclassCall:
                    
                    super.currentUtterance
                    ,
                defaultCall: __defaultImplStub!.currentUtterance)
        }
        
        set {
            cuckoo_manager.setter("currentUtterance",
                value: newValue,
                superclassCall:
                    
                    super.currentUtterance = newValue
                    ,
                defaultCall: __defaultImplStub!.currentUtterance = newValue)
        }
        
    }
    
     override var currentVoice: TTSEngineSpeechVoice? {
        get {
            return cuckoo_manager.getter("currentVoice",
                superclassCall:
                    
                    super.currentVoice
                    ,
                defaultCall: __defaultImplStub!.currentVoice)
        }
        
        set {
            cuckoo_manager.setter("currentVoice",
                value: newValue,
                superclassCall:
                    
                    super.currentVoice = newValue
                    ,
                defaultCall: __defaultImplStub!.currentVoice = newValue)
        }
        
    }
    
     override var availableVoices: [TTSEngineSpeechVoice] {
        get {
            return cuckoo_manager.getter("availableVoices",
                superclassCall:
                    
                    super.availableVoices
                    ,
                defaultCall: __defaultImplStub!.availableVoices)
        }
        
        set {
            cuckoo_manager.setter("availableVoices",
                value: newValue,
                superclassCall:
                    
                    super.availableVoices = newValue
                    ,
                defaultCall: __defaultImplStub!.availableVoices = newValue)
        }
        
    }
    
     override var synthesizer: AVSpeechSynthesizer {
        get {
            return cuckoo_manager.getter("synthesizer",
                superclassCall:
                    
                    super.synthesizer
                    ,
                defaultCall: __defaultImplStub!.synthesizer)
        }
        
        set {
            cuckoo_manager.setter("synthesizer",
                value: newValue,
                superclassCall:
                    
                    super.synthesizer = newValue
                    ,
                defaultCall: __defaultImplStub!.synthesizer = newValue)
        }
        
    }
    
     override var lastLocation: Int? {
        get {
            return cuckoo_manager.getter("lastLocation",
                superclassCall:
                    
                    super.lastLocation
                    ,
                defaultCall: __defaultImplStub!.lastLocation)
        }
        
        set {
            cuckoo_manager.setter("lastLocation",
                value: newValue,
                superclassCall:
                    
                    super.lastLocation = newValue
                    ,
                defaultCall: __defaultImplStub!.lastLocation = newValue)
        }
        
    }
    
     override var readingRate: Float {
        get {
            return cuckoo_manager.getter("readingRate",
                superclassCall:
                    
                    super.readingRate
                    ,
                defaultCall: __defaultImplStub!.readingRate)
        }
        
        set {
            cuckoo_manager.setter("readingRate",
                value: newValue,
                superclassCall:
                    
                    super.readingRate = newValue
                    ,
                defaultCall: __defaultImplStub!.readingRate = newValue)
        }
        
    }
    
     override func setup() {
        
    return cuckoo_manager.call(
    """
    setup()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.setup()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
     override func updateCurrentUtterance() {
        
    return cuckoo_manager.call(
    """
    updateCurrentUtterance()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.updateCurrentUtterance()
                ,
            defaultCall: __defaultImplStub!.updateCurrentUtterance())
        
    }
    
     override func replaceFirstCharactersWithWhiteSpaces(_ text: String, length: Int) -> String {
        
    return cuckoo_manager.call(
    """
    replaceFirstCharactersWithWhiteSpaces(_: String, length: Int) -> String
    """,
            parameters: (text, length),
            escapingParameters: (text, length),
            superclassCall:
                
                super.replaceFirstCharactersWithWhiteSpaces(text, length: length)
                ,
            defaultCall: __defaultImplStub!.replaceFirstCharactersWithWhiteSpaces(text, length: length))
        
    }
    
     override func play(text: String) {
        
    return cuckoo_manager.call(
    """
    play(text: String)
    """,
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                super.play(text: text)
                ,
            defaultCall: __defaultImplStub!.play(text: text))
        
    }
    
     override func startPlayText(text: String) {
        
    return cuckoo_manager.call(
    """
    startPlayText(text: String)
    """,
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                super.startPlayText(text: text)
                ,
            defaultCall: __defaultImplStub!.startPlayText(text: text))
        
    }
    
     override func buildUtterance(with text: String) -> AVSpeechUtterance {
        
    return cuckoo_manager.call(
    """
    buildUtterance(with: String) -> AVSpeechUtterance
    """,
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                super.buildUtterance(with: text)
                ,
            defaultCall: __defaultImplStub!.buildUtterance(with: text))
        
    }
    
     override func resume() -> Bool {
        
    return cuckoo_manager.call(
    """
    resume() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.resume()
                ,
            defaultCall: __defaultImplStub!.resume())
        
    }
    
     override func clearAVSpeechSynthesizerIfNeeded() {
        
    return cuckoo_manager.call(
    """
    clearAVSpeechSynthesizerIfNeeded()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.clearAVSpeechSynthesizerIfNeeded()
                ,
            defaultCall: __defaultImplStub!.clearAVSpeechSynthesizerIfNeeded())
        
    }
    
     override func pause() -> Bool {
        
    return cuckoo_manager.call(
    """
    pause() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.pause()
                ,
            defaultCall: __defaultImplStub!.pause())
        
    }
    
     override func stop() -> Bool {
        
    return cuckoo_manager.call(
    """
    stop() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.stop()
                ,
            defaultCall: __defaultImplStub!.stop())
        
    }
    
     override func handleStop() -> Bool {
        
    return cuckoo_manager.call(
    """
    handleStop() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.handleStop()
                ,
            defaultCall: __defaultImplStub!.handleStop())
        
    }
    
     override func initAudioSession() -> TTSEngineErrorType? {
        
    return cuckoo_manager.call(
    """
    initAudioSession() -> TTSEngineErrorType?
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.initAudioSession()
                ,
            defaultCall: __defaultImplStub!.initAudioSession())
        
    }
    
     override func setApplicationAudio(active: Bool) -> TTSEngineErrorType? {
        
    return cuckoo_manager.call(
    """
    setApplicationAudio(active: Bool) -> TTSEngineErrorType?
    """,
            parameters: (active),
            escapingParameters: (active),
            superclassCall:
                
                super.setApplicationAudio(active: active)
                ,
            defaultCall: __defaultImplStub!.setApplicationAudio(active: active))
        
    }
    
     override func handleApplicationAudio(isActive: Bool, successState: TTSEngineState) {
        
    return cuckoo_manager.call(
    """
    handleApplicationAudio(isActive: Bool, successState: TTSEngineState)
    """,
            parameters: (isActive, successState),
            escapingParameters: (isActive, successState),
            superclassCall:
                
                super.handleApplicationAudio(isActive: isActive, successState: successState)
                ,
            defaultCall: __defaultImplStub!.handleApplicationAudio(isActive: isActive, successState: successState))
        
    }
    
     override func reset() {
        
    return cuckoo_manager.call(
    """
    reset()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.reset()
                ,
            defaultCall: __defaultImplStub!.reset())
        
    }

     struct __StubbingProxy_TTSEngine: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var currentState: Cuckoo.ClassToBeStubbedProperty<MockTTSEngine, TTSEngineState> {
            return .init(manager: cuckoo_manager, name: "currentState")
        }
        
        var askedToStopWithoutClosingAudioSession: Cuckoo.ClassToBeStubbedProperty<MockTTSEngine, Bool> {
            return .init(manager: cuckoo_manager, name: "askedToStopWithoutClosingAudioSession")
        }
        
        var askedToStopSynthesizer: Cuckoo.ClassToBeStubbedProperty<MockTTSEngine, Bool> {
            return .init(manager: cuckoo_manager, name: "askedToStopSynthesizer")
        }
        
        var onStateChangeObserver: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSEngine, ((TTSEngineState) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onStateChangeObserver")
        }
        
        var onSpeechProgressObserver: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSEngine, ((NSRange) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onSpeechProgressObserver")
        }
        
        var currentAVSpeechVoice: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSEngine, AVSpeechSynthesisVoice> {
            return .init(manager: cuckoo_manager, name: "currentAVSpeechVoice")
        }
        
        var currentUtterance: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSEngine, AVSpeechUtterance> {
            return .init(manager: cuckoo_manager, name: "currentUtterance")
        }
        
        var currentVoice: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSEngine, TTSEngineSpeechVoice> {
            return .init(manager: cuckoo_manager, name: "currentVoice")
        }
        
        var availableVoices: Cuckoo.ClassToBeStubbedProperty<MockTTSEngine, [TTSEngineSpeechVoice]> {
            return .init(manager: cuckoo_manager, name: "availableVoices")
        }
        
        var synthesizer: Cuckoo.ClassToBeStubbedProperty<MockTTSEngine, AVSpeechSynthesizer> {
            return .init(manager: cuckoo_manager, name: "synthesizer")
        }
        
        var lastLocation: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSEngine, Int> {
            return .init(manager: cuckoo_manager, name: "lastLocation")
        }
        
        var readingRate: Cuckoo.ClassToBeStubbedProperty<MockTTSEngine, Float> {
            return .init(manager: cuckoo_manager, name: "readingRate")
        }
        
        func setup() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    setup()
    """, parameterMatchers: matchers))
        }
        
        func updateCurrentUtterance() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    updateCurrentUtterance()
    """, parameterMatchers: matchers))
        }
        
        func replaceFirstCharactersWithWhiteSpaces<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ text: M1, length: M2) -> Cuckoo.ClassStubFunction<(String, Int), String> where M1.MatchedType == String, M2.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(String, Int)>] = [wrap(matchable: text) { $0.0 }, wrap(matchable: length) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    replaceFirstCharactersWithWhiteSpaces(_: String, length: Int) -> String
    """, parameterMatchers: matchers))
        }
        
        func play<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    play(text: String)
    """, parameterMatchers: matchers))
        }
        
        func startPlayText<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    startPlayText(text: String)
    """, parameterMatchers: matchers))
        }
        
        func buildUtterance<M1: Cuckoo.Matchable>(with text: M1) -> Cuckoo.ClassStubFunction<(String), AVSpeechUtterance> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    buildUtterance(with: String) -> AVSpeechUtterance
    """, parameterMatchers: matchers))
        }
        
        func resume() -> Cuckoo.ClassStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    resume() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func clearAVSpeechSynthesizerIfNeeded() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    clearAVSpeechSynthesizerIfNeeded()
    """, parameterMatchers: matchers))
        }
        
        func pause() -> Cuckoo.ClassStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    pause() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func stop() -> Cuckoo.ClassStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    stop() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func handleStop() -> Cuckoo.ClassStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    handleStop() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func initAudioSession() -> Cuckoo.ClassStubFunction<(), TTSEngineErrorType?> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    initAudioSession() -> TTSEngineErrorType?
    """, parameterMatchers: matchers))
        }
        
        func setApplicationAudio<M1: Cuckoo.Matchable>(active: M1) -> Cuckoo.ClassStubFunction<(Bool), TTSEngineErrorType?> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: active) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    setApplicationAudio(active: Bool) -> TTSEngineErrorType?
    """, parameterMatchers: matchers))
        }
        
        func handleApplicationAudio<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(isActive: M1, successState: M2) -> Cuckoo.ClassStubNoReturnFunction<(Bool, TTSEngineState)> where M1.MatchedType == Bool, M2.MatchedType == TTSEngineState {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, TTSEngineState)>] = [wrap(matchable: isActive) { $0.0 }, wrap(matchable: successState) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    handleApplicationAudio(isActive: Bool, successState: TTSEngineState)
    """, parameterMatchers: matchers))
        }
        
        func reset() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSEngine.self, method:
    """
    reset()
    """, parameterMatchers: matchers))
        }
        
    }

     struct __VerificationProxy_TTSEngine: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        var currentState: Cuckoo.VerifyProperty<TTSEngineState> {
            return .init(manager: cuckoo_manager, name: "currentState", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var askedToStopWithoutClosingAudioSession: Cuckoo.VerifyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "askedToStopWithoutClosingAudioSession", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var askedToStopSynthesizer: Cuckoo.VerifyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "askedToStopSynthesizer", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var onStateChangeObserver: Cuckoo.VerifyOptionalProperty<((TTSEngineState) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onStateChangeObserver", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var onSpeechProgressObserver: Cuckoo.VerifyOptionalProperty<((NSRange) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onSpeechProgressObserver", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentAVSpeechVoice: Cuckoo.VerifyOptionalProperty<AVSpeechSynthesisVoice> {
            return .init(manager: cuckoo_manager, name: "currentAVSpeechVoice", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentUtterance: Cuckoo.VerifyOptionalProperty<AVSpeechUtterance> {
            return .init(manager: cuckoo_manager, name: "currentUtterance", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentVoice: Cuckoo.VerifyOptionalProperty<TTSEngineSpeechVoice> {
            return .init(manager: cuckoo_manager, name: "currentVoice", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var availableVoices: Cuckoo.VerifyProperty<[TTSEngineSpeechVoice]> {
            return .init(manager: cuckoo_manager, name: "availableVoices", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var synthesizer: Cuckoo.VerifyProperty<AVSpeechSynthesizer> {
            return .init(manager: cuckoo_manager, name: "synthesizer", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var lastLocation: Cuckoo.VerifyOptionalProperty<Int> {
            return .init(manager: cuckoo_manager, name: "lastLocation", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var readingRate: Cuckoo.VerifyProperty<Float> {
            return .init(manager: cuckoo_manager, name: "readingRate", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func setup() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    setup()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func updateCurrentUtterance() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    updateCurrentUtterance()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func replaceFirstCharactersWithWhiteSpaces<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ text: M1, length: M2) -> Cuckoo.__DoNotUse<(String, Int), String> where M1.MatchedType == String, M2.MatchedType == Int {
            let matchers: [Cuckoo.ParameterMatcher<(String, Int)>] = [wrap(matchable: text) { $0.0 }, wrap(matchable: length) { $0.1 }]
            return cuckoo_manager.verify(
    """
    replaceFirstCharactersWithWhiteSpaces(_: String, length: Int) -> String
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func play<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
            return cuckoo_manager.verify(
    """
    play(text: String)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func startPlayText<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
            return cuckoo_manager.verify(
    """
    startPlayText(text: String)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func buildUtterance<M1: Cuckoo.Matchable>(with text: M1) -> Cuckoo.__DoNotUse<(String), AVSpeechUtterance> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
            return cuckoo_manager.verify(
    """
    buildUtterance(with: String) -> AVSpeechUtterance
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func resume() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    resume() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func clearAVSpeechSynthesizerIfNeeded() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    clearAVSpeechSynthesizerIfNeeded()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func pause() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    pause() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func stop() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    stop() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func handleStop() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    handleStop() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func initAudioSession() -> Cuckoo.__DoNotUse<(), TTSEngineErrorType?> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    initAudioSession() -> TTSEngineErrorType?
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func setApplicationAudio<M1: Cuckoo.Matchable>(active: M1) -> Cuckoo.__DoNotUse<(Bool), TTSEngineErrorType?> where M1.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: active) { $0 }]
            return cuckoo_manager.verify(
    """
    setApplicationAudio(active: Bool) -> TTSEngineErrorType?
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func handleApplicationAudio<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(isActive: M1, successState: M2) -> Cuckoo.__DoNotUse<(Bool, TTSEngineState), Void> where M1.MatchedType == Bool, M2.MatchedType == TTSEngineState {
            let matchers: [Cuckoo.ParameterMatcher<(Bool, TTSEngineState)>] = [wrap(matchable: isActive) { $0.0 }, wrap(matchable: successState) { $0.1 }]
            return cuckoo_manager.verify(
    """
    handleApplicationAudio(isActive: Bool, successState: TTSEngineState)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func reset() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    reset()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }
}

 class TTSEngineStub: TTSEngine {
    
     override var currentState: TTSEngineState {
        get {
            return DefaultValueRegistry.defaultValue(for: (TTSEngineState).self)
        }
        
        set { }
        
    }
    
     override var askedToStopWithoutClosingAudioSession: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    
     override var askedToStopSynthesizer: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    
     override var onStateChangeObserver: ((TTSEngineState) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((TTSEngineState) -> Void)?).self)
        }
        
        set { }
        
    }
    
     override var onSpeechProgressObserver: ((NSRange) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((NSRange) -> Void)?).self)
        }
        
        set { }
        
    }
    
     override var currentAVSpeechVoice: AVSpeechSynthesisVoice? {
        get {
            return DefaultValueRegistry.defaultValue(for: (AVSpeechSynthesisVoice?).self)
        }
        
        set { }
        
    }
    
     override var currentUtterance: AVSpeechUtterance? {
        get {
            return DefaultValueRegistry.defaultValue(for: (AVSpeechUtterance?).self)
        }
        
        set { }
        
    }
    
     override var currentVoice: TTSEngineSpeechVoice? {
        get {
            return DefaultValueRegistry.defaultValue(for: (TTSEngineSpeechVoice?).self)
        }
        
        set { }
        
    }
    
     override var availableVoices: [TTSEngineSpeechVoice] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([TTSEngineSpeechVoice]).self)
        }
        
        set { }
        
    }
    
     override var synthesizer: AVSpeechSynthesizer {
        get {
            return DefaultValueRegistry.defaultValue(for: (AVSpeechSynthesizer).self)
        }
        
        set { }
        
    }
    
     override var lastLocation: Int? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int?).self)
        }
        
        set { }
        
    }
    
     override var readingRate: Float {
        get {
            return DefaultValueRegistry.defaultValue(for: (Float).self)
        }
        
        set { }
        
    }
    
     override func setup() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func updateCurrentUtterance() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func replaceFirstCharactersWithWhiteSpaces(_ text: String, length: Int) -> String {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func play(text: String) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func startPlayText(text: String) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func buildUtterance(with text: String) -> AVSpeechUtterance {
        return DefaultValueRegistry.defaultValue(for: (AVSpeechUtterance).self)
    }
    
     override func resume() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     override func clearAVSpeechSynthesizerIfNeeded() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func pause() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     override func stop() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     override func handleStop() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     override func initAudioSession() -> TTSEngineErrorType? {
        return DefaultValueRegistry.defaultValue(for: (TTSEngineErrorType?).self)
    }
    
     override func setApplicationAudio(active: Bool) -> TTSEngineErrorType? {
        return DefaultValueRegistry.defaultValue(for: (TTSEngineErrorType?).self)
    }
    
     override func handleApplicationAudio(isActive: Bool, successState: TTSEngineState) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func reset() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

// MARK: - Mocks generated from file: Utilities/Sources/Utilities/TextToSpeech/TTSManager.swift at 2022-09-06 18:34:00 +0000

//
//  TTSManager.swift
//  Utilities
//
//  Created by Maor Karo on 24/12/2020.
//  Copyright © 2020 Chegg Inc. All rights reserved.
//

import Cuckoo
@testable import Utilities

import Foundation
import MediaPlayer

public class MockTTSManagerProtocol: TTSManagerProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = TTSManagerProtocol
    
    public typealias Stubbing = __StubbingProxy_TTSManagerProtocol
    public typealias Verification = __VerificationProxy_TTSManagerProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)
    
    private var __defaultImplStub: TTSManagerProtocol?

    public func enableDefaultImplementation(_ stub: TTSManagerProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
    public var config: TTSManagerConfig? {
        get {
            return cuckoo_manager.getter("config",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.config)
        }
        
        set {
            cuckoo_manager.setter("config",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.config = newValue)
        }
        
    }
    
    public var onTTSManagerStateObserver: ((TTSManagerState) -> Void)? {
        get {
            return cuckoo_manager.getter("onTTSManagerStateObserver",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onTTSManagerStateObserver)
        }
        
        set {
            cuckoo_manager.setter("onTTSManagerStateObserver",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onTTSManagerStateObserver = newValue)
        }
        
    }
    
    public var onPlaylistObserver: ((PlaylistObserver) -> Void)? {
        get {
            return cuckoo_manager.getter("onPlaylistObserver",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onPlaylistObserver)
        }
        
        set {
            cuckoo_manager.setter("onPlaylistObserver",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.onPlaylistObserver = newValue)
        }
        
    }
    
    public var availableVoices: [TTSVoice] {
        get {
            return cuckoo_manager.getter("availableVoices",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.availableVoices)
        }
        
    }
    
    public var currentState: TTSManagerState? {
        get {
            return cuckoo_manager.getter("currentState",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.currentState)
        }
        
    }
    
    public var currentSpeed: Float {
        get {
            return cuckoo_manager.getter("currentSpeed",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.currentSpeed)
        }
        
    }
    
    public var currentVoice: TTSVoice? {
        get {
            return cuckoo_manager.getter("currentVoice",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.currentVoice)
        }
        
    }
    
    public func setup() {
        
    return cuckoo_manager.call(
    """
    setup()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    public func play() {
        
    return cuckoo_manager.call(
    """
    play()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.play())
        
    }
    
    public func play(trackId: String, at utteranceId: String?) {
        
    return cuckoo_manager.call(
    """
    play(trackId: String, at: String?)
    """,
            parameters: (trackId, utteranceId),
            escapingParameters: (trackId, utteranceId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.play(trackId: trackId, at: utteranceId))
        
    }
    
    public func pause() {
        
    return cuckoo_manager.call(
    """
    pause()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.pause())
        
    }
    
    public func stop() {
        
    return cuckoo_manager.call(
    """
    stop()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.stop())
        
    }
    
    public func resume() {
        
    return cuckoo_manager.call(
    """
    resume()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.resume())
        
    }
    
    public func playNextTrack() {
        
    return cuckoo_manager.call(
    """
    playNextTrack()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playNextTrack())
        
    }
    
    public func playPreviousTrack() {
        
    return cuckoo_manager.call(
    """
    playPreviousTrack()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playPreviousTrack())
        
    }
    
    public func setSpeed(speed: Float) {
        
    return cuckoo_manager.call(
    """
    setSpeed(speed: Float)
    """,
            parameters: (speed),
            escapingParameters: (speed),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setSpeed(speed: speed))
        
    }
    
    public func setVoice(_ voice: TTSVoice) {
        
    return cuckoo_manager.call(
    """
    setVoice(_: TTSVoice)
    """,
            parameters: (voice),
            escapingParameters: (voice),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setVoice(voice))
        
    }
    
    public func hasNextTrack() -> Bool {
        
    return cuckoo_manager.call(
    """
    hasNextTrack() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.hasNextTrack())
        
    }
    
    public func hasPreviousTrack() -> Bool {
        
    return cuckoo_manager.call(
    """
    hasPreviousTrack() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.hasPreviousTrack())
        
    }
    
    public func reset() {
        
    return cuckoo_manager.call(
    """
    reset()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.reset())
        
    }

    public struct __StubbingProxy_TTSManagerProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var config: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockTTSManagerProtocol, TTSManagerConfig> {
            return .init(manager: cuckoo_manager, name: "config")
        }
        
        var onTTSManagerStateObserver: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockTTSManagerProtocol, ((TTSManagerState) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onTTSManagerStateObserver")
        }
        
        var onPlaylistObserver: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockTTSManagerProtocol, ((PlaylistObserver) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onPlaylistObserver")
        }
        
        var availableVoices: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTTSManagerProtocol, [TTSVoice]> {
            return .init(manager: cuckoo_manager, name: "availableVoices")
        }
        
        var currentState: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTTSManagerProtocol, TTSManagerState?> {
            return .init(manager: cuckoo_manager, name: "currentState")
        }
        
        var currentSpeed: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTTSManagerProtocol, Float> {
            return .init(manager: cuckoo_manager, name: "currentSpeed")
        }
        
        var currentVoice: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTTSManagerProtocol, TTSVoice?> {
            return .init(manager: cuckoo_manager, name: "currentVoice")
        }
        
        func setup() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    setup()
    """, parameterMatchers: matchers))
        }
        
        func play() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    play()
    """, parameterMatchers: matchers))
        }
        
        func play<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(trackId: M1, at utteranceId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String?)> where M1.MatchedType == String, M2.OptionalMatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String?)>] = [wrap(matchable: trackId) { $0.0 }, wrap(matchable: utteranceId) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    play(trackId: String, at: String?)
    """, parameterMatchers: matchers))
        }
        
        func pause() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    pause()
    """, parameterMatchers: matchers))
        }
        
        func stop() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    stop()
    """, parameterMatchers: matchers))
        }
        
        func resume() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    resume()
    """, parameterMatchers: matchers))
        }
        
        func playNextTrack() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    playNextTrack()
    """, parameterMatchers: matchers))
        }
        
        func playPreviousTrack() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    playPreviousTrack()
    """, parameterMatchers: matchers))
        }
        
        func setSpeed<M1: Cuckoo.Matchable>(speed: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Float)> where M1.MatchedType == Float {
            let matchers: [Cuckoo.ParameterMatcher<(Float)>] = [wrap(matchable: speed) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    setSpeed(speed: Float)
    """, parameterMatchers: matchers))
        }
        
        func setVoice<M1: Cuckoo.Matchable>(_ voice: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(TTSVoice)> where M1.MatchedType == TTSVoice {
            let matchers: [Cuckoo.ParameterMatcher<(TTSVoice)>] = [wrap(matchable: voice) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    setVoice(_: TTSVoice)
    """, parameterMatchers: matchers))
        }
        
        func hasNextTrack() -> Cuckoo.ProtocolStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    hasNextTrack() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func hasPreviousTrack() -> Cuckoo.ProtocolStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    hasPreviousTrack() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func reset() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManagerProtocol.self, method:
    """
    reset()
    """, parameterMatchers: matchers))
        }
        
    }

    public struct __VerificationProxy_TTSManagerProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        var config: Cuckoo.VerifyOptionalProperty<TTSManagerConfig> {
            return .init(manager: cuckoo_manager, name: "config", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var onTTSManagerStateObserver: Cuckoo.VerifyOptionalProperty<((TTSManagerState) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onTTSManagerStateObserver", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var onPlaylistObserver: Cuckoo.VerifyOptionalProperty<((PlaylistObserver) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onPlaylistObserver", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var availableVoices: Cuckoo.VerifyReadOnlyProperty<[TTSVoice]> {
            return .init(manager: cuckoo_manager, name: "availableVoices", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentState: Cuckoo.VerifyReadOnlyProperty<TTSManagerState?> {
            return .init(manager: cuckoo_manager, name: "currentState", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentSpeed: Cuckoo.VerifyReadOnlyProperty<Float> {
            return .init(manager: cuckoo_manager, name: "currentSpeed", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentVoice: Cuckoo.VerifyReadOnlyProperty<TTSVoice?> {
            return .init(manager: cuckoo_manager, name: "currentVoice", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func setup() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    setup()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func play() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    play()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func play<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(trackId: M1, at utteranceId: M2) -> Cuckoo.__DoNotUse<(String, String?), Void> where M1.MatchedType == String, M2.OptionalMatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String?)>] = [wrap(matchable: trackId) { $0.0 }, wrap(matchable: utteranceId) { $0.1 }]
            return cuckoo_manager.verify(
    """
    play(trackId: String, at: String?)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func pause() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    pause()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func stop() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    stop()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func resume() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    resume()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func playNextTrack() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    playNextTrack()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func playPreviousTrack() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    playPreviousTrack()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func setSpeed<M1: Cuckoo.Matchable>(speed: M1) -> Cuckoo.__DoNotUse<(Float), Void> where M1.MatchedType == Float {
            let matchers: [Cuckoo.ParameterMatcher<(Float)>] = [wrap(matchable: speed) { $0 }]
            return cuckoo_manager.verify(
    """
    setSpeed(speed: Float)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func setVoice<M1: Cuckoo.Matchable>(_ voice: M1) -> Cuckoo.__DoNotUse<(TTSVoice), Void> where M1.MatchedType == TTSVoice {
            let matchers: [Cuckoo.ParameterMatcher<(TTSVoice)>] = [wrap(matchable: voice) { $0 }]
            return cuckoo_manager.verify(
    """
    setVoice(_: TTSVoice)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func hasNextTrack() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    hasNextTrack() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func hasPreviousTrack() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    hasPreviousTrack() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func reset() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    reset()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }
}

public class TTSManagerProtocolStub: TTSManagerProtocol {
    
    public var config: TTSManagerConfig? {
        get {
            return DefaultValueRegistry.defaultValue(for: (TTSManagerConfig?).self)
        }
        
        set { }
        
    }
    
    public var onTTSManagerStateObserver: ((TTSManagerState) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((TTSManagerState) -> Void)?).self)
        }
        
        set { }
        
    }
    
    public var onPlaylistObserver: ((PlaylistObserver) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((PlaylistObserver) -> Void)?).self)
        }
        
        set { }
        
    }
    
    public var availableVoices: [TTSVoice] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([TTSVoice]).self)
        }
        
    }
    
    public var currentState: TTSManagerState? {
        get {
            return DefaultValueRegistry.defaultValue(for: (TTSManagerState?).self)
        }
        
    }
    
    public var currentSpeed: Float {
        get {
            return DefaultValueRegistry.defaultValue(for: (Float).self)
        }
        
    }
    
    public var currentVoice: TTSVoice? {
        get {
            return DefaultValueRegistry.defaultValue(for: (TTSVoice?).self)
        }
        
    }
    
    public func setup() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func play() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func play(trackId: String, at utteranceId: String?) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func pause() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func stop() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func resume() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func playNextTrack() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func playPreviousTrack() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func setSpeed(speed: Float) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func setVoice(_ voice: TTSVoice) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func hasNextTrack() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    public func hasPreviousTrack() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    public func reset() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

public class MockTTSManager: TTSManager, Cuckoo.ClassMock {
    
    public typealias MocksType = TTSManager
    
    public typealias Stubbing = __StubbingProxy_TTSManager
    public typealias Verification = __VerificationProxy_TTSManager

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)
    
    private var __defaultImplStub: TTSManager?

    public func enableDefaultImplementation(_ stub: TTSManager) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
    public override var ttsEngine: TTSEngineProtocol {
        get {
            return cuckoo_manager.getter("ttsEngine",
                superclassCall:
                    
                    super.ttsEngine
                    ,
                defaultCall: __defaultImplStub!.ttsEngine)
        }
        
        set {
            cuckoo_manager.setter("ttsEngine",
                value: newValue,
                superclassCall:
                    
                    super.ttsEngine = newValue
                    ,
                defaultCall: __defaultImplStub!.ttsEngine = newValue)
        }
        
    }
    
    public override var onTTSManagerStateObserver: ((TTSManagerState) -> Void)? {
        get {
            return cuckoo_manager.getter("onTTSManagerStateObserver",
                superclassCall:
                    
                    super.onTTSManagerStateObserver
                    ,
                defaultCall: __defaultImplStub!.onTTSManagerStateObserver)
        }
        
        set {
            cuckoo_manager.setter("onTTSManagerStateObserver",
                value: newValue,
                superclassCall:
                    
                    super.onTTSManagerStateObserver = newValue
                    ,
                defaultCall: __defaultImplStub!.onTTSManagerStateObserver = newValue)
        }
        
    }
    
    public override var onPlaylistObserver: ((PlaylistObserver) -> Void)? {
        get {
            return cuckoo_manager.getter("onPlaylistObserver",
                superclassCall:
                    
                    super.onPlaylistObserver
                    ,
                defaultCall: __defaultImplStub!.onPlaylistObserver)
        }
        
        set {
            cuckoo_manager.setter("onPlaylistObserver",
                value: newValue,
                superclassCall:
                    
                    super.onPlaylistObserver = newValue
                    ,
                defaultCall: __defaultImplStub!.onPlaylistObserver = newValue)
        }
        
    }
    
    public override var currentTrackIndex: Int? {
        get {
            return cuckoo_manager.getter("currentTrackIndex",
                superclassCall:
                    
                    super.currentTrackIndex
                    ,
                defaultCall: __defaultImplStub!.currentTrackIndex)
        }
        
    }
    
    public override var currentUtteranceIndex: Int? {
        get {
            return cuckoo_manager.getter("currentUtteranceIndex",
                superclassCall:
                    
                    super.currentUtteranceIndex
                    ,
                defaultCall: __defaultImplStub!.currentUtteranceIndex)
        }
        
    }
    
    public override var startingTrackId: String? {
        get {
            return cuckoo_manager.getter("startingTrackId",
                superclassCall:
                    
                    super.startingTrackId
                    ,
                defaultCall: __defaultImplStub!.startingTrackId)
        }
        
        set {
            cuckoo_manager.setter("startingTrackId",
                value: newValue,
                superclassCall:
                    
                    super.startingTrackId = newValue
                    ,
                defaultCall: __defaultImplStub!.startingTrackId = newValue)
        }
        
    }
    
    public override var startingUtteranceId: String? {
        get {
            return cuckoo_manager.getter("startingUtteranceId",
                superclassCall:
                    
                    super.startingUtteranceId
                    ,
                defaultCall: __defaultImplStub!.startingUtteranceId)
        }
        
        set {
            cuckoo_manager.setter("startingUtteranceId",
                value: newValue,
                superclassCall:
                    
                    super.startingUtteranceId = newValue
                    ,
                defaultCall: __defaultImplStub!.startingUtteranceId = newValue)
        }
        
    }
    
    public override var config: TTSManagerConfig? {
        get {
            return cuckoo_manager.getter("config",
                superclassCall:
                    
                    super.config
                    ,
                defaultCall: __defaultImplStub!.config)
        }
        
        set {
            cuckoo_manager.setter("config",
                value: newValue,
                superclassCall:
                    
                    super.config = newValue
                    ,
                defaultCall: __defaultImplStub!.config = newValue)
        }
        
    }
    
    public override var currentPlayingState: TTSManagerPlayingState? {
        get {
            return cuckoo_manager.getter("currentPlayingState",
                superclassCall:
                    
                    super.currentPlayingState
                    ,
                defaultCall: __defaultImplStub!.currentPlayingState)
        }
        
        set {
            cuckoo_manager.setter("currentPlayingState",
                value: newValue,
                superclassCall:
                    
                    super.currentPlayingState = newValue
                    ,
                defaultCall: __defaultImplStub!.currentPlayingState = newValue)
        }
        
    }
    
    public override var currentUtterance: Utterance? {
        get {
            return cuckoo_manager.getter("currentUtterance",
                superclassCall:
                    
                    super.currentUtterance
                    ,
                defaultCall: __defaultImplStub!.currentUtterance)
        }
        
        set {
            cuckoo_manager.setter("currentUtterance",
                value: newValue,
                superclassCall:
                    
                    super.currentUtterance = newValue
                    ,
                defaultCall: __defaultImplStub!.currentUtterance = newValue)
        }
        
    }
    
    public override var currentTrack: Track? {
        get {
            return cuckoo_manager.getter("currentTrack",
                superclassCall:
                    
                    super.currentTrack
                    ,
                defaultCall: __defaultImplStub!.currentTrack)
        }
        
        set {
            cuckoo_manager.setter("currentTrack",
                value: newValue,
                superclassCall:
                    
                    super.currentTrack = newValue
                    ,
                defaultCall: __defaultImplStub!.currentTrack = newValue)
        }
        
    }
    
    public override var currentPlaylist: Playlist? {
        get {
            return cuckoo_manager.getter("currentPlaylist",
                superclassCall:
                    
                    super.currentPlaylist
                    ,
                defaultCall: __defaultImplStub!.currentPlaylist)
        }
        
        set {
            cuckoo_manager.setter("currentPlaylist",
                value: newValue,
                superclassCall:
                    
                    super.currentPlaylist = newValue
                    ,
                defaultCall: __defaultImplStub!.currentPlaylist = newValue)
        }
        
    }
    
    public override var availableVoices: [TTSVoice] {
        get {
            return cuckoo_manager.getter("availableVoices",
                superclassCall:
                    
                    super.availableVoices
                    ,
                defaultCall: __defaultImplStub!.availableVoices)
        }
        
        set {
            cuckoo_manager.setter("availableVoices",
                value: newValue,
                superclassCall:
                    
                    super.availableVoices = newValue
                    ,
                defaultCall: __defaultImplStub!.availableVoices = newValue)
        }
        
    }
    
    public override var currentState: TTSManagerState? {
        get {
            return cuckoo_manager.getter("currentState",
                superclassCall:
                    
                    super.currentState
                    ,
                defaultCall: __defaultImplStub!.currentState)
        }
        
        set {
            cuckoo_manager.setter("currentState",
                value: newValue,
                superclassCall:
                    
                    super.currentState = newValue
                    ,
                defaultCall: __defaultImplStub!.currentState = newValue)
        }
        
    }
    
    public override var currentSpeed: Float {
        get {
            return cuckoo_manager.getter("currentSpeed",
                superclassCall:
                    
                    super.currentSpeed
                    ,
                defaultCall: __defaultImplStub!.currentSpeed)
        }
        
    }
    
    public override var currentVoice: TTSVoice? {
        get {
            return cuckoo_manager.getter("currentVoice",
                superclassCall:
                    
                    super.currentVoice
                    ,
                defaultCall: __defaultImplStub!.currentVoice)
        }
        
    }
    
    public override func setup() {
        
    return cuckoo_manager.call(
    """
    setup()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.setup()
                ,
            defaultCall: __defaultImplStub!.setup())
        
    }
    
    public override func handleTTSEngineStateChanged(state: TTSEngineState) {
        
    return cuckoo_manager.call(
    """
    handleTTSEngineStateChanged(state: TTSEngineState)
    """,
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                super.handleTTSEngineStateChanged(state: state)
                ,
            defaultCall: __defaultImplStub!.handleTTSEngineStateChanged(state: state))
        
    }
    
    public override func handleTTSEngineProgress(progress: NSRange) {
        
    return cuckoo_manager.call(
    """
    handleTTSEngineProgress(progress: NSRange)
    """,
            parameters: (progress),
            escapingParameters: (progress),
            superclassCall:
                
                super.handleTTSEngineProgress(progress: progress)
                ,
            defaultCall: __defaultImplStub!.handleTTSEngineProgress(progress: progress))
        
    }
    
    public override func bindToTTSEngine() {
        
    return cuckoo_manager.call(
    """
    bindToTTSEngine()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.bindToTTSEngine()
                ,
            defaultCall: __defaultImplStub!.bindToTTSEngine())
        
    }
    
    public override func play(trackId: String, at utteranceId: String?) {
        
    return cuckoo_manager.call(
    """
    play(trackId: String, at: String?)
    """,
            parameters: (trackId, utteranceId),
            escapingParameters: (trackId, utteranceId),
            superclassCall:
                
                super.play(trackId: trackId, at: utteranceId)
                ,
            defaultCall: __defaultImplStub!.play(trackId: trackId, at: utteranceId))
        
    }
    
    public override func play() {
        
    return cuckoo_manager.call(
    """
    play()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.play()
                ,
            defaultCall: __defaultImplStub!.play())
        
    }
    
    public override func reset() {
        
    return cuckoo_manager.call(
    """
    reset()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.reset()
                ,
            defaultCall: __defaultImplStub!.reset())
        
    }
    
    public override func pause() {
        
    return cuckoo_manager.call(
    """
    pause()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.pause()
                ,
            defaultCall: __defaultImplStub!.pause())
        
    }
    
    public override func stop() {
        
    return cuckoo_manager.call(
    """
    stop()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.stop()
                ,
            defaultCall: __defaultImplStub!.stop())
        
    }
    
    public override func resume() {
        
    return cuckoo_manager.call(
    """
    resume()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.resume()
                ,
            defaultCall: __defaultImplStub!.resume())
        
    }
    
    public override func handlePauseReading() -> Bool {
        
    return cuckoo_manager.call(
    """
    handlePauseReading() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.handlePauseReading()
                ,
            defaultCall: __defaultImplStub!.handlePauseReading())
        
    }
    
    public override func handleStopReading() -> Bool {
        
    return cuckoo_manager.call(
    """
    handleStopReading() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.handleStopReading()
                ,
            defaultCall: __defaultImplStub!.handleStopReading())
        
    }
    
    public override func handleResumeReading() -> Bool {
        
    return cuckoo_manager.call(
    """
    handleResumeReading() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.handleResumeReading()
                ,
            defaultCall: __defaultImplStub!.handleResumeReading())
        
    }
    
    public override func playUtteranceList(_ list: [Utterance]) {
        
    return cuckoo_manager.call(
    """
    playUtteranceList(_: [Utterance])
    """,
            parameters: (list),
            escapingParameters: (list),
            superclassCall:
                
                super.playUtteranceList(list)
                ,
            defaultCall: __defaultImplStub!.playUtteranceList(list))
        
    }
    
    public override func playNextUtterance() {
        
    return cuckoo_manager.call(
    """
    playNextUtterance()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.playNextUtterance()
                ,
            defaultCall: __defaultImplStub!.playNextUtterance())
        
    }
    
    public override func playNextTrack() {
        
    return cuckoo_manager.call(
    """
    playNextTrack()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.playNextTrack()
                ,
            defaultCall: __defaultImplStub!.playNextTrack())
        
    }
    
    public override func playPreviousTrack() {
        
    return cuckoo_manager.call(
    """
    playPreviousTrack()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.playPreviousTrack()
                ,
            defaultCall: __defaultImplStub!.playPreviousTrack())
        
    }
    
    public override func handleFailurePlaying() {
        
    return cuckoo_manager.call(
    """
    handleFailurePlaying()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.handleFailurePlaying()
                ,
            defaultCall: __defaultImplStub!.handleFailurePlaying())
        
    }
    
    public override func hasNextTrack() -> Bool {
        
    return cuckoo_manager.call(
    """
    hasNextTrack() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.hasNextTrack()
                ,
            defaultCall: __defaultImplStub!.hasNextTrack())
        
    }
    
    public override func hasPreviousTrack() -> Bool {
        
    return cuckoo_manager.call(
    """
    hasPreviousTrack() -> Bool
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.hasPreviousTrack()
                ,
            defaultCall: __defaultImplStub!.hasPreviousTrack())
        
    }
    
    public override func setSpeed(speed: Float) {
        
    return cuckoo_manager.call(
    """
    setSpeed(speed: Float)
    """,
            parameters: (speed),
            escapingParameters: (speed),
            superclassCall:
                
                super.setSpeed(speed: speed)
                ,
            defaultCall: __defaultImplStub!.setSpeed(speed: speed))
        
    }
    
    public override func setVoice(_ voice: TTSVoice) {
        
    return cuckoo_manager.call(
    """
    setVoice(_: TTSVoice)
    """,
            parameters: (voice),
            escapingParameters: (voice),
            superclassCall:
                
                super.setVoice(voice)
                ,
            defaultCall: __defaultImplStub!.setVoice(voice))
        
    }
    
    public override func clearInfoCenter() {
        
    return cuckoo_manager.call(
    """
    clearInfoCenter()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.clearInfoCenter()
                ,
            defaultCall: __defaultImplStub!.clearInfoCenter())
        
    }
    
    public override func updateInfoCenterIfNeeded() {
        
    return cuckoo_manager.call(
    """
    updateInfoCenterIfNeeded()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.updateInfoCenterIfNeeded()
                ,
            defaultCall: __defaultImplStub!.updateInfoCenterIfNeeded())
        
    }
    
    public override func unregisterMediaControls() {
        
    return cuckoo_manager.call(
    """
    unregisterMediaControls()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.unregisterMediaControls()
                ,
            defaultCall: __defaultImplStub!.unregisterMediaControls())
        
    }
    
    public override func registerMediaControls() {
        
    return cuckoo_manager.call(
    """
    registerMediaControls()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.registerMediaControls()
                ,
            defaultCall: __defaultImplStub!.registerMediaControls())
        
    }

    public struct __StubbingProxy_TTSManager: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var ttsEngine: Cuckoo.ClassToBeStubbedProperty<MockTTSManager, TTSEngineProtocol> {
            return .init(manager: cuckoo_manager, name: "ttsEngine")
        }
        
        var onTTSManagerStateObserver: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSManager, ((TTSManagerState) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onTTSManagerStateObserver")
        }
        
        var onPlaylistObserver: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSManager, ((PlaylistObserver) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onPlaylistObserver")
        }
        
        var currentTrackIndex: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockTTSManager, Int?> {
            return .init(manager: cuckoo_manager, name: "currentTrackIndex")
        }
        
        var currentUtteranceIndex: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockTTSManager, Int?> {
            return .init(manager: cuckoo_manager, name: "currentUtteranceIndex")
        }
        
        var startingTrackId: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSManager, String> {
            return .init(manager: cuckoo_manager, name: "startingTrackId")
        }
        
        var startingUtteranceId: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSManager, String> {
            return .init(manager: cuckoo_manager, name: "startingUtteranceId")
        }
        
        var config: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSManager, TTSManagerConfig> {
            return .init(manager: cuckoo_manager, name: "config")
        }
        
        var currentPlayingState: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSManager, TTSManagerPlayingState> {
            return .init(manager: cuckoo_manager, name: "currentPlayingState")
        }
        
        var currentUtterance: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSManager, Utterance> {
            return .init(manager: cuckoo_manager, name: "currentUtterance")
        }
        
        var currentTrack: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSManager, Track> {
            return .init(manager: cuckoo_manager, name: "currentTrack")
        }
        
        var currentPlaylist: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSManager, Playlist> {
            return .init(manager: cuckoo_manager, name: "currentPlaylist")
        }
        
        var availableVoices: Cuckoo.ClassToBeStubbedProperty<MockTTSManager, [TTSVoice]> {
            return .init(manager: cuckoo_manager, name: "availableVoices")
        }
        
        var currentState: Cuckoo.ClassToBeStubbedOptionalProperty<MockTTSManager, TTSManagerState> {
            return .init(manager: cuckoo_manager, name: "currentState")
        }
        
        var currentSpeed: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockTTSManager, Float> {
            return .init(manager: cuckoo_manager, name: "currentSpeed")
        }
        
        var currentVoice: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockTTSManager, TTSVoice?> {
            return .init(manager: cuckoo_manager, name: "currentVoice")
        }
        
        func setup() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    setup()
    """, parameterMatchers: matchers))
        }
        
        func handleTTSEngineStateChanged<M1: Cuckoo.Matchable>(state: M1) -> Cuckoo.ClassStubNoReturnFunction<(TTSEngineState)> where M1.MatchedType == TTSEngineState {
            let matchers: [Cuckoo.ParameterMatcher<(TTSEngineState)>] = [wrap(matchable: state) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    handleTTSEngineStateChanged(state: TTSEngineState)
    """, parameterMatchers: matchers))
        }
        
        func handleTTSEngineProgress<M1: Cuckoo.Matchable>(progress: M1) -> Cuckoo.ClassStubNoReturnFunction<(NSRange)> where M1.MatchedType == NSRange {
            let matchers: [Cuckoo.ParameterMatcher<(NSRange)>] = [wrap(matchable: progress) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    handleTTSEngineProgress(progress: NSRange)
    """, parameterMatchers: matchers))
        }
        
        func bindToTTSEngine() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    bindToTTSEngine()
    """, parameterMatchers: matchers))
        }
        
        func play<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(trackId: M1, at utteranceId: M2) -> Cuckoo.ClassStubNoReturnFunction<(String, String?)> where M1.MatchedType == String, M2.OptionalMatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String?)>] = [wrap(matchable: trackId) { $0.0 }, wrap(matchable: utteranceId) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    play(trackId: String, at: String?)
    """, parameterMatchers: matchers))
        }
        
        func play() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    play()
    """, parameterMatchers: matchers))
        }
        
        func reset() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    reset()
    """, parameterMatchers: matchers))
        }
        
        func pause() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    pause()
    """, parameterMatchers: matchers))
        }
        
        func stop() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    stop()
    """, parameterMatchers: matchers))
        }
        
        func resume() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    resume()
    """, parameterMatchers: matchers))
        }
        
        func handlePauseReading() -> Cuckoo.ClassStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    handlePauseReading() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func handleStopReading() -> Cuckoo.ClassStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    handleStopReading() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func handleResumeReading() -> Cuckoo.ClassStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    handleResumeReading() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func playUtteranceList<M1: Cuckoo.Matchable>(_ list: M1) -> Cuckoo.ClassStubNoReturnFunction<([Utterance])> where M1.MatchedType == [Utterance] {
            let matchers: [Cuckoo.ParameterMatcher<([Utterance])>] = [wrap(matchable: list) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    playUtteranceList(_: [Utterance])
    """, parameterMatchers: matchers))
        }
        
        func playNextUtterance() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    playNextUtterance()
    """, parameterMatchers: matchers))
        }
        
        func playNextTrack() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    playNextTrack()
    """, parameterMatchers: matchers))
        }
        
        func playPreviousTrack() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    playPreviousTrack()
    """, parameterMatchers: matchers))
        }
        
        func handleFailurePlaying() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    handleFailurePlaying()
    """, parameterMatchers: matchers))
        }
        
        func hasNextTrack() -> Cuckoo.ClassStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    hasNextTrack() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func hasPreviousTrack() -> Cuckoo.ClassStubFunction<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    hasPreviousTrack() -> Bool
    """, parameterMatchers: matchers))
        }
        
        func setSpeed<M1: Cuckoo.Matchable>(speed: M1) -> Cuckoo.ClassStubNoReturnFunction<(Float)> where M1.MatchedType == Float {
            let matchers: [Cuckoo.ParameterMatcher<(Float)>] = [wrap(matchable: speed) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    setSpeed(speed: Float)
    """, parameterMatchers: matchers))
        }
        
        func setVoice<M1: Cuckoo.Matchable>(_ voice: M1) -> Cuckoo.ClassStubNoReturnFunction<(TTSVoice)> where M1.MatchedType == TTSVoice {
            let matchers: [Cuckoo.ParameterMatcher<(TTSVoice)>] = [wrap(matchable: voice) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    setVoice(_: TTSVoice)
    """, parameterMatchers: matchers))
        }
        
        func clearInfoCenter() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    clearInfoCenter()
    """, parameterMatchers: matchers))
        }
        
        func updateInfoCenterIfNeeded() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    updateInfoCenterIfNeeded()
    """, parameterMatchers: matchers))
        }
        
        func unregisterMediaControls() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    unregisterMediaControls()
    """, parameterMatchers: matchers))
        }
        
        func registerMediaControls() -> Cuckoo.ClassStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockTTSManager.self, method:
    """
    registerMediaControls()
    """, parameterMatchers: matchers))
        }
        
    }

    public struct __VerificationProxy_TTSManager: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        var ttsEngine: Cuckoo.VerifyProperty<TTSEngineProtocol> {
            return .init(manager: cuckoo_manager, name: "ttsEngine", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var onTTSManagerStateObserver: Cuckoo.VerifyOptionalProperty<((TTSManagerState) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onTTSManagerStateObserver", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var onPlaylistObserver: Cuckoo.VerifyOptionalProperty<((PlaylistObserver) -> Void)> {
            return .init(manager: cuckoo_manager, name: "onPlaylistObserver", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentTrackIndex: Cuckoo.VerifyReadOnlyProperty<Int?> {
            return .init(manager: cuckoo_manager, name: "currentTrackIndex", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentUtteranceIndex: Cuckoo.VerifyReadOnlyProperty<Int?> {
            return .init(manager: cuckoo_manager, name: "currentUtteranceIndex", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var startingTrackId: Cuckoo.VerifyOptionalProperty<String> {
            return .init(manager: cuckoo_manager, name: "startingTrackId", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var startingUtteranceId: Cuckoo.VerifyOptionalProperty<String> {
            return .init(manager: cuckoo_manager, name: "startingUtteranceId", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var config: Cuckoo.VerifyOptionalProperty<TTSManagerConfig> {
            return .init(manager: cuckoo_manager, name: "config", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentPlayingState: Cuckoo.VerifyOptionalProperty<TTSManagerPlayingState> {
            return .init(manager: cuckoo_manager, name: "currentPlayingState", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentUtterance: Cuckoo.VerifyOptionalProperty<Utterance> {
            return .init(manager: cuckoo_manager, name: "currentUtterance", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentTrack: Cuckoo.VerifyOptionalProperty<Track> {
            return .init(manager: cuckoo_manager, name: "currentTrack", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentPlaylist: Cuckoo.VerifyOptionalProperty<Playlist> {
            return .init(manager: cuckoo_manager, name: "currentPlaylist", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var availableVoices: Cuckoo.VerifyProperty<[TTSVoice]> {
            return .init(manager: cuckoo_manager, name: "availableVoices", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentState: Cuckoo.VerifyOptionalProperty<TTSManagerState> {
            return .init(manager: cuckoo_manager, name: "currentState", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentSpeed: Cuckoo.VerifyReadOnlyProperty<Float> {
            return .init(manager: cuckoo_manager, name: "currentSpeed", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var currentVoice: Cuckoo.VerifyReadOnlyProperty<TTSVoice?> {
            return .init(manager: cuckoo_manager, name: "currentVoice", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func setup() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    setup()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func handleTTSEngineStateChanged<M1: Cuckoo.Matchable>(state: M1) -> Cuckoo.__DoNotUse<(TTSEngineState), Void> where M1.MatchedType == TTSEngineState {
            let matchers: [Cuckoo.ParameterMatcher<(TTSEngineState)>] = [wrap(matchable: state) { $0 }]
            return cuckoo_manager.verify(
    """
    handleTTSEngineStateChanged(state: TTSEngineState)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func handleTTSEngineProgress<M1: Cuckoo.Matchable>(progress: M1) -> Cuckoo.__DoNotUse<(NSRange), Void> where M1.MatchedType == NSRange {
            let matchers: [Cuckoo.ParameterMatcher<(NSRange)>] = [wrap(matchable: progress) { $0 }]
            return cuckoo_manager.verify(
    """
    handleTTSEngineProgress(progress: NSRange)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func bindToTTSEngine() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    bindToTTSEngine()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func play<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(trackId: M1, at utteranceId: M2) -> Cuckoo.__DoNotUse<(String, String?), Void> where M1.MatchedType == String, M2.OptionalMatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String, String?)>] = [wrap(matchable: trackId) { $0.0 }, wrap(matchable: utteranceId) { $0.1 }]
            return cuckoo_manager.verify(
    """
    play(trackId: String, at: String?)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func play() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    play()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func reset() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    reset()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func pause() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    pause()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func stop() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    stop()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func resume() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    resume()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func handlePauseReading() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    handlePauseReading() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func handleStopReading() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    handleStopReading() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func handleResumeReading() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    handleResumeReading() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func playUtteranceList<M1: Cuckoo.Matchable>(_ list: M1) -> Cuckoo.__DoNotUse<([Utterance]), Void> where M1.MatchedType == [Utterance] {
            let matchers: [Cuckoo.ParameterMatcher<([Utterance])>] = [wrap(matchable: list) { $0 }]
            return cuckoo_manager.verify(
    """
    playUtteranceList(_: [Utterance])
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func playNextUtterance() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    playNextUtterance()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func playNextTrack() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    playNextTrack()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func playPreviousTrack() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    playPreviousTrack()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func handleFailurePlaying() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    handleFailurePlaying()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func hasNextTrack() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    hasNextTrack() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func hasPreviousTrack() -> Cuckoo.__DoNotUse<(), Bool> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    hasPreviousTrack() -> Bool
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func setSpeed<M1: Cuckoo.Matchable>(speed: M1) -> Cuckoo.__DoNotUse<(Float), Void> where M1.MatchedType == Float {
            let matchers: [Cuckoo.ParameterMatcher<(Float)>] = [wrap(matchable: speed) { $0 }]
            return cuckoo_manager.verify(
    """
    setSpeed(speed: Float)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func setVoice<M1: Cuckoo.Matchable>(_ voice: M1) -> Cuckoo.__DoNotUse<(TTSVoice), Void> where M1.MatchedType == TTSVoice {
            let matchers: [Cuckoo.ParameterMatcher<(TTSVoice)>] = [wrap(matchable: voice) { $0 }]
            return cuckoo_manager.verify(
    """
    setVoice(_: TTSVoice)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func clearInfoCenter() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    clearInfoCenter()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func updateInfoCenterIfNeeded() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    updateInfoCenterIfNeeded()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func unregisterMediaControls() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    unregisterMediaControls()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func registerMediaControls() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    registerMediaControls()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }
}

public class TTSManagerStub: TTSManager {
    
    public override var ttsEngine: TTSEngineProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (TTSEngineProtocol).self)
        }
        
        set { }
        
    }
    
    public override var onTTSManagerStateObserver: ((TTSManagerState) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((TTSManagerState) -> Void)?).self)
        }
        
        set { }
        
    }
    
    public override var onPlaylistObserver: ((PlaylistObserver) -> Void)? {
        get {
            return DefaultValueRegistry.defaultValue(for: (((PlaylistObserver) -> Void)?).self)
        }
        
        set { }
        
    }
    
    public override var currentTrackIndex: Int? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int?).self)
        }
        
    }
    
    public override var currentUtteranceIndex: Int? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int?).self)
        }
        
    }
    
    public override var startingTrackId: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
        set { }
        
    }
    
    public override var startingUtteranceId: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
        set { }
        
    }
    
    public override var config: TTSManagerConfig? {
        get {
            return DefaultValueRegistry.defaultValue(for: (TTSManagerConfig?).self)
        }
        
        set { }
        
    }
    
    public override var currentPlayingState: TTSManagerPlayingState? {
        get {
            return DefaultValueRegistry.defaultValue(for: (TTSManagerPlayingState?).self)
        }
        
        set { }
        
    }
    
    public override var currentUtterance: Utterance? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Utterance?).self)
        }
        
        set { }
        
    }
    
    public override var currentTrack: Track? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Track?).self)
        }
        
        set { }
        
    }
    
    public override var currentPlaylist: Playlist? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Playlist?).self)
        }
        
        set { }
        
    }
    
    public override var availableVoices: [TTSVoice] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([TTSVoice]).self)
        }
        
        set { }
        
    }
    
    public override var currentState: TTSManagerState? {
        get {
            return DefaultValueRegistry.defaultValue(for: (TTSManagerState?).self)
        }
        
        set { }
        
    }
    
    public override var currentSpeed: Float {
        get {
            return DefaultValueRegistry.defaultValue(for: (Float).self)
        }
        
    }
    
    public override var currentVoice: TTSVoice? {
        get {
            return DefaultValueRegistry.defaultValue(for: (TTSVoice?).self)
        }
        
    }
    
    public override func setup() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func handleTTSEngineStateChanged(state: TTSEngineState) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func handleTTSEngineProgress(progress: NSRange) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func bindToTTSEngine() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func play(trackId: String, at utteranceId: String?) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func play() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func reset() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func pause() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func stop() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func resume() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func handlePauseReading() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    public override func handleStopReading() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    public override func handleResumeReading() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    public override func playUtteranceList(_ list: [Utterance]) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func playNextUtterance() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func playNextTrack() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func playPreviousTrack() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func handleFailurePlaying() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func hasNextTrack() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    public override func hasPreviousTrack() -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    public override func setSpeed(speed: Float) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func setVoice(_ voice: TTSVoice) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func clearInfoCenter() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func updateInfoCenterIfNeeded() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func unregisterMediaControls() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override func registerMediaControls() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

