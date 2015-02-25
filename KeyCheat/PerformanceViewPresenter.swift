//
//  PerformanceViewModel.swift
//  KeyCheat
//
//  Created by hatebyte on 2/22/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import Foundation

struct PerformanceData {
    let clueIndex:Int
    let clueData:String
    var remainingClueTime:Int
    var remainingPerformanceTime:Int
}

class PerformanceViewPresenter {

    var performanceData:PerformanceData?
    var tt:Int = 0
    
    init() {
        
    }
   
    var totalPerformanceTime:String {
        get {
            return ClockFormatter.format(tt)
        }
    }
    
    var remainingPerformanceTime:String {
        get {
            if let pd = performanceData {
                if pd.remainingPerformanceTime < 0 {
                    return "0:00"
                }
                return ClockFormatter.format(pd.remainingPerformanceTime)
            } else {
                return self.totalPerformanceTime
            }
        }
    }
   
    var remainingClueTime:String {
        get {
            if let pd = performanceData {
                if pd.remainingClueTime < 0 {
                    return "0:00"
                }
             return ClockFormatter.format(pd.remainingClueTime)
            } else {
                return "0:00"
            }
        }
    }

    var data:String {
        get {
            if let pd = performanceData {
                return pd.clueData
            } else {
                return ""
            }
        }
    }
   
    var index:Int {
        get {
            if let pd = performanceData {
                return pd.clueIndex
            } else {
                return 0
            }
        }
    }
    

}
