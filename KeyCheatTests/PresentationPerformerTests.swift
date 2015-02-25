//
//  PresentationPerformerTests.swift
//  KeyCheat
//
//  Created by hatebyte on 2/21/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import UIKit
import XCTest

class PresentationPerformerTests: XCTestCase {

    var presentationPerformer:MockPresentationPerformer!
    var fakeDelegate = FakePerfomanceDelegate()
    
    override func setUp() {
        super.setUp()
        
        var clues = [Clue]()
        for i in 0..<15 {
            let c = Clue(time:10, data: "Clue number \(i)", performanceIndex:i)
            clues += [c]
        }
        let presentation = Presentation(clues: clues, isDraft: false)
        self.presentationPerformer = MockPresentationPerformer(presentation: presentation)
        self.presentationPerformer.start()
        
        self.presentationPerformer.delegate = self.fakeDelegate
    }
    
    override func tearDown() {
        self.presentationPerformer = nil
        super.tearDown()
    }

    func testPresentationHasCorrectTotalTime() {
        XCTAssert(self.presentationPerformer.totalTime == 150, "The presentationPerformacne totalTime should be 150 secs")
    }
    
    func testPresentationStartIsClue0() {
        XCTAssert(self.presentationPerformer.currentClueIndex == 0, "The presentationPerformacne clueIndex should be 0")
        XCTAssert(self.presentationPerformer.currentClueCountdownClock.clue.data == "Clue number 0", "The presentationPerformacne currentClue be 'Clue number 0'")
    }
   
    func testPresentationDataStart() {
        let pvm = presentationPerformer.performanceData!
        XCTAssert(pvm.clueData == "Clue number 0", "The pvm clueData should be 'Clue number 0'")
        XCTAssert(pvm.clueIndex == 0, "The pvm clueIndex should be 0")
        XCTAssert(pvm.remainingClueTime == 9, "The pvm clueIndex should be 9")
        XCTAssert(pvm.remainingPerformanceTime == 149, "The pvm clueIndex should be 149")
    }

    func testPresentationDataAfterFirstTimerExecutes() {
        self.presentationPerformer.currentClueCountdownClock.triggerUpdate()
        
        let pvm = presentationPerformer.performanceData!
        XCTAssert(pvm.clueData == "Clue number 0", "The pvm clueData should be 'Clue number 0'")
        XCTAssert(pvm.clueIndex == 0, "The pvm clueIndex should be 0")
        XCTAssert(pvm.remainingClueTime == 8, "The pvm clueIndex should be 8")
        XCTAssert(pvm.remainingPerformanceTime == 148, "The pvm clueIndex should be 148")
    }
    
    func testPresentationDataAfterSecondTimerExecutes() {
        self.presentationPerformer.currentClueCountdownClock.triggerUpdate()
        self.presentationPerformer.currentClueCountdownClock.triggerUpdate()
        
        let pvm = presentationPerformer.performanceData!
        XCTAssert(pvm.clueData == "Clue number 0", "The pvm clueData should be 'Clue number 0'")
        XCTAssert(pvm.clueIndex == 0, "The pvm clueIndex should be 0")
        XCTAssert(pvm.remainingClueTime == 7, "The pvm clueIndex should be 7")
        XCTAssert(pvm.remainingPerformanceTime == 147, "The pvm clueIndex should be 147")
    }
   
    func testPresentationDataAfter9TimersExecute() {
        for _ in 0..<9 {
            self.presentationPerformer.currentClueCountdownClock.triggerUpdate()
        }
        
        let pvm = presentationPerformer.performanceData!
        XCTAssert(pvm.clueData == "Clue number 0", "The pvm clueData should be 'Clue number 0'")
        XCTAssert(pvm.clueIndex == 0, "The pvm clueIndex should be 0")
        XCTAssert(pvm.remainingClueTime == 0, "The pvm clueIndex should be 0")
        XCTAssert(pvm.remainingPerformanceTime == 140, "The pvm clueIndex should be 140")
    }
    
