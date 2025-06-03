//
//  TTSManagerTests.swift
//  BooksTests
//
//  Created by Maor Karo on 19/01/2021.
//  Copyright © 2021 Chegg Inc. All rights reserved.
//

import XCTest
import Cuckoo
@testable import Utilities

class TTSManagerTests: XCTestCase {
    var manager: TTSManager!
    var mockedManager: MockTTSManager!
    var cuckooTTSEngine: MockTTSEngineProtocol!
    
    override func setUp() {
        manager = TTSManager()
        mockedManager = MockTTSManager()
        
        cuckooTTSEngine = MockTTSEngineProtocol()
        
        mockedManager.enableDefaultImplementation(manager)
        stub(mockedManager) { (stub) in
            when(stub.ttsEngine.get).thenReturn(cuckooTTSEngine)
        }
    }
    
    // MARK: - Test Getters
    
    func test_currentTrackIndex_nil_without_playlist() {
        stub(mockedManager) { (stub) in
            when(stub.currentTrackIndex.get).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(nil)
            when(stub.currentTrack.get).thenReturn(Track.mock())
        }
        
        XCTAssertNil(mockedManager.currentTrackIndex)
    }
    
    func test_currentTrackIndex_nil_without_currentTrack() {
        stub(mockedManager) { (stub) in
            when(stub.currentTrackIndex.get).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(Playlist.mock())
            when(stub.currentTrack.get).thenReturn(nil)
        }
        
        XCTAssertNil(mockedManager.currentTrackIndex)
    }
    
    func test_currentTrackIndex_getter() {
        let mockedTrack = Track.mock()
        let mockedPlaylist = Playlist.mock(tracks: [mockedTrack, Track.mock(), Track.mock()])
        stub(mockedManager) { (stub) in
            when(stub.currentTrackIndex.get).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(mockedPlaylist)
            when(stub.currentTrack.get).thenReturn(mockedTrack)
        }
        XCTAssertEqual(mockedManager.currentTrackIndex!, 0)
    }
    
    // MARK: - Test currentUtteranceIndex
    
    func test_currentUtteranceIndex_nil_without_currentUtterance() {
        stub(mockedManager) { (stub) in
            when(stub.currentUtteranceIndex.get).thenCallRealImplementation()
            when(stub.currentUtterance.get).thenReturn(nil)
            when(stub.currentTrack.get).thenReturn(Track.mock())
        }
        XCTAssertNil(mockedManager.currentUtteranceIndex)
    }
    
    func test_currentUtteranceIndex_nil_without_currentTrack() {
        stub(mockedManager) { (stub) in
            when(stub.currentUtteranceIndex.get).thenCallRealImplementation()
            when(stub.currentUtterance.get).thenReturn(Utterance.mock())
            when(stub.currentTrack.get).thenReturn(nil)
        }
        XCTAssertNil(mockedManager.currentUtteranceIndex)
    }
    
    func test_currentUtteranceIndex_getter() {
        let mockedUtterance = Utterance.mock(utteranceId: "test")
        let mockedTrack = Track.mock(utterances: [Utterance.mock(), Utterance.mock(), mockedUtterance])
        stub(mockedManager) { (stub) in
            when(stub.currentUtteranceIndex.get).thenCallRealImplementation()
            when(stub.currentUtterance.get).thenReturn(mockedUtterance)
            when(stub.currentTrack.get).thenReturn(mockedTrack)
        }
        XCTAssertEqual(mockedManager.currentUtteranceIndex!, 2)
    }
    
    // MARK: - Test Config Setter
    
    func test_config_setter_without_background_support() {
        stub(mockedManager) { (stub) in
            when(stub.config.set(any())).thenCallRealImplementation()
            when(stub.reset()).thenDoNothing()
            when(stub.currentPlaylist.set(any())).thenDoNothing()
        }
        
        let mockedPlaylist = Playlist.mock()
        mockedManager.config = TTSManagerConfig(supportBackgroundControls: false,
                                                playlist: mockedPlaylist)
        
        verify(mockedManager).reset()
        verify(mockedManager, never()).registerMediaControls()
        verify(mockedManager).currentPlaylist.set(equal(to: mockedPlaylist))
    }
    
    func test_config_setter_with_backgrdoun_support() {
        stub(mockedManager) { (stub) in
            when(stub.config.set(any())).thenCallRealImplementation()
            when(stub.reset()).thenDoNothing()
            when(stub.currentPlaylist.set(any())).thenDoNothing()
            when(stub.registerMediaControls()).thenDoNothing()
        }

        let mockedPlaylist = Playlist.mock()
        mockedManager.config = TTSManagerConfig(supportBackgroundControls: true,
                                                playlist: mockedPlaylist)

        verify(mockedManager).reset()
        verify(mockedManager).registerMediaControls()
        verify(mockedManager).currentPlaylist.set(equal(to: mockedPlaylist))
    }

    // MARK: - Test currentPlayingState Setter

