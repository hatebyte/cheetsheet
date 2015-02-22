//
//  TestClockFormatter.swift
//  KeyCheat
//
//  Created by hatebyte on 2/22/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import Foundation
import XCTest

class TestClockFormatter: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTenSecondsLeft() {
        let seconds = 10
        XCTAssert(ClockFormatter.format(seconds) == "0:10", "The format shoud match '0:10'")
    }
    
    func test30MinutesLeft() {
        let seconds = 180
        XCTAssert(ClockFormatter.format(seconds) == "3:00", "The format shoud match '3:00'")
    }

    func testEightmintuesFiftyThreeSecondsMinutesLeft() {
        let seconds = 533
        XCTAssert(ClockFormatter.format(seconds) == "8:53", "The format shoud match '8:53'")
    }

}
