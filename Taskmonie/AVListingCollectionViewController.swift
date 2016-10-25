//
//  AVListingCollectionViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 04/09/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit
import STPopup

private let reuseIdentifier = "AudioVideoCellIdentifier"

class AVListingCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var isAudio: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(AVCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? AVCollectionViewCell
    
        if isAudio {
            cell?.playButton.setImage(UIImage.init(named: "music_clip"), forState: UIControlState.Normal)
        }
        // Configure the cell
        
        cell!.detailButton.addTarget(self, action: #selector(detailButtonTapped(_:)), forControlEvents: .TouchUpInside)
        
        cell?.contentEarningAmount.text = convertToRupees("5")
        
    
        return cell!
    }
    
    
    func detailButtonTapped(button: UIButton) {
        
        
        let detailVC    =   self.storyboard?.instantiateViewControllerWithIdentifier("videoDetailPopupVC")
        let popupView = STPopupController.init(rootViewController: detailVC!)
        popupView.containerView.layer.cornerRadius = 6.0;
        popupView.containerView.layer.borderWidth = 1;
        popupView.containerView.layer.borderColor = UIColor.whiteColor().CGColor
        popupView.presentInViewController(self)
        
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize.init(width: self.view.frame.size.width, height: 150)
    }

    // MARK: UICollectionViewDelegate

    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let playerVC    =   (isAudio) ? AudioPlayerViewController() : VideoPlayerViewController()
        
        self.navigationController?.pushViewController(playerVC, animated: true)
    }
    
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
