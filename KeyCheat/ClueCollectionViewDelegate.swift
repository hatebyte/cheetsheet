//
//  ClueCollectionViewDelegate.swift
//  KeyCheat
//
//  Created by hatebyte on 2/23/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

import UIKit

typealias DidSelectCell = (Int)->()

class ClueCollectionViewDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: UICollectionViewDataSource
    var clues:[String]!
    var didSelectCell:DidSelectCell!
    
    init(clues:[String]) {
        self.clues = clues
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.clues.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell:PerformanceCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(PerformanceCollectionViewCell.ReuseIdentifier, forIndexPath: indexPath) as PerformanceCollectionViewCell
        cell.clueLB?.text = clues[indexPath.row]
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        if let dsc = didSelectCell {
//            dsc(indexPath.row)
//        }
//    }
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
            return collectionView.bounds.size
    }
    
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
}
