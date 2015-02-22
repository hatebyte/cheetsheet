//
//  PerformanceViewModel.swift
//  KeyCheat
//
//  Created by hatebyte on 2/22/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import Foundation

typealias PerformanceData = (clueIndex:Int, clueData:String, remainingClueTime:Int, remainingPerformanceTime:Int)

class PerformanceViewModel {

    var performanceData:PerformanceData?
    
    var remainingPerformanceTime:String {
        get {
            return ClockFormatter.format(performanceData!.remainingPerformanceTime)
        }
    }
    
    
    
}
