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
    func update(performancePresenter:PerformanceViewPresenter)
    func clueStarted(performancePresenter:PerformanceViewPresenter)
    func clueCompleted(performancePresenter:PerformanceViewPresenter)
    func presentationCompleted(performancePresenter:PerformanceViewPresenter)
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
    var viewPresenter:PerformanceViewPresenter!
    
    init(presentation:Presentation) {
        self.presentation                   = presentation
        self.currentClueIndex               = 0
        self.totalTime                      = presentation.totalTime()
        clueCoundownClock                   = createClue()
        clueCoundownClock.updator           = clueCountDownUpdate
        clueCoundownClock.finisher          = clueCountDownFinisher
        viewPresenter                       = PerformanceViewPresenter()
        viewPresenter.tt                    = presentation.totalTime()
        formatData()
        
        var pd                              = viewPresenter.performanceData!
        pd.remainingClueTime                = pd.remainingClueTime + 1
        viewPresenter.performanceData       = pd
        if let d = delegate {
            clueCountDownUpdate()
        }
    }
    
    var isPaused:Bool {
        get {
            if let timer = clueCoundownClock.timer {
                return false
            } else {
                return true
            }
        }
    }
    
    // MARK: public
    func start() {
        if let cc = clueCoundownClock {
            cc.start()
        }
    }
    
    func pause() {
        if let cc = clueCoundownClock {
            cc.pause()
        }
    }
    
    func resume() {
        if let cc = clueCoundownClock {
            cc.resume()
        }
    }
    
    func setCurrentClue(index:Int) {
        currentClueIndex                    = index
        pause()
        clueCoundownClock                   = createClue()
        clueCoundownClock.updator           = clueCountDownUpdate
        clueCoundownClock.finisher          = clueCountDownFinisher
        start()
        let clue                            = presentation.clues[currentClueIndex]
        let finishedCluesTotalTime          = presentation.totalTimeLeft(currentClueIndex)
        let remainingClueTime               = clueCoundownClock.remainingTime
        
        formatData()
        if let d = delegate {
            d.clueStarted(viewPresenter)
        }
    }
    
    func cancel() {
        clueCoundownClock.pause()
        clueCoundownClock = nil
    }
    
    func refreshData() {

    }
   
    internal func formatData() {
        let clue                            = presentation.clues[currentClueIndex]
        let finishedCluesTotalTime          = presentation.totalTimeLeft(currentClueIndex)
        let remainingClueTime               = clueCoundownClock.remainingTime

        performanceData                     = PerformanceData(
            clueIndex:currentClueIndex,
            clueData:clue.data,
            remainingClueTime:remainingClueTime,
            remainingPerformanceTime:remainingClueTime + finishedCluesTotalTime
        )
        viewPresenter.performanceData       = performanceData
    }
    
    internal func createClue()->ClueCountdownClock {
        return ClueCountdownClock(clue: presentation.clues[currentClueIndex]);
    }
    
    // MARK: closures
    internal func clueCountDownUpdate() {
        formatData()
        viewPresenter.performanceData       = performanceData
        if let d = delegate {
            d.update(viewPresenter!)
        }
    }
    
    internal func clueCountDownFinisher() {
        if let d = delegate {
            clueCountDownUpdate()
        }
        if currentClueIndex < presentation.clues.count-1 {
            setCurrentClue(currentClueIndex+1)

            if let d = delegate {
                d.clueCompleted(viewPresenter!)
            }
        } else {
            clueCoundownClock.pause()
            if let d = delegate {
                d.presentationCompleted(viewPresenter!)
            }
        }
        formatData()
        viewPresenter.performanceData       = performanceData

    }

    
}
