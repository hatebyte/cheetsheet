//
//  MockClueCountdownClock.swift
//  KeyCheat
//
//  Created by hatebyte on 2/21/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import Foundation

class MockClueCountdownClock: ClueCountdownClock {

    var didStartGetCalled = false
   
    func falseStart() {
        start()
        pause()
    }
   
    func triggerUpdate() {
        updateDecrementer()
    }
    
    func triggerFinished() {
        clueFinished()
    }
    
    func isTimerValid()->Bool {
        return timer.valid
    }
    
}
