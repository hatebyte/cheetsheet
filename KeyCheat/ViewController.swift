//
//  ViewController.swift
//  KeyCheat
//
//  Created by hatebyte on 2/19/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func pop(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func save(sender:UIButton) {
        let presentation = self.navigationController?.viewControllers[1] as UIViewController
        self.navigationController?.popToViewController(presentation, animated: true)
    }
    
}


