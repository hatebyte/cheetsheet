//
//  PresentationPerformer.swift
//  KeyCheat
//
//  Created by hatebyte on 2/21/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import Foundation

typealias PerformanceUpdator = ()->PerformanceData
typealias PerformanceFinisher = ()->()

protocol PresentationPerformerDelegate {
    func update(performanceData:PerformanceData)
    func clueCompleted(performanceData:PerformanceData)
    func presentationCompleted(performanceData:PerformanceData)
}

class PresentationPerformer {
    
    internal var presentation:Presentation!
    internal var clueCoundownClock:ClueCountdownClock!
    internal var currentClueIndex:Int!
    
    var performanceData:PerformanceData?
    var performanceUpdator:PerformanceUpdator?
    var performanceFinisher:PerformanceFinisher?
    let totalTime:Int!
    var delegate:PresentationPerformerDelegate?
    
    init(presentation:Presentation) {
        self.presentation               = presentation
        self.currentClueIndex           = 0
        self.totalTime                  = presentation.totalTime()
        clueCoundownClock                = createClue()
        clueCoundownClock.updator        = clueCountDownUpdate
        clueCoundownClock.finisher       = clueCountDownFinisher
    }
    
    // MARK: public
    func start() {
       clueCoundownClock.start()
    }
    
    func pause() {
        clueCoundownClock.pause()
    }
    
    func resume() {
        clueCoundownClock.resume()
    }
    
    func setCurrentClue(index:Int) {
        currentClueIndex = index
        start()
    }
    
    func quit() {
        // inform navigator of finish
    }

    func editPresentation() {
        pause()
        // inform navigator of edit Presentation
    }
    
    func editStep() {
        // inform navigator of edit Step (currentClueIndex)
        
    }
    
    func refreshData() {
        
    }
    
    internal func createClue()->ClueCountdownClock {
        return ClueCountdownClock(clue: presentation.clues[currentClueIndex]);
    }
    
    // MARK: closures
    internal func clueCountDownUpdate() {
        let clue                        = presentation.clues[currentClueIndex]
        let finishedCluesTotalTime      = presentation.totalTimeLeft(currentClueIndex)
        let remainingClueTime           = clueCoundownClock.remainingTime
        performanceData                 = (clueIndex:currentClueIndex, clueData:clue.data, remainingClueTime:remainingClueTime, remainingPerformanceTime:remainingClueTime + finishedCluesTotalTime)
        if let d = delegate {
            d.update(performanceData!)
        }
    }
    
    internal func clueCountDownFinisher() {
        // inform navigator of done
        if currentClueIndex < presentation.clues.count-1 {
            currentClueIndex                = currentClueIndex + 1
            clueCoundownClock               = createClue()
            clueCoundownClock.updator       = clueCountDownUpdate
            clueCoundownClock.finisher      = clueCountDownFinisher
            start()
            if let d = delegate {
                d.presentationCompleted(performanceData!)
            }
        } else {
            if let d = delegate {
                d.presentationCompleted(performanceData!)
            }
        }
    }

    
}

//
//• presentation
//• currentClueIndex
//• presentationTotalTime
//• finishedCluesTime
//• clueCountdownClock
//• returnViewModel
//
//• start
//• pause
//• resume
//• setClue