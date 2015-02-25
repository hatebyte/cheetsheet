//
//  CompletedViewController.swift
//  KeyCheat
//
//  Created by hatebyte on 2/24/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import UIKit

class CompletedViewController: UIViewController {
  
    @IBOutlet var exitBT:UIButton?
    @IBOutlet var messageLB:UILabel?
   
    let messageLB_Txt                               = NSLocalizedString("Finished, Hopefully they applauded...", comment:"Label message : Completed")
    let exitBT_Txt                                  = NSLocalizedString("Exit", comment:"Button titleText : Exit")
    
    override init() {
        super.init(nibName: "CompletedViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        self.exitBT?.setTitle(exitBT_Txt, forState: UIControlState.Normal)
        
        self.messageLB!.numberOfLines               = 0
        self.messageLB!.text                        = messageLB_Txt
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.addEventHandlers()
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.removeEventHandlers()
    }
    
    
    // MARK: ADD/REMOVE handles
    func addEventHandlers() {
        self.exitBT?.addTarget(self, action: "popToHome", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func removeEventHandlers() {
        self.exitBT?.removeTarget(self, action: "popToHome", forControlEvents: UIControlEvents.TouchUpInside)
    }

    func popToHome() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
