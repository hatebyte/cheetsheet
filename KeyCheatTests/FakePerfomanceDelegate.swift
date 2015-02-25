//
//  FakePerfomanceDelegate.swift
//  KeyCheat
//
//  Created by hatebyte on 2/22/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import Foundation

class FakePerfomanceDelegate: NSObject, PresentationPerformerDelegate {
    
    var isPresentationComplete = false
    var newClueIndex:Int = 0
    
    func update(performanceData:PerformanceViewPresenter) {
        newClueIndex = performanceData.index
    }
    
    func clueStarted(performancePresenter:PerformanceViewPresenter) {}
    
    func clueCompleted(performanceData:PerformanceViewPresenter) {
    }
    
    func presentationCompleted(performanceData:PerformanceViewPresenter) {
        isPresentationComplete = true
    }

}
