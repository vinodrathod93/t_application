//
//  ProfileSideMenuViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 06/09/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class ProfileSideMenuViewController: UITableViewController {

    let profileMenus = ["Wallet Statement", "Redeem", "Notifications", "How it Works?", "FAQ"]
    let profileMenuIcons = ["transactions", "redeem", "notification", "works", "faq"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blackColor()
        
        navigationController?.navigationBar.barStyle    =   .Black
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (section == 0) ? 1 : profileMenus.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = indexPath.section == 0 ? "profileIntroCellIdentifier" : "profileMenuCellIdentifier";
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        cell.backgroundColor    =   .clearColor()
        cell.textLabel?.textColor   =   .whiteColor()
        
        if indexPath.section == 0 {
            let profileCell = cell as! ProfileIntroViewCell
            
            
            profileCell.userImageView.image = UIImage.init(named: "wonderWoman")
            profileCell.userImageView.contentMode = UIViewContentMode.ScaleAspectFill
            profileCell.userImageView.clipsToBounds = true
            profileCell.backgroundColor =   UIColor.lightGrayColor()
            
            profileCell.userImageView.layer.borderColor = UIColor.blackColor().CGColor
            profileCell.userImageView.layer.borderWidth = 1.5
            profileCell.userImageView.layer.cornerRadius    =   8
            
        }
        else {
            cell.textLabel?.text    = profileMenus[indexPath.row]
//            cell.textLabel?.font    = UIFont.systemFontOfSize(18, weight: UIFontWeightSemibold)
            
            let image = UIImage.init(named: profileMenuIcons[indexPath.row])
            cell.imageView?.image   =  changeColor(UIColor.whiteColor(), ofImage: image!)
        }
        
        
        return cell
    }
    
    
    // MARK: - Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            let userProfileVC = storyboard?.instantiateViewControllerWithIdentifier("userProfileVC")
            
            let navigationController = UINavigationController.init(rootViewController: userProfileVC!)
            
            presentViewController(navigationController, animated: true, completion: nil)
        }
        else if(indexPath.section == 1 && indexPath.row == 0) {
            let statementVC = storyboard?.instantiateViewControllerWithIdentifier("walletStatementVC")
            statementVC?.title  =   "Wallet Statement"
            let navigationController = UINavigationController.init(rootViewController: statementVC!)
            
            
            presentViewController(navigationController, animated: true, completion: nil)
            
        }
        else if (indexPath.section == 1 && indexPath.row == 1) {
            let redeemVC    =   storyboard?.instantiateViewControllerWithIdentifier("redeemVC")
            let navigationController = UINavigationController.init(rootViewController: redeemVC!)
            
            presentViewController(navigationController, animated: true, completion: nil)
            
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 145
        }
        else {
            return 44
        }
    }

}
