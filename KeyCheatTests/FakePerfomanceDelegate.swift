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
    
    func update(performanceData:PerformanceData) {
    }
    
    func clueCompleted(performanceData:PerformanceData) {
    }
    
    func presentationCompleted(performanceData:PerformanceData) {
        isPresentationComplete = true
    }

}
