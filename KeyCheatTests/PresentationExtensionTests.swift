//
//  PresentationExtensionTests.swift
//  KeyCheat
//
//  Created by hatebyte on 2/22/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import Foundation
import XCTest

class PresentationExtensionTests: XCTestCase {

    var presentation:Presentation!
    
    override func setUp() {
        super.setUp()
        
        var clues = [Clue]()
        for i in 0..<15 {
            let c = Clue(time:10, data: "Clue number \(i)", performanceIndex:i)
            clues += [c]
        }
        self.presentation = Presentation(clues: clues, isDraft: false)
        
    }
    
    override func tearDown() {
        self.presentation = nil
        super.tearDown()
    }

    func testPresentationTotalTimeGiveBackCorrectTime() {
        XCTAssert(self.presentation.totalTime() == 150, "The presentation total time should be 150")
    }
    
    func testPresentationTotalTimeLeftGiveBackCorrectTimeForFirstStep() {
        XCTAssert(self.presentation.totalTimeLeft(0) == 140, "The presentation total time should be 140")
    }
    
    func testPresentationTotalTimeLeftGiveBackCorrectTimeForLastStep() {
        XCTAssert(self.presentation.totalTimeLeft(self.presentation.clues.count-1) == 0, "The presentation last time should be 0")
    }
    
    func testPresentationTotalTimeLeftGiveBackCorrectTimeForStep() {
        XCTAssert(self.presentation.totalTimeLeft(5) == 90, "The presentation last time should be 90")
    }

    func testPresentationCluesdata() {
        let arr = self.presentation.cluesData()
        XCTAssert(arr[3] == "Clue number 3", "The arr index 2 should be 'Clue number 3'")
        XCTAssert(arr[5] == "Clue number 5", "The arr index 2 should be 'Clue number 5'")
        XCTAssert(arr[0] == "Clue number 0", "The arr index 2 should be 'Clue number 0'")
    }
}
