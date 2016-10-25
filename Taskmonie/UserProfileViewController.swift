//
//  UserProfileViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 01/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    
    var hobbiesArray: NSMutableArray = []
    var userSelectedIndex = 0
    
    
    
    let mainArray = [
        [""      : ["Firstname", "Lastname", "Gender", "Date of Birth", "Marital Status"]],
                     
        [
        ""        : ["Chatting","Clubbing & Partying","Cooking", "Drawing","Painting or Sketch", "Farming / Gardening", "Fishing"],
        "Fitness"       : ["Aerobics", "Gym", "Gymnastics", "Karate", "Running", "Walking"],
        "Collections"   : ["Antiques", "Notes & Coins", "Pens", "PostCards", "Stamps"]
        ],
                     
        ["Business"     : ["Investor / Venture Capitalist", "Manufacturer", "Speculator","Distributor","Wholesaler","Retailer"],
        "Professional"  : ["Accountant / CA / CS","Advocate / Lawyer / Solicitor","Agent","Analyst","Doctor","Engineer","Freelancer","Government Employee","Student","Other"]]]
    
    
    var currentArray = [:]
    var currentKeys = NSMutableArray()
    var currentValues = NSMutableArray()
    
    var heightAtIndexPath = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closeBarButtonItem = UIBarButtonItem.init(title: "Close", style: .Done, target: self, action: #selector(dismissVC))
        
        navigationItem.leftBarButtonItem    =   closeBarButtonItem
        
        
        currentArray = mainArray[0]
        
        
        
        
        
        
        for (key,value) in currentArray {
            
            currentKeys .addObject(key)
            currentValues.addObject(value)
            
        }
        
        
        
        self.tableview.separatorStyle   =   UITableViewCellSeparatorStyle.None
        self.tableview.estimatedRowHeight   =   44.0
        self.tableview.rowHeight            =   UITableViewAutomaticDimension
        
        
        
        
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableview.reloadData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        if userSelectedIndex == 0 {
            let profileView = NSBundle.mainBundle().loadNibNamed("BasicProfileView", owner: self, options: nil).last as! BasicProfileView
            profileView.tag    =   2016
            
            profileView.frame  =   self.tableview.frame
            self.view.addSubview(profileView)
            self.view.bringSubviewToFront(profileView)
            
            profileView.layoutIfNeeded()
            
        }
        else {
            let profileview = self.view.viewWithTag(2016)
            
            profileview?.removeFromSuperview()
            
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    
    
    
    
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return currentValues.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tagListViewCellIdentifier", forIndexPath: indexPath) as? TagListTableViewCell
        
        cell?.tagArray  =   currentValues[indexPath.section] as! NSArray
        cell?.accessoryType =   UITableViewCellAccessoryType.None
        
        cell?.selectionStyle    =   UITableViewCellSelectionStyle.None
        cell?.layoutIfNeeded()
        
        return cell!
    }
    

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return currentKeys[section] as? String
    }
    
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == currentValues.indexOfObject(currentValues.lastObject!) {
            
            
            
            let headerView  =   UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 150))
            
            let updateButton    =   UIButton.init(frame: CGRect.init(x: CGRectGetMidX(self.view.frame) - 120/2, y: 70, width: 120, height: 40))
            updateButton.setTitle("UPDATE", forState: .Normal)
            updateButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            updateButton.layer.cornerRadius =   20
            updateButton.layer.borderColor      =   UIColor.whiteColor().CGColor
            updateButton.layer.borderWidth      =   1
            updateButton.addTarget(self, action: #selector(updateButtonTapped(_:)), forControlEvents: .TouchUpInside);
            
            
            headerView.addSubview(updateButton)
            
            return headerView
        }
        else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == currentValues.indexOfObject(currentValues.lastObject!) {
            return 150
        }
        else {
            return 0
        }
    }

    
    
    
    
    
    
    
    @IBAction func segmentControlChanged(sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        
        userSelectedIndex   =   index
        
        
        
        
        if index == 0 {
            
            if self.view.viewWithTag(2016) == nil {
                let profileView = NSBundle.mainBundle().loadNibNamed("BasicProfileView", owner: self, options: nil).last as! BasicProfileView
                profileView.tag    =   2016
                
                profileView.frame  =   self.tableview.frame
                self.view.addSubview(profileView)
                self.view.bringSubviewToFront(profileView)
                
                
                
                
                profileView.layoutIfNeeded()
            }
            
            
            
            self.view.layoutIfNeeded()
            
        }
        else {
            
            let profileview = self.view.viewWithTag(2016)
            
            profileview?.removeFromSuperview()
            
            self.view.layoutIfNeeded()
        }
        
        
        
        
        
        
        
        
        currentArray    =   self.mainArray[index]
        
        currentKeys.removeAllObjects()
        currentValues.removeAllObjects()
        
        for (key,value) in currentArray {
            
            currentKeys .addObject(key)
            currentValues.addObject(value)
            
        }
        
        
        
        let range  =   NSMakeRange(0, currentValues.count)
        
        
        self.tableview.reloadData()
        self.tableview.reloadSections(NSIndexSet.init(indexesInRange: range), withRowAnimation: UITableViewRowAnimation.Automatic)
        
    }
    
    
    func dismissVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func updateButtonTapped(sender: UIButton) {
        
    }
    
    
    
}