    func test_currentPlayingState_setter_bailOut_without_currentPlayingState() {
        let mockedVoice = TTSVoice(name: "test", language: "voice")
        stub(mockedManager) { (stub) in
            when(stub.currentPlayingState.set(any())).thenCallRealImplementation()
            when(stub.currentVoice.get).thenReturn(mockedVoice)
        }

        mockedManager.currentPlayingState = nil

        verify(mockedManager, never()).currentState.set(any())
    }

    func test_currentPlayingState_setter_bailOut_without_currentVoice() {
        stub(mockedManager) { (stub) in
            when(stub.currentPlayingState.set(any())).thenCallRealImplementation()
            when(stub.currentVoice.get).thenReturn(nil)
        }

        mockedManager.currentPlayingState = .playing

        verify(mockedManager, never()).currentState.set(any())
    }

    func test_currentPlayingState_setter() {
        let mockedVoice = TTSVoice(name: "test", language: "voice")
        stub(mockedManager) { (stub) in
            when(stub.currentPlayingState.set(any())).thenCallRealImplementation()
            when(stub.currentVoice.get).thenReturn(mockedVoice)
            when(stub.currentSpeed.get).thenReturn(0.5)
        }

        mockedManager.currentPlayingState = .playing

        let mockedState = TTSManagerState(currentVoice: mockedVoice,
                                          currentSpeed: 0.5,
                                          playingState: .playing)

        verify(mockedManager).currentState.set(equal(to: mockedState))
    }

    // MARK: - Test setup()

    func test_setup() {
        stub(mockedManager) { (stub) in
            when(stub.setup()).thenCallRealImplementation()
            when(stub.bindToTTSEngine()).thenDoNothing()
        }

        stub(cuckooTTSEngine) { (stub) in
            when(stub.setup()).thenDoNothing()
        }

        mockedManager.setup()

        verify(mockedManager).bindToTTSEngine()
        verify(cuckooTTSEngine).setup()
    }

    // MARK: - Test handleTTSEngineStateChanged()

    func test_handleTTSEngineStateChanged_play_state() {
        stub(mockedManager) { (stub) in
            when(stub.handleTTSEngineStateChanged(state: any())).thenCallRealImplementation()
            when(stub.currentPlayingState.set(any())).thenDoNothing()
        }

        mockedManager.handleTTSEngineStateChanged(state: .play)

        verify(mockedManager).currentPlayingState.set(equal(to: .playing))
        verify(mockedManager).startingTrackId.set(equal(to: nil))
        verify(mockedManager).startingUtteranceId.set(equal(to: nil))
        verify(mockedManager, never()).playNextUtterance()
    }

    func test_handleTTSEngineStateChanged_pause_state() {
        stub(mockedManager) { (stub) in
            when(stub.handleTTSEngineStateChanged(state: any())).thenCallRealImplementation()
            when(stub.currentPlayingState.set(any())).thenDoNothing()
        }

        mockedManager.handleTTSEngineStateChanged(state: .pause)

        verify(mockedManager).currentPlayingState.set(equal(to: .pause))
        verify(mockedManager, never()).startingTrackId.set(any())
        verify(mockedManager, never()).startingUtteranceId.set(any())
        verify(mockedManager, never()).playNextUtterance()
    }

    func test_handleTTSEngineStateChanged_stop_state() {
        stub(mockedManager) { (stub) in
            when(stub.handleTTSEngineStateChanged(state: any())).thenCallRealImplementation()
            when(stub.currentPlayingState.set(any())).thenDoNothing()
        }

        mockedManager.handleTTSEngineStateChanged(state: .stop)

        verify(mockedManager).currentPlayingState.set(equal(to: .stop))
        verify(mockedManager, never()).startingTrackId.set(any())
        verify(mockedManager, never()).startingUtteranceId.set(any())
        verify(mockedManager, never()).playNextUtterance()
    }

    func test_handleTTSEngineStateChanged_finish_state() {
        stub(mockedManager) { (stub) in
            when(stub.handleTTSEngineStateChanged(state: any())).thenCallRealImplementation()
            when(stub.currentPlayingState.set(any())).thenDoNothing()
        }

        mockedManager.handleTTSEngineStateChanged(state: .finish)

        verify(mockedManager, never()).currentPlayingState.set(any())
        verify(mockedManager, never()).startingTrackId.set(any())
        verify(mockedManager, never()).startingUtteranceId.set(any())
        verify(mockedManager).playNextUtterance()
    }

    func test_handleTTSEngineStateChanged_error_state() {
        stub(mockedManager) { (stub) in
            when(stub.handleTTSEngineStateChanged(state: any())).thenCallRealImplementation()
            when(stub.currentPlayingState.set(any())).thenDoNothing()
        }

        let mockedError = NSError(domain: "1", code: 1, userInfo: nil)
        mockedManager.handleTTSEngineStateChanged(state: .error(error: mockedError))

        verify(mockedManager).currentPlayingState.set(equal(to: .error(mockedError)))
        verify(mockedManager, never()).startingTrackId.set(any())
        verify(mockedManager, never()).startingUtteranceId.set(any())
        verify(mockedManager, never()).playNextUtterance()
    }

