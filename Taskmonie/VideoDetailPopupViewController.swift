//
//  VideoDetailPopupViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 24/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class VideoDetailPopupViewController: UITableViewController {

    var selectedIndex:Int = -1
    
    var aboutCompanyString: String = ""
    var aboutBrandString: String = ""
    var brandImageString: String = ""
    var taskName: String = ""
    
    
    convenience init(){
        self.init()
        
        self.title = taskName;
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextBtnDidTap)];
        self.contentSizeInPopup = CGSizeMake(300, 400);
        self.landscapeContentSizeInPopup = CGSizeMake(400, 200);
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title = taskName;
        self.contentSizeInPopup = CGSizeMake(300, 400);
        self.landscapeContentSizeInPopup = CGSizeMake(400, 200);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        self.tableView.backgroundColor = .blackColor()
        
        
        
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
        return 2
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("videodetailcellIdentifier", forIndexPath: indexPath) as! VideoDetailTableViewCell

        // Configure the cell...
        
        cell.nameLabel?.text = (indexPath.row == 0) ? "Company Details" : "Brand Details"
        cell.textView.text = (indexPath.row == 0) ? aboutCompanyString : aboutBrandString
        cell.textView.textColor = .whiteColor()
        
        if selectedIndex == indexPath.row {
            
            UIView.animateWithDuration(0.25, animations:{
                cell.expandImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            })
            
            
        }
        else {
            UIView.animateWithDuration(0.25, animations:{
                cell.expandImageView.transform = CGAffineTransformMakeRotation(0)
            })
            
        }
        

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedIndex = indexPath.row

        
        self.tableView.beginUpdates()
        
        for index in 0...1 {
            self.tableView.reloadRowsAtIndexPaths([NSIndexPath.init(forRow: index, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
        self.tableView.endUpdates()
        
        
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if selectedIndex == indexPath.row {
            return 200
        }
        else {
            return 44
        }
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView   =   UIImageView.init(frame: CGRectMake(0, 0, self.view.frame.width, 100))
        imageView.contentMode   =   .ScaleToFill
        
        imageView.image = UIImage.init(named: "cocacola")
        
        
        return imageView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
        
    }

}
