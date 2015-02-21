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

class ClueCountdownClock {

    var clue:Clue!
    var finisher:ClueFinished?
    var updator:Updator?
    internal var timer:NSTimer!
    internal var decrementer:Decrementer!
    
    
    init(clue:Clue) {
        self.clue               = clue
    }
   
    // MARK: Public
    func start() {
        self.decrementer        = Decrementer(top: self.clue.time, decreaser:1)
        decrementer.finished    = clueFinished
        timer                   = makeTimer()
    }
    
    func pause() {
        timer.invalidate()
    }
    
    func resume() {
        timer                   = makeTimer()
    }
    
    func restart() {
        self.start()
    }
    
    // MARK: Get
    var remainingTime:Int {
        get  {
            return decrementer.val
        }
    }
   
    // MARK: Private
    internal func makeTimer()->NSTimer {
        return NSTimer(timeInterval: 1.0, target: self, selector: "updateDecrementer", userInfo: nil, repeats:true)
    }
    
    internal func clueFinished() {
//        if remainingTime == 0 {
            pause()
            if let f = finisher {
                f()
            }
//        }
    }
    
    internal func updateDecrementer() {
        if remainingTime > 0 {
            decrementer.update()
            if let u = updator {
                u()
            }
        }
    }
    
}
