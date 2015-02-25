//
//  ClueCountdownClock.swift
//  KeyCheat
//
//  Created by hatebyte on 2/20/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import Foundation

typealias ClueFinished = ()->()
typealias Updator = ()->()

class ClueCountdownClock:NSObject {

    var clue:Clue!
    var finisher:ClueFinished?
    var updator:Updator?
    internal var timer:NSTimer!
    internal var decrementer:Decrementer!
    
    init(clue:Clue) {
        self.clue               = clue
        self.decrementer        = Decrementer(top: self.clue.time, decreaser:1)
    }
   
    // MARK: Public
    func start() {
        decrementer.finished    = clueFinished
        timer                   = makeTimer()
        if let u = updator {
            u()
        }
    }
    
    func pause() {
        if let t  = timer {
            t.invalidate()
        }
        timer                   = nil
    }
    
    func resume() {
        timer                   = makeTimer()
    }
    
    // MARK: Get
    var remainingTime:Int {
        get  {
            return decrementer.val
        }
    }
   
    // MARK: Private
    internal func makeTimer()->NSTimer {
        return NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:"updateDecrementer", userInfo: nil, repeats: true)
    }
    
    internal func clueFinished() {
        pause()
        decrementer.invalidate()
        if let f = finisher {
            f()
        }
    }
    
    internal func updateDecrementer() {
        decrementer.update()
        if decrementer.val >= 0 {
            if let u = updator {
                u()
            }
        }
    }
    
}
