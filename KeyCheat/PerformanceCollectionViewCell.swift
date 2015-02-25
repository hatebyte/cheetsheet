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

    }

}
