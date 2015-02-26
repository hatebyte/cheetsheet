//
//  MockPresentationPerformer.swift
//  KeyCheat
//
//  Created by hatebyte on 2/22/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import Foundation

class MockPresentationPerformer: PresentationPerformer {
    
    var currentClueCountdownClock:MockClueCountdownClock? {
        get {
            return self.clueCoundownClock as MockClueCountdownClock?
        }
    }

    override func start() {
        currentClueCountdownClock!.falseStart()
        clueCountDownUpdate()
    }
    
    func getClueCoundownClock()->MockClueCountdownClock {
        return self.clueCoundownClock as MockClueCountdownClock
    }
    
    override func createClue()->MockClueCountdownClock {
        return MockClueCountdownClock(clue:presentation.clues[currentClueIndex]);
    }
    
}
