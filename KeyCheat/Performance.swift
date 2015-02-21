//
//  Permformance.swift
//  KeyCheat
//
//  Created by hatebyte on 2/20/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import Foundation

struct Clue {
    let time:Int
    let data:String
    let performanceIndex:Int
}

struct Performance {
    let clues:[Clue]
    let isDraft:Bool
    let totalTime:Int
}

