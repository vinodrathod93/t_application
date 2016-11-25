//
//  AVListingCollectionViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 04/09/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit
import STPopup
import Alamofire
import AVFoundation

private let reuseIdentifier = "AudioVideoCellIdentifier"

class AVListingCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var isAudio: Bool = false
    var isPolls: Bool = false
    var isRegister: Bool = false
    var avArray: NSArray = []
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
        
        
        let indicatorView   =   UIActivityIndicatorView.init(activityIndicatorStyle: .WhiteLarge)
        indicatorView.center    =   self.view.center
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        self.view.addSubview(indicatorView)
        
        let urlString: String
        
        if isAudio {
            urlString = "http://ec2-35-154-7-228.ap-south-1.compute.amazonaws.com/api/tasks/all/audio_clip"
        }
        else {
            urlString = "http://ec2-35-154-7-228.ap-south-1.compute.amazonaws.com/api/tasks/all/video_clip"
        }
        
        
        Alamofire.request(.GET, urlString, parameters: ["api_token":"3243480952"], encoding: .URL, headers: nil).responseJSON { (response) in
            
            indicatorView.stopAnimating()
            
            
            
            switch response.result {
            case .Success:
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    print(JSON["data"])
                    
                    if let tempArray = JSON["data"] as? NSArray {
                        
                        self.avArray = tempArray
                        
                        
                        self.collectionView?.reloadData()
                    }
                }
                
            case .Failure(let error):
                print(error)
            }
            
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return avArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? AVCollectionViewCell
    
        
        // Configure the cell
        
        let dictionary = avArray[indexPath.item]
        
        if let brand_name = dictionary["brand_name"] as? String {
            cell?.ContentName.text  =   brand_name
        }
        
        if let duration = dictionary.valueForKeyPath("meta.video_clip_duration") as? String {
            cell?.durationLabel.text    =   "Duration:\(duration) seconds"
        }
        
        
        if let reward = dictionary.valueForKeyPath("meta.video_clip_reward") as? String {
            cell?.contentEarningAmount.text = convertToRupees(reward)
        }
        
        if let validity = dictionary.valueForKeyPath("meta.launch_to") as? String {
            cell?.validityLabel.text    =   validity
        }
        
        
        
        //            if let videoURL = dictionary.valueForKeyPath("meta.file") as? String {
        //
        //                let image   =   thumbnail(sourceURL: NSURL.init(string: videoURL)!)
        //                print(image)
        //
        //                cell?.PreviewImageView.image = image
        //            }
        
        
        cell!.detailButton.addTarget(self, action: #selector(detailButtonTapped(_:)), forControlEvents: .TouchUpInside)
        
        
        if isAudio {
            cell?.playButton.setImage(UIImage.init(named: "music_clip"), forState: UIControlState.Normal)
        }
        else if isPolls {
            
            cell?.playButton.hidden =   true
            cell?.durationLabel.font    =   UIFont.systemFontOfSize(10)
            
            if let duration = dictionary.valueForKeyPath("meta.video_clip_duration") as? String {
                cell?.durationLabel.text    =   "Time Remaining:\(duration) minutes \nGeneral"
            }
            
            
        }
        
        
        cell?.completedLabel.backgroundColor    =   .whiteColor()
        cell?.completedLabel.layer.cornerRadius =   90/2
        cell?.completedLabel.layer.borderWidth  =   1.5
        cell?.completedLabel.layer.borderColor  =   UIColor.redColor().CGColor
        cell?.completedLabel.layer.masksToBounds    =   true
        cell?.completedLabel.textColor          =   .redColor()
        
        cell?.completedLabel.hidden =   true
        
    
        return cell!
    }
    
    
    func detailButtonTapped(button: UIButton) {
        
        let cell        =   button.superview?.superview?.superview as! AVCollectionViewCell
        let indexPath   =   self.collectionView?.indexPathForCell(cell)
        let dictionary  =   avArray[indexPath!.item]
        
        if isPolls {
            
            let pollProviderInformationVC = self.storyboard?.instantiateViewControllerWithIdentifier("informationVC") as! InformationViewController
            pollProviderInformationVC.isPoll   =   true
            pollProviderInformationVC.isInformation =   true
            
            if let brand_logo = dictionary["brand_name"] as? String {
                pollProviderInformationVC.title =   brand_logo
            }
            
            pollProviderInformationVC.instruInformation =   "Amazon.com , often simply Amazon, is an American electronic commerce and cloud computing company, founded in July 5, 1994 by Jeff Bezos and based in Seattle, Washington. It is the largest Internet-based retailer in the world by total sales and market capitalization. Amazon.com started as an online bookstore, later diversifying to sell DVDs, Blu-rays, CDs, video downloads/streaming, MP3 downloads/streaming, audiobook downloads/streaming, software, video games, electronics, apparel, furniture, food, toys and jewelry. The company also produces consumer electronics—notably, Amazon Kindle e-readers, Fire tablets, and Fire TV—and is the world's largest provider of cloud infrastructure services (IaaS).Amazon also sells certain low-end products like USB cables under its in-house brand AmazonBasics.\n\nAmazon has separate retail websites for the United States, the United Kingdom and Ireland, France, Canada, Germany, Italy, Spain, Netherlands, Australia, Brazil, Japan, China, India and Mexico. Amazon also offers international shipping to certain other countries for some of its products. In 2016, Dutch and Polish language versions of the German Amazon website were launched "
            
            
            self.navigationController?.pushViewController(pollProviderInformationVC, animated: true)
            
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                print("test")
                cell.completedLabel.hidden  =   false
                cell.contentView.alpha      =   0.6
            }
            
            
            
            
        }
        else {
            
            
            let detailVC    =   self.storyboard?.instantiateViewControllerWithIdentifier("videoDetailPopupVC") as! VideoDetailPopupViewController
            
            
            
            
            if let about_company = dictionary["about_company"] as? String {
                detailVC.aboutCompanyString =   about_company
            }
            
            if let about_brand = dictionary["about_brand"] as? String {
                detailVC.aboutBrandString =   about_brand
            }
            
            if let brand_logo = dictionary["brand_logo"] as? String {
                detailVC.brandImageString =   brand_logo
            }
            
            let brand_logo = (dictionary["company_name"] as? String)! + "-" + (dictionary["brand_name"] as? String)!
            
            detailVC.taskName = brand_logo
            
            //        if let company_name = dictionary["company_name"] as? String {
            //            detailVC.brandImageString =   company_name
            //        }
            
            
            
            
            
            let popupView = STPopupController.init(rootViewController: detailVC)
            popupView.containerView.layer.cornerRadius = 6.0;
            popupView.containerView.layer.borderWidth = 1;
            popupView.containerView.layer.borderColor = UIColor.whiteColor().CGColor
            popupView.presentInViewController(self)
            
        }
        
        
        
        
    }
    
    
    func thumbnail(sourceURL sourceURL:NSURL) -> UIImage {
        let asset = AVAsset(URL: sourceURL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        let time = CMTimeMake(1, 30)
        
        do {
            let imageRef = try imageGenerator.copyCGImageAtTime(time, actualTime: nil)
            return UIImage(CGImage: imageRef)
        } catch {
            print(error)
            return UIImage(named: "some generic thumbnail")!
        }
    }
    
    

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize.init(width: self.view.frame.size.width, height: 150)
    }

    // MARK: UICollectionViewDelegate

    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        if isPolls {
            let pollInformationVC = self.storyboard?.instantiateViewControllerWithIdentifier("informationVC") as! InformationViewController
            pollInformationVC.isPoll   =   true
            pollInformationVC.isInformation =   false
            
            pollInformationVC.instruInformation =   "● This Poll can be completed only once.\n\n●The Reward will be credited to your Wallet within 1 day after completion of the Poll Period \n\n●In Case, of any kind of network error, the Registration will have to be restarted and resubmitted to earn Rewards "
            
            self.navigationController?.pushViewController(pollInformationVC, animated: true)
        }
        else {
            
            let dictionary  =   avArray[indexPath.item]
            let urlString   =   dictionary.valueForKeyPath("meta.file") as? String
            
            /*
             if isAudio {
             let audioPlayerVC   =   AudioPlayerViewController()
             audioPlayerVC.urlString =   urlString!
             self.navigationController?.pushViewController(audioPlayerVC, animated: true)
             }
             else {
             let videoPlayerVC   =   VideoPlayerViewController()
             videoPlayerVC.urlString =   urlString!
             self.navigationController?.pushViewController(videoPlayerVC, animated: true)
             }
             */
            
            let youtubeVC   =   self.storyboard?.instantiateViewControllerWithIdentifier("youtubeVCIdentifier")
            self.navigationController?.pushViewController(youtubeVC!, animated: true)
            
        }
        
        
        
        
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
