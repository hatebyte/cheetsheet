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

struct Presentation {
    let clues:[Clue]
    let isDraft:Bool
}


extension Presentation {

    func remainingPerformanceTime() {
    
    }
    
    func totalTime()->Int {
        return self.clues.reduce(0) { (total:Int, c:Clue) in
            total + c.time
        }
    }
    
    func totalTimeLeft(clueIndex:Int)->Int {
        var l                       = self.clues
        let leftoverClues:[Clue]    = Array(l[(clueIndex+1)..<l.count])
        return leftoverClues.reduce(0) { (total:Int, c:Clue) in
            total + c.time
        }
    }
    
    func cluesData()->[String] {
        return self.clues.map { (c:Clue)->String in
            return c.data
        }
    }
    
}
