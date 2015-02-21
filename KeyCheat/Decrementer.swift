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
        self.top = top
        self.decreaser = decreaser
        self.finished = finished
        reset()
    }
    
    init(top:Int, decreaser:Int) {
        self.top = top
        self.decreaser = decreaser
        reset()
    }

    func reset() {
        val = top
    }
    
    func update() {
        if val <= 0 {
            return
        }
        val = val - decreaser
        if val == 0 {
            finished()
        }
    }
    
}