    // MARK: - Test handleTTSEngineProgress

    func test_handleTTSEngineProgress_bailOut_without_currentPlaylist() {
        stub(mockedManager) { (stub) in
            when(stub.currentPlaylist.get).thenReturn(nil)
            when(stub.currentTrack.get).thenReturn(Track.mock())
            when(stub.currentUtterance.get).thenReturn(Utterance.mock())
        }
        base_test_handleTTSEngineProgress_bailOut()
    }

    func test_handleTTSEngineProgress_bailOut_without_currentTrack() {
        stub(mockedManager) { (stub) in
            when(stub.currentPlaylist.get).thenReturn(Playlist.mock())
            when(stub.currentTrack.get).thenReturn(nil)
            when(stub.currentUtterance.get).thenReturn(Utterance.mock())
        }
        base_test_handleTTSEngineProgress_bailOut()
    }

    func test_handleTTSEngineProgress_bailOut_without_currentUtterance() {
        stub(mockedManager) { (stub) in
            when(stub.currentPlaylist.get).thenReturn(Playlist.mock())
            when(stub.currentTrack.get).thenReturn(Track.mock())
            when(stub.currentUtterance.get).thenReturn(nil)
        }
        base_test_handleTTSEngineProgress_bailOut()
    }

    func base_test_handleTTSEngineProgress_bailOut() {
        stub(mockedManager) { (stub) in
            when(stub.handleTTSEngineProgress(progress: any())).thenCallRealImplementation()
        }

        mockedManager.handleTTSEngineProgress(progress: NSRange.init(location: 0, length: 100))

        verify(mockedManager, never()).onPlaylistObserver.get()
        verify(mockedManager, never()).onPlaylistObserver.set(any())
    }

    func test_handleTTSEngineProgress() {
        let mockedPlaylistId = "dummyPlaylistId"
        let mockedTrackId = "dummyTrackId"
        let mockedUtteranceId = "dummyUtteranceId"
        stub(mockedManager) { (stub) in
            when(stub.handleTTSEngineProgress(progress: any())).thenCallRealImplementation()
            when(stub.onPlaylistObserver.get).thenCallRealImplementation()
            when(stub.onPlaylistObserver.set(any())).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(Playlist.mock(playlistId: mockedPlaylistId))
            when(stub.currentTrack.get).thenReturn(Track.mock(trackId: mockedTrackId))
            when(stub.currentUtterance.get).thenReturn(Utterance.mock(utteranceId: mockedUtteranceId))
        }

        let mockedRange = NSRange(location: 0, length: 10)
        let expectedPlaylistObserver = PlaylistObserver(playlistId: mockedPlaylistId,
                                                        trackId: mockedTrackId,
                                                        utteranceId: mockedUtteranceId,
                                                        utteranceProgress: mockedRange)

        let closureCalledExpectation = expectation(description: "Observer closure should have been called")
        mockedManager.onPlaylistObserver = { playlistObserver in
            guard expectedPlaylistObserver == playlistObserver else {
                XCTFail()
                return
            }
            closureCalledExpectation.fulfill()
        }

        mockedManager.handleTTSEngineProgress(progress: mockedRange)

        wait(for: [closureCalledExpectation],
             timeout: 0.5)
    }

    // MARK: - Test currentUtterance Setter

    func test_currentUtterance_setter_bailOut() {
        stub(mockedManager) { (stub) in
            when(stub.currentUtterance.set(any())).thenCallRealImplementation()
        }

        mockedManager.currentUtterance = nil

        verify(cuckooTTSEngine, never()).play(text: any())
    }

    func test_currentUtterance_setter() {
        stub(mockedManager) { (stub) in
            when(stub.currentUtterance.set(any())).thenCallRealImplementation()
        }

        stub(cuckooTTSEngine) { (stub) in
            when(stub.play(text: any())).thenDoNothing()
        }

        let mockedText = "testUtteranceText"
        mockedManager.currentUtterance = Utterance.mock(utteranceText: mockedText)

        verify(cuckooTTSEngine).play(text: equal(to: mockedText))
    }

    // MARK: - Test currentTrack Setter

    func test_currentTrack_setter_bailOut() {
        stub(mockedManager) { (stub) in
            when(stub.currentTrack.set(any())).thenCallRealImplementation()
        }

        mockedManager.currentTrack = nil

        verify(mockedManager, never()).playUtteranceList(any())
        verify(mockedManager, never()).playNextTrack()
        verify(mockedManager, never()).updateInfoCenterIfNeeded()
    }

    func test_currentTrack_setter_with_utterances() {
        stub(mockedManager) { (stub) in
            when(stub.currentTrack.set(any())).thenCallRealImplementation()
            when(stub.playUtteranceList(any())).thenDoNothing()
        }

        let mockedTrack = Track.mock()
        mockedManager.currentTrack = mockedTrack

        verify(mockedManager).playUtteranceList(any())
        verify(mockedManager).updateInfoCenterIfNeeded()
        verify(mockedManager, never()).playNextTrack()
    }

