//
//  DecrementerTests.swift
//  KeyCheat
//
//  Created by hatebyte on 2/20/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import UIKit
import XCTest

class DecrementerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDecrementInit() {
        let decrementer = Decrementer(top: 100, decreaser: 1) {
        }
        
        XCTAssert(decrementer.top == 100, "The decrementer top should be 100")
        XCTAssert(decrementer.val == 100, "The decrementer top should be 100")
        XCTAssert(decrementer.decreaser == 1, "The decrementer top should be 1")
    }

    func testDecrementUpdate() {
        let decrementer = Decrementer(top: 100, decreaser: 1) {
        }
        
        decrementer.update()
        
        XCTAssert(decrementer.val == 99, "The decrementer top should be 99")
    }

    
    func testDecrementCompletion() {
        var isFinished = false
        let decrementer = Decrementer(top: 100, decreaser: 1) {
            isFinished = true
        }
        for _ in 0...100 {
            decrementer.update()
        }
        
        XCTAssert(isFinished, "The decrementer should have called the finised block")
    }

}
