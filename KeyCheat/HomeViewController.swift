//
//  HomeViewController.swift
//  KeyCheat
//
//  Created by hatebyte on 2/19/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var addPresentationButton:UIButton?
    
    override init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.addEventHandlers()
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.removeEventHandlers()
    }
    
    override func viewDidAppear(animated: Bool) {
        let delayTime                               = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.sendToPerformance()
        }
    }

    // MARK: ADD/REMOVE handles
    func addEventHandlers() {
        self.addPresentationButton?.addTarget(self, action: "addPresentation:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func removeEventHandlers() {
        self.addPresentationButton?.removeTarget(self, action: "addPresentation:", forControlEvents: UIControlEvents.TouchUpInside)
    }

    func addPresentation(sender:UIButton) {
        let newPresentationController = EditPresentationViewController()
        self.navigationController?.pushViewController(newPresentationController, animated: true)
    }
    
    func sendToPerformance() {
        let performanceViewController = PerformanceViewController()
        self.navigationController?.pushViewController(performanceViewController, animated: true)
    }
    
}
