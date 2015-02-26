//
//  PerformanceCollectionViewCell.swift
//  KeyCheat
//
//  Created by hatebyte on 2/23/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import UIKit

class PerformanceCollectionViewCell: UICollectionViewCell {

    @IBOutlet var clueLB:UILabel!

    class var ReuseIdentifier: String { return "PerformanceCollectionViewCell" }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.userInteractionEnabled = false
    }

    override var selected:Bool {
        willSet {
            if newValue == true {
                clueLB!.backgroundColor = UIColor.redColor()
            } else {
                clueLB!.backgroundColor = UIColor.clearColor()
            }
        }
    }
}
