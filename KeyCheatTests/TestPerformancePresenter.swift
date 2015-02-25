//
//  TestPerformancePresenter.swift
//  KeyCheat
//
//  Created by hatebyte on 2/22/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import Foundation
import XCTest

class TestPerformancePresenter: XCTestCase {

    let performanceData = PerformanceData(clueIndex:3, clueData:"This is clue data", remainingClueTime:19, remainingPerformanceTime:533)
    let viewPresenter = PerformanceViewPresenter()
    
    override func setUp() {
        super.setUp()
        viewPresenter.performanceData = performanceData
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testClueIndex() {
        XCTAssert(viewPresenter.index == 3, "The performance view index should be 3")
    }

    func testClueData() {
        XCTAssert(viewPresenter.data == "This is clue data", "The performance view data should be 'This is clue data'")
    }

    func testRemainingClueTime() {
        XCTAssert(viewPresenter.remainingClueTime == "0:19", "The performance view remainingClueTime should be '0:19'")
    }

    func testRemainingTotalTime() {
        XCTAssert(viewPresenter.remainingPerformanceTime == "8:53", "The performance view remainingPerformanceTime should be '8:53'")
    }

}
