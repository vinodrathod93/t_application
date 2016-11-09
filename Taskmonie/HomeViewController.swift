//
//  HomeViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 04/09/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit
import SWRevealViewController

//,iCarouselDataSource>

class HomeViewController: UITableViewController,iCarouselDataSource, iCarouselDelegate {

    var menus = ["Video Clips","Audio Clips","Survey Form","Download App","Register", "Polls"]
    var menuImages = ["video_clip", "music_clip", "survey_form", "download_app", "register", "poll"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor    =   .blackColor()
        
        let walletLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 30))
        walletLabel.text    =   convertToRupees("455")
        walletLabel.font    =   UIFont.systemFontOfSize(15, weight: UIFontWeightSemibold)
        walletLabel.textAlignment   =   NSTextAlignment.Right
        
         self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: walletLabel)
        
        
        
        
        
        
        
        let title = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 240, height: 30))
        title.text =    "TaskMonie"
        title.textAlignment = NSTextAlignment.Left
        title.font  =   UIFont.systemFontOfSize(30, weight: UIFontWeightBold)
        title.textColor = .whiteColor()
        
        navigationItem.titleView   = title
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        
        if revealViewController() != nil {
            
            let menuButton = UIBarButtonItem.init(image: UIImage.init(named: "menu"), style: UIBarButtonItemStyle.Plain, target: revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            
            navigationItem.leftBarButtonItem   =   menuButton
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menus.count
    }


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeFeaturedCellIdentifier", forIndexPath: indexPath)
        
        cell.backgroundColor    =   .clearColor()
        
        cell.detailTextLabel?.text  = nil
        cell.textLabel?.text    = menus[indexPath.row]
        cell.textLabel?.textColor   =   .whiteColor()
        cell.textLabel?.font    = UIFont.systemFontOfSize(18, weight: UIFontWeightSemibold)
        
        let image               =   UIImage.init(named: menuImages[indexPath.row])
        cell.imageView?.image   =  changeColor(.whiteColor(), ofImage: image!)
        
        
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.blueColor()
        cell.selectedBackgroundView = bgColorView

        return cell
    }
    

    // MARK: - Table View Delegate
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return drawHeaderView()
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let videosVC = self.storyboard?.instantiateViewControllerWithIdentifier("AVListingVC") as? AVListingCollectionViewController
            videosVC?.title =   "Video Clips"
        
            
            self.navigationController?.pushViewController(videosVC!, animated: true)
            
        }
        else if indexPath.row == 1 {
            let audiosVC = self.storyboard?.instantiateViewControllerWithIdentifier("AVListingVC") as? AVListingCollectionViewController
            audiosVC?.title     =   "Audio Clips"
            audiosVC?.isAudio   = true
            
            self.navigationController?.pushViewController(audiosVC!, animated: true)
        }
        else if indexPath.row == 2 {
            let surveyViewVC    =   self.storyboard?.instantiateViewControllerWithIdentifier("surveyViewVC") as! SurveyViewController
            
            self.navigationController?.pushViewController(surveyViewVC, animated: true)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Header View
    
    func drawHeaderView() -> (UIView){
        //
        
        let carousel = iCarousel.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 150))
        
        carousel.type   =   iCarouselType.Linear
        carousel.pagingEnabled  =   true
        carousel.bounces = false
        carousel.delegate   =   self
        carousel.dataSource =   self
        
        return carousel
        
    }
    
    
    func numberOfItemsInCarousel(carousel: iCarousel!) -> Int {
        return 3
    }
    
    func carousel(carousel: iCarousel!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
    
        
        var itemView: UIView
        
        //create new view if no view is available for recycling
        if (view == nil)
        {
            itemView = UIView(frame:CGRect(x:20, y:10, width:self.view.frame.width-40, height:150-20))
            itemView.layer.borderColor  =   UIColor.clearColor().CGColor
            itemView.layer.borderWidth  =   0.5
            itemView.layer.cornerRadius =   5.0;
            
            if index%2 == 0 {
                itemView.backgroundColor    =   .redColor()
            }
            else {
                itemView.backgroundColor = .greenColor()
            }
        }
        else
        {
            //get a reference to the label in the recycled view
            itemView = view
        }
        
        return itemView
    }
    
    
}