    func testPresentationDataAfterTenTimersExecute() {
        for _ in 0..<10 {
            self.presentationPerformer.currentClueCountdownClock.triggerUpdate()
        }
        
        let pvm = presentationPerformer.performanceData!
        XCTAssert(pvm.clueData == "Clue number 1", "The pvm clueData should be 'Clue number 1'")
        XCTAssert(pvm.clueIndex == 1, "The pvm clueIndex should be 0")
        XCTAssert(pvm.remainingClueTime == 9, "The pvm clueIndex should be 9")
        XCTAssert(pvm.remainingPerformanceTime == 139, "The pvm clueIndex should be 139")
    }
    
    func testPresentationDataAfterElevenTimersExecute() {
        for _ in 0..<11 {
            self.presentationPerformer.currentClueCountdownClock.triggerUpdate()
        }
        
        let pvm = presentationPerformer.performanceData!
        XCTAssert(pvm.clueData == "Clue number 1", "The pvm clueData should be 'Clue number 1'")
        XCTAssert(pvm.clueIndex == 1, "The pvm clueIndex should be 1")
        XCTAssert(pvm.remainingClueTime == 8, "The pvm clueIndex should be 8")
        XCTAssert(pvm.remainingPerformanceTime == 138, "The pvm clueIndex should be 138")
    }
    
    func testPresentationDataAfter149TimersExecute() {
        for _ in 0..<149 {
            self.presentationPerformer.currentClueCountdownClock.triggerUpdate()
        }
        
        let pvm = presentationPerformer.performanceData!
        XCTAssert(pvm.clueData == "Clue number 14", "The pvm clueData should be 'Clue number 14'")
        XCTAssert(pvm.clueIndex == 14, "The pvm clueIndex should be 1")
        XCTAssert(pvm.remainingClueTime == 0, "The pvm clueIndex should be 0")
        XCTAssert(pvm.remainingPerformanceTime == 0, "The pvm clueIndex should be 0")
    }

    func testPresentationDataAfter150TimersExecute() {
        for _ in 0..<150 {
            self.presentationPerformer.currentClueCountdownClock.triggerUpdate()
        }
        
        let pvm = presentationPerformer.performanceData!
        XCTAssert(pvm.clueData == "Clue number 14", "The pvm clueData should be 'Clue number 14'")
        XCTAssert(pvm.clueIndex == 14, "The pvm clueIndex should be 14")
        XCTAssert(pvm.remainingClueTime == -1, "The pvm clueIndex should be 0")
        XCTAssert(pvm.remainingPerformanceTime == -1, "The pvm clueIndex should be 0")
        println(pvm.remainingClueTime)
        println(pvm.remainingPerformanceTime)
        XCTAssert(fakeDelegate.isPresentationComplete, "The presentation should have fired its completed presentationCompleted")
    }
    
    func testPresentationDataAfterTooManyTimersExecute() {
        for _ in 0..<1000 {
            self.presentationPerformer.currentClueCountdownClock.triggerUpdate()
        }
        
        let pvm = presentationPerformer.performanceData!
        XCTAssert(pvm.clueData == "Clue number 14", "The pvm clueData should be 'Clue number 14'")
        XCTAssert(pvm.clueIndex == 14, "The pvm clueIndex should be 1")
        XCTAssert(pvm.remainingClueTime == -1, "The pvm clueIndex should be -1")
        XCTAssert(pvm.remainingPerformanceTime == -1, "The pvm clueIndex should be -1")
        println(pvm.remainingClueTime)
        println(pvm.remainingPerformanceTime)
        XCTAssert(fakeDelegate.isPresentationComplete, "The presentation should have fired its completed presentationCompleted")
    }
   
    func testPerformanceCanRequestStepToStartOn() {
        // start presentation
    
        for _ in 0..<3 {
            self.presentationPerformer.currentClueCountdownClock.triggerUpdate()
        }
        
        self.presentationPerformer.setCurrentClue(10)
        self.presentationPerformer.currentClueCountdownClock.triggerUpdate()
        let pvm = presentationPerformer.performanceData!
        
        XCTAssert(pvm.clueData == "Clue number 10", "The pvm clueData should be 'Clue number 10'")
        XCTAssert(pvm.clueIndex == 10, "The pvm clueIndex should be 10")
        XCTAssert(pvm.remainingClueTime == 8, "The pvm clueIndex should be 8")
        XCTAssert(pvm.remainingPerformanceTime == 48, "The pvm clueIndex should be 48")
        XCTAssert(fakeDelegate.newClueIndex == 10, "The presentation should be at clue 10")
    }


}








































