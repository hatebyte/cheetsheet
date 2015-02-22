//
//  ClockFormatter.swift
//  KeyCheat
//
//  Created by hatebyte on 2/22/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import Foundation

class ClockFormatter: NSObject {
    
    class func format(secs:Int)->String {
        let minutes:Int = Int(floor(Double(secs) / 60))
        let seconds:Int = Int(floor(Double(secs) - Double(minutes * 60)))
        var s = (seconds < 10) ? "0\(seconds)" : "\(seconds)"
        var m = "\(minutes)"
        return "\(m):\(s)"
    }
}