    func test_currentTrack_setter_without_utterances() {
        stub(mockedManager) { (stub) in
            when(stub.currentTrack.set(any())).thenCallRealImplementation()
        }

        let mockedTrack = Track.mock(utterances: [])
        mockedManager.currentTrack = mockedTrack

        verify(mockedManager).playNextTrack()
        verify(mockedManager).updateInfoCenterIfNeeded()
        verify(mockedManager, never()).playUtteranceList(any())
    }

    // MARK: - Test currentState setter

    func test_currentState_setter_bailOut_when_nil() {
        stub(mockedManager) { (stub) in
            when(stub.currentState.set(any())).thenDoNothing()
        }

        mockedManager.currentState = nil

        verify(mockedManager, never()).onTTSManagerStateObserver.get()
        verify(mockedManager, never()).onTTSManagerStateObserver.set(any())
    }

    func test_currentState_setter() {

        stub(mockedManager) { (stub) in
            when(stub.currentState.set(any())).thenCallRealImplementation()
            when(stub.onTTSManagerStateObserver.get).thenCallRealImplementation()
            when(stub.onTTSManagerStateObserver.set(any())).thenCallRealImplementation()
        }

        let mockedState = TTSManagerState(currentVoice: TTSVoice(name: "test", language: "voice"),
                                          currentSpeed: 0.5,
                                          playingState: .playing)

        let closureCalledExpectation = expectation(description: "Observer closure should have been called")
        mockedManager.onTTSManagerStateObserver = { state in
            guard mockedState == state else {
                XCTFail()
                return
            }
            closureCalledExpectation.fulfill()
        }

        mockedManager.currentState = mockedState

        wait(for: [closureCalledExpectation],
             timeout: 0.5)
    }

    // MARK: - Test currentSpeed getter

    func test_currentSpeed_getter() {
        stub(mockedManager) { (stub) in
            when(stub.currentSpeed.get).thenCallRealImplementation()
        }

        stub(cuckooTTSEngine) { (stub) in
            when(stub.readingRate.get).thenReturn(0.5)
        }

        XCTAssertEqual(mockedManager.currentSpeed, 0.5)
        verify(cuckooTTSEngine).readingRate.get()
    }

    // MARK: - Test play with trackId & UtteranceId

    func test_play_with_trackId_utteranceId() {
        stub(mockedManager) { (stub) in
            when(stub.play(trackId: any(), at: any())).thenCallRealImplementation()
            when(stub.startingTrackId.set(any())).thenDoNothing()
            when(stub.startingUtteranceId.set(any())).thenDoNothing()
            when(stub.currentTrack.set(any())).thenDoNothing()
            when(stub.currentUtterance.set(any())).thenDoNothing()
            when(stub.play()).thenDoNothing()
        }

        let mockedTrackId = "mockedTrackId"
        let mockedUtteranceId = "mockedUtteranceId"
        mockedManager.play(trackId: mockedTrackId, at: mockedUtteranceId)

        verify(mockedManager).play()
        verify(mockedManager).startingTrackId.set(equal(to: mockedTrackId))
        verify(mockedManager).startingUtteranceId.set(equal(to: mockedUtteranceId))
        verify(mockedManager).currentTrack.set(equal(to: nil))
        verify(mockedManager).currentUtterance.set(equal(to: nil))
    }

    // MARK: - Test play

