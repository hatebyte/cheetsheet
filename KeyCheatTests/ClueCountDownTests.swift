//
//  ClueCountDownTests.swift
//  KeyCheat
//
//  Created by hatebyte on 2/20/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import UIKit
import XCTest

class ClueCountDownTests: XCTestCase {

    var clue:Clue!
    var mockClueCoundownClock:MockClueCountdownClock!
    
    override func setUp() {
        super.setUp()
        clue = Clue(time: 15, data: "This is a clue", performanceIndex: 0)
        mockClueCoundownClock = MockClueCountdownClock(clue: clue)
    }
    
    override func tearDown() {
        mockClueCoundownClock.pause()
        mockClueCoundownClock = nil
        clue = nil
        super.tearDown()
    }

    func testClueCountdownReturnsRemainingTime() {
        mockClueCoundownClock.falseStart()
        XCTAssert(mockClueCoundownClock.remainingTime == 14, "The remaining time of clueCoundownClock should be 14")
    }
    
    func testClueCountdownReturnsRemainingTimeAfterUpdate() {
        mockClueCoundownClock.falseStart()
        mockClueCoundownClock.triggerUpdate()
        XCTAssert(mockClueCoundownClock.remainingTime == 13, "The remaining time of clueCoundownClock should be 13")
    }
   
    func testPauseStartHasValidTimer() {
        mockClueCoundownClock.start()
        
        XCTAssertTrue(mockClueCoundownClock.isTimerValid(), "The the timer of the coundownClock should be valid")
    }

    func testPauseInvalidatesTimer() {
        mockClueCoundownClock.start()
        mockClueCoundownClock.pause()
        
        XCTAssertFalse(mockClueCoundownClock.isTimerValid(), "The the timer of the coundownClock should be invalid")
    }
    
    func testResumeValidatesTimer() {
        mockClueCoundownClock.start()
        mockClueCoundownClock.pause()
        mockClueCoundownClock.resume()
        
        XCTAssertTrue(mockClueCoundownClock.isTimerValid(), "The the timer of the coundownClock should be valid")
    }
 
    func testUpdatorFires() {
        var updateVal = 0
        mockClueCoundownClock.updator = {
            updateVal += 1
        }

        mockClueCoundownClock.falseStart()
        for _ in 0...100 {
            mockClueCoundownClock.triggerUpdate()
        }
        println(updateVal)
        XCTAssert(updateVal == 15, "The updator function should have been called only 15 times")
 
    }

    func testFinishedFiresOnCompletion() {
        var finishedVal = 0
        mockClueCoundownClock.finisher = {
            finishedVal += 1
        }
        
        mockClueCoundownClock.falseStart()
        for _ in 0...100 {
            mockClueCoundownClock.triggerUpdate()
        }

        XCTAssert(finishedVal == 1, "The finisher function should have been called 1 time")
        
    }

}
