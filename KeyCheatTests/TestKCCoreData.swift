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
    var presentation:Presentation!
    
    override func setUp() {
        var clues = [Clue]()
        for i in 0..<15 {
            let c = Clue(id:i, time:10, data: "Clue number \(i)", performanceIndex:i)
            clues += [c]
        }
        presentation = Presentation(id: 1, clues: clues, isDraft: false)
        super.setUp()
    }
    
    override func tearDown() {
        MockKCCoreData.reset()
        tempWritingContext = nil
        readContext = nil
        super.tearDown()
    }

    func testClueCanBeSavedAndFetchedInDb() {
        let cManaged              = ClueModel.newObjectInContext(tempWritingContext)
        cManaged.uid              = 1
        cManaged.time             = 15
        cManaged.data             = "This is a clue"
        cManaged.performanceIndex = 2
        tempWritingContext.saveSynchronously()
        
        let clue                  = ClueModel.fetchFirstObjectInContext(readContext, sortedBy:nil, withPredicate:NSPredicate(format: "uid == \(1)"))
        XCTAssert(clue.uid == 1, "The clue.uid fetched from the database should be 1")
    }
    
    func testPresentationCanBeSavedAndFetchedInDb() {
        let cManaged              = PresentationModel.newObjectInContext(tempWritingContext)
        cManaged.uid              = 1
        cManaged.isDraft          = true
        tempWritingContext.saveSynchronously()
        
        let presentation          = PresentationModel.fetchFirstObjectInContext(readContext, sortedBy:nil, withPredicate:NSPredicate(format: "uid == \(1)"))
        XCTAssert(presentation.uid == 1, "The presentation.uid fetched from the database should be 1")
    }
    
    func testPresentationAndCluesCanBeSavedAndFetchedInDb() {
        let pManaged              = PresentationModel.newObjectInContext(tempWritingContext)
 
        var clues = [ClueModel]()
        for i in 0..<15 {
            let c                 = ClueModel.newObjectInContext(tempWritingContext)
            c.uid                 = i
            c.time                = 10
            c.data                = "Clue number \(i)"
            c.performanceIndex    = i
            clues += [c]
        }

        let presentation          = PresentationModel.newObjectInContext(tempWritingContext)
        presentation.uid          = 1
        presentation.isDraft      = true
        presentation.clues        = NSSet(array:clues)
        tempWritingContext.saveSynchronously()
 
        let readPresentation      = PresentationModel.fetchFirstObjectInContext(readContext, sortedBy:nil, withPredicate:NSPredicate(format: "uid == \(1)"))
        
        XCTAssert(readPresentation.clues.count == 15, "The number of clues in the presentation should be 14")
    }
    
}






















