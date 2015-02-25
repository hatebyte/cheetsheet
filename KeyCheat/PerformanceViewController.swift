//
//  PerformanceViewController.swift
//  KeyCheat
//
//  Created by hatebyte on 2/19/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import UIKit

class PerformanceViewController: UIViewController, PresentationPerformerDelegate {

    @IBOutlet var cancelBT:UIButton?
    @IBOutlet var editClueBT:UIButton?
    @IBOutlet var clueTimeLB:UILabel?
    @IBOutlet var clueCollectionView:UICollectionView?
    @IBOutlet var totalTimeLB:UILabel?
  
    let cancelBT_Txt                            = NSLocalizedString("Cancel", comment:"Button titleText : Cancel")
    let editBT_Txt                              = NSLocalizedString("Edit", comment:"Button titleText : Edit")
    
    var presentationPerformer:PresentationPerformer!
    var clueCollectionViewDelegate:ClueCollectionViewDelegate!

    override init() {
        super.init(nibName: "PerformanceViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var clues                               = [Clue]()
        for i in 0..<5 {
            var t:Int                           = random() % 20 + 10
            let c                               = Clue(time:t, data: "Clue number \(i)", performanceIndex:i)
            clues += [c]
        }
        let presentation                        = Presentation(clues: clues, isDraft: false)
        self.presentationPerformer              = PresentationPerformer(presentation: presentation)
        self.presentationPerformer.delegate     = self

        clueTimeLB!.text                        = presentationPerformer.viewPresenter.remainingClueTime
        totalTimeLB!.text                       = presentationPerformer.viewPresenter.totalPerformanceTime

        clueCollectionViewDelegate              = ClueCollectionViewDelegate(clues:presentation.cluesData())
        clueCollectionView!.registerNib(UINib(nibName: "PerformanceCollectionViewCell", bundle:nil), forCellWithReuseIdentifier:PerformanceCollectionViewCell.ReuseIdentifier)
        clueCollectionView!.delegate            = clueCollectionViewDelegate
        clueCollectionView!.dataSource          = clueCollectionViewDelegate
        clueCollectionViewDelegate.didSelectCell = self.didSelectCell
        let flowLayout                          = clueCollectionView!.collectionViewLayout as UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing           = 0.0;
 
        self.editClueBT?.setTitle(editBT_Txt, forState: UIControlState.Normal)
        self.editClueBT?.enabled                = false
        
        self.cancelBT?.setTitle(cancelBT_Txt, forState: UIControlState.Normal)
        
        let tapDoubleGesture                    = UITapGestureRecognizer(target: self, action:"doubleTappedClue:")
        tapDoubleGesture.numberOfTapsRequired   = 2
        clueCollectionView!.addGestureRecognizer(tapDoubleGesture)

        let tapSingleGesture                    = UITapGestureRecognizer(target: self, action:"singleTappedClue:")
        tapSingleGesture.numberOfTapsRequired   = 1
        tapSingleGesture.requireGestureRecognizerToFail(tapDoubleGesture)
        clueCollectionView!.addGestureRecognizer(tapSingleGesture)
    }
    
    var currentPage:Int {
        get {
            return Int(abs(clueCollectionView!.contentOffset.x / clueCollectionView!.bounds.size.width))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.addEventHandlers()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.presentationPerformer.start()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeEventHandlers()
    }
    
    // MARK: ADD/REMOVE handles
    func didSelectCell(index:Int) {
        self.presentationPerformer.setCurrentClue(index)
    }
    
    func addEventHandlers() {
        self.cancelBT?.addTarget(self, action: "cancel", forControlEvents: UIControlEvents.TouchUpInside)
//        self.editClueBT?.addTarget(self, action: "edit", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func removeEventHandlers() {
        self.cancelBT?.removeTarget(self, action: "cancel", forControlEvents: UIControlEvents.TouchUpInside)
//        self.editClueBT?.removeTarget(self, action: "edit", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: Gesture/Tap Handlers
    func doubleTappedClue(sender: AnyObject) {
        self.presentationPerformer.setCurrentClue(currentPage)
    }
    
    func singleTappedClue(sender: AnyObject) {
        if presentationPerformer.isPaused == true {
            presentationPerformer.resume()
        } else {
            presentationPerformer.pause()
        }
    }
    
    func cancel() {
        self.presentationPerformer.cancel()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func edit() {
        
    }
    
    func editPresentation() {
    
    }
    
    func editStep() {
        // inform navigator of edit Step (currentClueIndex)
        
    }
    
    //MARK: PresentationPerformerDelegate
    func update(performancePresenter:PerformanceViewPresenter) {
        clueTimeLB!.text                        = performancePresenter.remainingClueTime
        totalTimeLB!.text                       = performancePresenter.remainingPerformanceTime
    }
    
    func clueStarted(performancePresenter:PerformanceViewPresenter) {
        if performancePresenter.index != currentPage {
            clueCollectionView!.scrollToItemAtIndexPath(NSIndexPath(forRow:performancePresenter.index, inSection: 0), atScrollPosition:UICollectionViewScrollPosition.Left, animated: true)
        }
    }

    func clueCompleted(performancePresenter:PerformanceViewPresenter) {
        clueTimeLB!.text                        = performancePresenter.remainingClueTime
        totalTimeLB!.text                       = performancePresenter.remainingPerformanceTime
      
        clueCollectionView!.scrollToItemAtIndexPath(NSIndexPath(forRow:performancePresenter.index, inSection: 0), atScrollPosition:UICollectionViewScrollPosition.Left, animated: true)
    }
    
    func presentationCompleted(performancePresenter:PerformanceViewPresenter) {
        clueTimeLB!.text                        = "0:00"
        totalTimeLB!.text                       = "0:00"
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
           self.sendToCompletedScreen()
        }
    }
    
    func sendToCompletedScreen() {
        let completedViewController = CompletedViewController()
        self.navigationController?.pushViewController(completedViewController, animated: true)
    }
}
