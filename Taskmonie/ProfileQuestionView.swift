//
//  ProfileQuestionView.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 01/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class ProfileQuestionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var textField: TMTextField!
    
    var carouselArray = []
    var segmentIndex: Int?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource       =   self
        collectionView.delegate         =   self
        collectionView.clipsToBounds    =   true
        
        collectionView.registerNib(UINib.init(nibName: "QuestionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "profileQuestionCellIdentifier")
        collectionView.backgroundColor = .whiteColor()
        
        
        
        
    }
    
    
    override func drawRect(rect: CGRect) {
        if segmentIndex == 0 {
            questionLabel.text  =   "Please Enter your personal Info"
        }
        else if segmentIndex == 1 {
            questionLabel.text  = "Please Choose your Hobbies"
        }
        else {
            questionLabel.text  =   "Please Choose your Occupation"
        }
    }
    
    
    func refreshUI() {
        
        questionLabel.frame     =   CGRect.init(x: 20, y: 0, width: self.frame.width-40, height: 60)
        collectionView.frame    =   CGRect.init(x: 15, y: 60+8, width: self.frame.width-30, height: self.frame.height - 60-8-8)
        
    }
    
    
    func showTextField() {
        collectionView.hidden   =   true
        
        

    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return carouselArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        
        return CGSize.init(width: 70, height: 100)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("profileQuestionCellIdentifier", forIndexPath: indexPath) as! QuestionCollectionViewCell
        
        
//        let keys   =   carouselArray.allKeys
//        print(keys)
//        let keyname = keys[indexPath.item]
        
        
//        let value = carouselArray.objectForKey(keyname)
        
//        print(value)
        
        
        cell.imageView.layer.cornerRadius     =   cell.frame.width/2
        cell.imageView.layer.borderColor      =   UIColor.blackColor().CGColor
        cell.imageView.layer.borderWidth      =   2
        cell.imageView.layer.masksToBounds    =   false
        
        cell.textLabel.text         =   carouselArray[indexPath.item] as? String
//        cell.textLabel.text         =   value![indexPath.item] as? String
        
        return cell
    }
}
