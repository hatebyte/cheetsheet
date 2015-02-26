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
    internal var clueIndex:Int              = 0
    
    var performanceData:PerformanceData?
    var performanceUpdator:PerformanceUpdator?
    var performanceFinisher:PerformanceFinisher?
    let totalTime:Int!
    var delegate:PresentationPerformerDelegate?
    var viewPresenter:PerformanceViewPresenter!
    
    init(presentation:Presentation) {
        self.presentation                   = presentation
        self.totalTime                      = presentation.totalTime()
        clueCoundownClock                   = createClue()
        clueCoundownClock.updator           = clueCountDownUpdate
        clueCoundownClock.finisher          = clueCountDownFinisher
        viewPresenter                       = PerformanceViewPresenter()
        viewPresenter.tt                    = presentation.totalTime()
        formatData()
        
        // SO THAT THE FIRST TIMER SHOW A FAMILAR DIGIT
        var pd                              = viewPresenter.performanceData!
        pd.remainingClueTime                = pd.remainingClueTime + 1
        viewPresenter.performanceData       = pd
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
    
    var currentClueIndex:Int {
        get {
            return clueIndex
        }
        set (newValue) {
            clueIndex                    = newValue
            updateForClueIndex()
        }
    }
    
    // MARK: public
    func start() {
        if let cc = clueCoundownClock {
            cc.start()
            if let d = delegate {
                d.clueStarted(viewPresenter!)
            }
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
    
    func cancel() {
        clueCoundownClock.pause()
        clueCoundownClock = nil
    }
    
    private func updateForClueIndex() {
        pause()
        clueCoundownClock                   = createClue()
        clueCoundownClock.updator           = clueCountDownUpdate
        clueCoundownClock.finisher          = clueCountDownFinisher
        start()
        
        formatData()
        if let d = delegate {
            d.clueStarted(viewPresenter)
        }
    }

    internal func formatData() {
        let clue                            = presentation.clues[clueIndex]
        let finishedCluesTotalTime          = presentation.totalTimeLeft(clueIndex)
        let remainingClueTime               = clueCoundownClock.remainingTime

        performanceData                     = PerformanceData(
            clueIndex:clueIndex,
            clueData:clue.data,
            remainingClueTime:remainingClueTime,
            remainingPerformanceTime:remainingClueTime + finishedCluesTotalTime
        )
        viewPresenter.performanceData       = performanceData
    }
    
    internal func createClue()->ClueCountdownClock {
        return ClueCountdownClock(clue: presentation.clues[clueIndex]);
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
            if let d = delegate {
                d.clueCompleted(viewPresenter!)
            }
            currentClueIndex                = currentClueIndex+1
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