    func test_play_bailOut_without_playlist() {
        stub(mockedManager) { (stub) in
            when(stub.play()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(nil)
            when(stub.handleFailurePlaying()).thenDoNothing()
        }

        mockedManager.play()

        verify(mockedManager).handleFailurePlaying()
        verify(mockedManager, never()).currentTrack.get()
        verify(mockedManager, never()).currentTrack.set(any())
    }

    func test_play_bailOut_without_tracks_in_playlist() {
        let mockedPlaylist = Playlist.mock(tracks: [])
        stub(mockedManager) { (stub) in
            when(stub.play()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(mockedPlaylist)
            when(stub.handleFailurePlaying()).thenDoNothing()
        }

        mockedManager.play()

        verify(mockedManager).handleFailurePlaying()
        verify(mockedManager, never()).currentTrack.get()
        verify(mockedManager, never()).currentTrack.set(any())
    }

    func test_play_when_current_track_exists() {
        let mockedPlaylist = Playlist.mock()
        let mockedTrack = Track.mock()
        stub(mockedManager) { (stub) in
            when(stub.play()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(mockedPlaylist)
            when(stub.handleFailurePlaying()).thenDoNothing()
            when(stub.currentTrack.get).thenReturn(mockedTrack)
            when(stub.currentTrack.set(any())).thenDoNothing()
        }

        mockedManager.play()

        verify(mockedManager, never()).handleFailurePlaying()
        verify(mockedManager).currentTrack.get()
        verify(mockedManager).currentTrack.set(equal(to: mockedTrack))
    }
    
    func test_play_when_current_track_not_exists() {
        let mockedTrack = Track.mock()
        let mockedPlaylist = Playlist.mock(tracks: [mockedTrack, Track.mock(), Track.mock()])
        stub(mockedManager) { (stub) in
            when(stub.play()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(mockedPlaylist)
            when(stub.handleFailurePlaying()).thenDoNothing()
            when(stub.currentTrack.get).thenReturn(nil)
            when(stub.currentTrack.set(any())).thenDoNothing()
        }

        mockedManager.play()

        verify(mockedManager, never()).handleFailurePlaying()
        verify(mockedManager).currentTrack.get()
        verify(mockedManager).currentTrack.set(equal(to: mockedTrack))
    }
    
    // MARK: - Test reset()

    func test_reset() {
        stub(mockedManager) { (stub) in
            when(stub.reset()).thenCallRealImplementation()
            when(stub.currentPlaylist.set(any())).thenDoNothing()
            when(stub.currentTrack.set(any())).thenDoNothing()
            when(stub.currentUtterance.set(any())).thenDoNothing()
            when(stub.startingTrackId.set(any())).thenDoNothing()
            when(stub.startingUtteranceId.set(any())).thenDoNothing()
            when(stub.clearInfoCenter()).thenDoNothing()
            when(stub.unregisterMediaControls()).thenDoNothing()
            when(stub.stop()).thenDoNothing()
        }

        mockedManager.reset()
        verify(mockedManager).currentPlaylist.set(equal(to: nil))
        verify(mockedManager).currentTrack.set(equal(to: nil))
        verify(mockedManager).currentUtterance.set(equal(to: nil))
        verify(mockedManager).startingTrackId.set(equal(to: nil))
        verify(mockedManager).startingUtteranceId.set(equal(to: nil))
        verify(mockedManager).clearInfoCenter()
        verify(mockedManager).unregisterMediaControls()
        verify(mockedManager).stop()
    }
    
    // MARK: - Test pause()
    
    func test_pause() {
        stub(mockedManager) { (stub) in
            when(stub.pause()).thenCallRealImplementation()
            when(stub.handlePauseReading()).thenReturn(true)
        }

        mockedManager.pause()

        verify(mockedManager).handlePauseReading()
    }

    func test_handlePauseReading() {
        stub(mockedManager) { (stub) in
            when(stub.handlePauseReading()).thenCallRealImplementation()
        }

        stub(cuckooTTSEngine) { (stub) in
            when(stub.pause()).thenReturn(true)
        }

        XCTAssertTrue(mockedManager.handlePauseReading())

        verify(cuckooTTSEngine).pause()
    }

    // MARK: - Test stop()

    func test_stop() {
        stub(mockedManager) { (stub) in
            when(stub.stop()).thenCallRealImplementation()
            when(stub.handleStopReading()).thenReturn(true)
        }

        mockedManager.stop()

        verify(mockedManager).handleStopReading()
    }

    func test_handleStopReading() {
        stub(mockedManager) { (stub) in
            when(stub.handleStopReading()).thenCallRealImplementation()
        }

        stub(cuckooTTSEngine) { (stub) in
            when(stub.stop()).thenReturn(true)
        }

        XCTAssertTrue(mockedManager.handleStopReading())

        verify(cuckooTTSEngine).stop()
    }
    
    // MARK: - Test resume()
    
    func test_resume() {
        stub(mockedManager) { (stub) in
            when(stub.resume()).thenCallRealImplementation()
            when(stub.handleResumeReading()).thenReturn(true)
        }
        
        mockedManager.resume()

        verify(mockedManager).handleResumeReading()
    }

    func test_handleResumeReading() {
        stub(mockedManager) { (stub) in
            when(stub.handleResumeReading()).thenCallRealImplementation()
            when(stub.currentTrack.get).thenReturn(Track.mock())
        }

        stub(cuckooTTSEngine) { (stub) in
            when(stub.resume()).thenReturn(true)
        }

        XCTAssertTrue(mockedManager.handleResumeReading())

        verify(cuckooTTSEngine).resume()
        verify(mockedManager, never()).currentTrack.set(any())
    }
    
    func test_handleResumeReading_with_currentTrack() {
        let mockedTrack = Track.mock()
        stub(mockedManager) { (stub) in
            when(stub.handleResumeReading()).thenCallRealImplementation()
            when(stub.currentTrack.get).thenReturn(mockedTrack)
            when(stub.currentTrack.set(any())).thenDoNothing()
        }

        stub(cuckooTTSEngine) { (stub) in
            when(stub.resume()).thenReturn(false)
        }

        XCTAssertTrue(mockedManager.handleResumeReading())

        verify(cuckooTTSEngine).resume()
        verify(mockedManager).currentTrack.set(equal(to: mockedTrack))
    }
    
    func test_handleResumeReading_without_currentTrack() {
        stub(mockedManager) { (stub) in
            when(stub.handleResumeReading()).thenCallRealImplementation()
            when(stub.currentTrack.get).thenReturn(nil)
        }

        stub(cuckooTTSEngine) { (stub) in
            when(stub.resume()).thenReturn(false)
        }

        XCTAssertFalse(mockedManager.handleResumeReading())

        verify(cuckooTTSEngine).resume()
        verify(mockedManager, never()).currentTrack.set(any())
    }
    
    // MARK: - Test playUtteranceList
    
    func test_playUtteranceList_bailOut() {
        stub(mockedManager) { (stub) in
            when(stub.playUtteranceList(any())).thenCallRealImplementation()
            when(stub.handleFailurePlaying()).thenDoNothing()
        }
        
        mockedManager.playUtteranceList([])
        
        verify(mockedManager).handleFailurePlaying()
        verify(mockedManager, never()).currentUtterance.set(any())
    }
    
    func test_playUtteranceList_with_startingUtteranceId() {
        let mockedId = "mockUtteranceId"
        stub(mockedManager) { (stub) in
            when(stub.playUtteranceList(any())).thenCallRealImplementation()
            when(stub.startingUtteranceId.get).thenReturn(mockedId)
            when(stub.currentUtterance.set(any())).thenDoNothing()
        }
        
        let mockedUtterance = Utterance.mock(utteranceId: mockedId)
        mockedManager.playUtteranceList([Utterance.mock(), Utterance.mock(), mockedUtterance])
        
        verify(mockedManager).currentUtterance.set(equal(to: mockedUtterance))
        verify(mockedManager, never()).handleFailurePlaying()
    }
    
    func test_playUtteranceList_without_startingUtteranceId() {
        stub(mockedManager) { (stub) in
            when(stub.playUtteranceList(any())).thenCallRealImplementation()
            when(stub.startingUtteranceId.get).thenReturn(nil)
            when(stub.currentUtterance.set(any())).thenDoNothing()
        }
        
        let mockedUtterance = Utterance.mock()
        mockedManager.playUtteranceList([mockedUtterance, Utterance.mock(), Utterance.mock()])
        
        verify(mockedManager).currentUtterance.set(equal(to: mockedUtterance))
        verify(mockedManager, never()).handleFailurePlaying()
    }
    
    // MARK: - Test playNextUtterance
    
    func test_playNextUtterance_bailOut_without_currentTrack() {
        stub(mockedManager) { (stub) in
            when(stub.playNextUtterance()).thenCallRealImplementation()
            when(stub.currentTrack.get).thenReturn(nil)
            when(stub.currentUtteranceIndex.get).thenReturn(1)
            when(stub.handleFailurePlaying()).thenDoNothing()
        }
        
        mockedManager.playNextUtterance()
        
        verify(mockedManager).handleFailurePlaying()
        verify(mockedManager, never()).currentUtterance.set(any())
        verify(mockedManager, never()).playNextTrack()
    }
    
    func test_playNextUtterance_bailOut_without_currentUtteranceIndex() {
        stub(mockedManager) { (stub) in
            when(stub.playNextUtterance()).thenCallRealImplementation()
            when(stub.currentTrack.get).thenReturn(Track.mock())
            when(stub.currentUtteranceIndex.get).thenReturn(nil)
            when(stub.handleFailurePlaying()).thenDoNothing()
        }
        
        mockedManager.playNextUtterance()
        
        verify(mockedManager).handleFailurePlaying()
        verify(mockedManager, never()).currentUtterance.set(any())
        verify(mockedManager, never()).playNextTrack()
    }
    
    func test_playNextUtterance_when_there_are_more_utterances_left() {
        let mockUtterance = Utterance.mock(utteranceId: "testId", utteranceText: "testText")
        let mockedUtterances = [Utterance.mock(), Utterance.mock(), mockUtterance, Utterance.mock()]
        stub(mockedManager) { (stub) in
            when(stub.playNextUtterance()).thenCallRealImplementation()
            when(stub.currentTrack.get).thenReturn(Track.mock(utterances: mockedUtterances))
            when(stub.currentUtteranceIndex.get).thenReturn(1)
            when(stub.currentUtterance.set(any())).thenDoNothing()
        }
        
        mockedManager.playNextUtterance()
        
        verify(mockedManager, never()).handleFailurePlaying()
        verify(mockedManager, never()).playNextTrack()
        verify(mockedManager).currentUtterance.set(equal(to: mockUtterance))
    }
    
    func test_playNextUtterance_when_there_are_NO_more_utterances_left() {
        let mockUtterance = Utterance.mock(utteranceId: "testId", utteranceText: "testText")
        let mockedUtterances = [Utterance.mock(), Utterance.mock(), mockUtterance, Utterance.mock()]
        stub(mockedManager) { (stub) in
            when(stub.playNextUtterance()).thenCallRealImplementation()
            when(stub.currentTrack.get).thenReturn(Track.mock(utterances: mockedUtterances))
            when(stub.currentUtteranceIndex.get).thenReturn(3)
            when(stub.currentUtterance.set(any())).thenDoNothing()
        }
        
        mockedManager.playNextUtterance()
        
        verify(mockedManager, never()).handleFailurePlaying()
        verify(mockedManager, never()).currentUtterance.set(any())
        verify(mockedManager).playNextTrack()
    }
    
    // MARK: - Test PlayNextTrack
    
    func test_playNextTrack_bailOut_without_currentPlaylist() {
        stub(mockedManager) { (stub) in
            when(stub.playNextTrack()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(nil)
            when(stub.handleFailurePlaying()).thenDoNothing()
        }
        
        mockedManager.playNextTrack()
        
        verify(mockedManager, never()).currentTrack.set(any())
        verify(mockedManager, never()).stop()
        verify(mockedManager).handleFailurePlaying()
    }
    
    func test_playNextTrack_without_currentTrackIndex() {
        let mockedPlaylist = Playlist.mock()
        stub(mockedManager) { (stub) in
            when(stub.playNextTrack()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(mockedPlaylist)
            when(stub.currentTrackIndex.get).thenReturn(nil)
            when(stub.currentTrack.set(any())).thenDoNothing()
        }
        
        mockedManager.playNextTrack()
        
        verify(mockedManager).currentTrack.set(equal(to: mockedPlaylist.tracks.first!))
        verify(mockedManager, never()).handleFailurePlaying()
    }
    
    func test_playNextTrack_with_currentTrackIndex() {
        let mockTrack = Track.mock(trackId: "testTrackID")
        let mockedTracks = [Track.mock(), mockTrack, Track.mock(), Track.mock()]
        let mockedPlaylist = Playlist.mock(tracks: mockedTracks)
        
        stub(mockedManager) { (stub) in
            when(stub.playNextTrack()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(mockedPlaylist)
            when(stub.currentTrackIndex.get).thenReturn(0)
            when(stub.currentTrack.set(any())).thenDoNothing()
        }
        
        mockedManager.playNextTrack()
        
        verify(mockedManager).currentTrack.set(equal(to: mockTrack))
        verify(mockedManager, never()).handleFailurePlaying()
        verify(mockedManager, never()).stop()
    }
    
    func test_playNextTrack_triggers_stop() {
        stub(mockedManager) { (stub) in
            when(stub.playNextTrack()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(Playlist.mock(tracks: Track.mocks(numberOfItems: 5)))
            when(stub.currentTrackIndex.get).thenReturn(4)
            when(stub.stop()).thenDoNothing()
        }
        
        stub(cuckooTTSEngine) { (stub) in
            when(stub.currentState.get).thenReturn(.finish)
        }
        
        mockedManager.playNextTrack()
        
        verify(mockedManager, never()).currentTrack.set(any())
        verify(mockedManager, never()).handleFailurePlaying()
        verify(mockedManager).stop()
    }
    
    // MARK: - Test playPreviousTrack
    
    func test_playPreviousTrack_bailOut_without_playlist() {
        stub(mockedManager) { (stub) in
            when(stub.playPreviousTrack()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(nil)
            when(stub.currentTrackIndex.get).thenReturn(1)
            when(stub.handleFailurePlaying()).thenDoNothing()
        }
        
        mockedManager.playPreviousTrack()
        
        verify(mockedManager).handleFailurePlaying()
        verify(mockedManager, never()).currentTrack.set(any())
    }
    
    func test_playPreviousTrack_bailOut_without_currentTrackIndex() {
        stub(mockedManager) { (stub) in
            when(stub.playPreviousTrack()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(Playlist.mock())
            when(stub.currentTrackIndex.get).thenReturn(nil)
            when(stub.handleFailurePlaying()).thenDoNothing()
        }
        
        mockedManager.playPreviousTrack()
        
        verify(mockedManager).handleFailurePlaying()
        verify(mockedManager, never()).currentTrack.set(any())
    }
    
    func test_playPreviousTrack() {
        let mockTrack = Track.mock(trackId: "testTrackID")
        let mockedTracks = [Track.mock(), mockTrack, Track.mock(), Track.mock()]
        let mockedPlaylist = Playlist.mock(tracks: mockedTracks)
        
        stub(mockedManager) { (stub) in
            when(stub.playPreviousTrack()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(mockedPlaylist)
            when(stub.currentTrackIndex.get).thenReturn(2)
            when(stub.currentTrack.set(any())).thenDoNothing()
        }
        
        mockedManager.playPreviousTrack()
        
        verify(mockedManager, never()).handleFailurePlaying()
        verify(mockedManager).currentTrack.set(equal(to: mockTrack))
    }
    
    // MARK: - Test handleFailurePlaying
    
    func test_handleFailurePlaying() {
        stub(mockedManager) { (stub) in
            when(stub.handleFailurePlaying()).thenCallRealImplementation()
            when(stub.stop()).thenDoNothing()
        }
        
        mockedManager.handleFailurePlaying()
        
        verify(mockedManager).stop()
    }
    
    // MARK: - Test hasNextTrack
    
    func test_hasNextTrack() {
        stub(mockedManager) { (stub) in
            when(stub.hasNextTrack()).thenCallRealImplementation()
            when(stub.currentTrackIndex.get).thenReturn(1)
            when(stub.currentPlaylist.get).thenReturn(Playlist.mock())
        }
        
        XCTAssertTrue(mockedManager.hasNextTrack())
    }
    
    func test_hasNextTrack_when_there_are_no_more_tracks_left() {
        stub(mockedManager) { (stub) in
            when(stub.hasNextTrack()).thenCallRealImplementation()
            when(stub.currentTrackIndex.get).thenReturn(100)
            when(stub.currentPlaylist.get).thenReturn(Playlist.mock())
        }
        
        XCTAssertFalse(mockedManager.hasNextTrack())
    }
    
    func test_hasNextTrack_when_currentTrackIndex_not_exists() {
        stub(mockedManager) { (stub) in
            when(stub.hasNextTrack()).thenCallRealImplementation()
            when(stub.currentTrackIndex.get).thenReturn(nil)
            when(stub.currentPlaylist.get).thenReturn(Playlist.mock())
        }
        
        XCTAssertTrue(mockedManager.hasNextTrack())
    }
    
    func test_hasNextTrack_when_playlist_not_exists() {
        stub(mockedManager) { (stub) in
            when(stub.hasNextTrack()).thenCallRealImplementation()
            when(stub.currentTrackIndex.get).thenReturn(1)
            when(stub.currentPlaylist.get).thenReturn(nil)
        }
        
        XCTAssertFalse(mockedManager.hasNextTrack())
    }
    
    // MARK: - Test hasPreviousTrack
 
    func test_hasPreviousTrack_bailOut_without_playlist() {
        stub(mockedManager) { (stub) in
            when(stub.hasPreviousTrack()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(nil)
        }
        
        XCTAssertFalse(mockedManager.hasPreviousTrack())
    }
    
    func test_hasPreviousTrack_bailOut_when_no_tracks() {
        stub(mockedManager) { (stub) in
            when(stub.hasPreviousTrack()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(Playlist.mock(tracks: []))
        }
        
        XCTAssertFalse(mockedManager.hasPreviousTrack())
    }
    
    func test_hasPreviousTrack_true() {
        stub(mockedManager) { (stub) in
            when(stub.hasPreviousTrack()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(Playlist.mock())
            when(stub.currentTrackIndex.get).thenReturn(5)
        }
        
        XCTAssertTrue(mockedManager.hasPreviousTrack())
    }
    
    func test_hasPreviousTrack_false() {
        stub(mockedManager) { (stub) in
            when(stub.hasPreviousTrack()).thenCallRealImplementation()
            when(stub.currentPlaylist.get).thenReturn(Playlist.mock())
            when(stub.currentTrackIndex.get).thenReturn(0)
        }
        
        XCTAssertFalse(mockedManager.hasPreviousTrack())
    }
    
    // MARK: - Test setSpeed
    
    func test_setSpeed() {
        stub(mockedManager) { (stub) in
            when(stub.setSpeed(speed: any())).thenCallRealImplementation()
        }
        
        stub(cuckooTTSEngine) { (stub) in
            when(stub.readingRate.set(any())).thenDoNothing()
        }
        
        let readingSpeed: Float = 1.0
        mockedManager.setSpeed(speed: readingSpeed)
        verify(cuckooTTSEngine).readingRate.set(equal(to: readingSpeed))
    }
}

public extension Playlist {
    static func mock(playlistId: String = "testPlaylistId",
                     playlistName: String = "testPlaylistName",
                     tracks: [Track] = Track.mocks()) -> Playlist {
        return Playlist(playlistId: playlistId,
                        name: playlistName,
                        tracks: tracks)
    }
}

public extension Track {
    static func mock(trackId: String = String(Int.random(in: 0...100)),
                     trackName: String = "dummyTrackName",
                     utterances: [Utterance] = Utterance.mocks()) -> Track {
        return Track(trackId: trackId,
                     name: trackName,
                     utterances: utterances)
    }
    
    static func mocks(numberOfItems: Int = 10) -> [Track] {
        var tracksArray = [Track]()
        for item in 0..<numberOfItems {
            tracksArray.append(Track.mock(trackName: String(item),
                                          utterances: Utterance.mocks()))
        }
        return tracksArray
    }
}

public extension Utterance {
    static func mock(utteranceId: String = String(Int.random(in: 0...100)),
                     utteranceText: String = "dummyUtteranceText") -> Utterance {
        return Utterance(utteranceId: utteranceId,
                         text: utteranceText)
    }
    
    static func mocks(numberOfItems: Int = 10) -> [Utterance] {
        var utteranceArray = [Utterance]()
        for item in 0..<numberOfItems {
            utteranceArray.append(Utterance.mock(utteranceText: String(item)))
        }
        return utteranceArray
    }
}
