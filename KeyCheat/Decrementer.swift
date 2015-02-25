//
//  Decrementer.swift
//  KeyCheat
//
//  Created by hatebyte on 2/20/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//
import Foundation

typealias DecrementorFinished = ()->()

class Decrementer {
   
    var finished:DecrementorFinished!
    let top:Int!
    let decreaser:Int!
    var val:Int!
    
    init(top:Int, decreaser:Int, finished:DecrementorFinished) {
        self.top            = top-1
        self.decreaser      = decreaser
        self.finished       = finished
        reset()
    }
    
    init(top:Int, decreaser:Int) {
        self.top            = top-1
        self.decreaser      = decreaser
        reset()
    }

    func reset() {
        val                 = top
    }

    func invalidate() {
        val                 = -1
    }
    
    func update() {
        if val == -1 {
            return
        }
        let pseudo          = val - decreaser
        if val == 0 {
            finished()
        } else {
            val             = pseudo
        }
    }
    
}
