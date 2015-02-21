//
//  EditPresentationViewController.swift
//  KeyCheat
//
//  Created by hatebyte on 2/19/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import UIKit

class EditPresentationViewController: UIViewController {

    @IBOutlet var cancelButton:UIButton?
    @IBOutlet var saveButton:UIButton?
    @IBOutlet var newClueButton:UIButton?
    @IBOutlet var presentationTitleTF:UITextField?
    @IBOutlet var totalTimeLabel:UILabel?
    
    override init() {
        super.init(nibName: "EditPresentationViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    
    // MARK: ADD/REMOVE handles
    func addEventHandlers() {
        self.saveButton?.addTarget(self, action: "save:", forControlEvents: UIControlEvents.TouchUpInside)
        self.cancelButton?.addTarget(self, action: "pop:", forControlEvents: UIControlEvents.TouchUpInside)
        self.newClueButton?.addTarget(self, action: "addNewClue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func removeEventHandlers() {
        self.saveButton?.removeTarget(self, action: "save:", forControlEvents: UIControlEvents.TouchUpInside)
        self.cancelButton?.removeTarget(self, action: "pop:", forControlEvents: UIControlEvents.TouchUpInside)
        self.newClueButton?.removeTarget(self, action: "addNewClue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
   
    func addNewClue(sender:UIButton) {
        let newClueController = EditClueViewController()
        self.navigationController?.pushViewController(newClueController, animated: true)
    }

}

