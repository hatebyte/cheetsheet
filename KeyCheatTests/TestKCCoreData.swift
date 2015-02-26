//
//  TestKCCoreData.swift
//  KeyCheat
//
//  Created by hatebyte on 2/26/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import UIKit
import XCTest

class TestKCCoreData: XCTestCase {

    var readContext             = MockKCCoreData.readContext()
    var tempWritingContext      = MockKCCoreData.temporaryWriteContext()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        tempWritingContext = nil
        readContext = nil
        super.tearDown()
    }

    func testClueCanBeSavedInDb() {
        let cManaged              = ClueModel.newObjectInContext(tempWritingContext)
        cManaged.uid              = 1
        cManaged.time             = 15
        cManaged.data             = "This is a clue"
        cManaged.performanceIndex = 2
        tempWritingContext.saveSynchronously()
        
        let clue                  = ClueModel.fetchFirstObjectInContext(readContext, sortedBy:nil, withPredicate:NSPredicate(format: "uid == \(1)"))
        
        println(clue)
        XCTAssert(clue.uid == 1, "The clue.uid fetched from the database should be 1")
    }

}
