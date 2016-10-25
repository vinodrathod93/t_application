//
//  WalletStatementViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 12/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class WalletStatementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CalendarViewDateDelegate {

    @IBOutlet weak var transactionCategoryButton: UIButton!
    @IBOutlet weak var fromDateButton: UIButton!
    @IBOutlet weak var toDateButton: UIButton!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var filterButtons: [UIButton]!
    @IBOutlet weak var showButton: UIButton!
    
    var isPendingStatement: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let closeBarButtonItem = UIBarButtonItem.init(title: "Close", style: .Done, target: self, action: #selector(dismissVC))
        
        navigationItem.leftBarButtonItem    =   closeBarButtonItem
        
        if !isPendingStatement {
            let walletButtonItem = UIBarButtonItem.init(title: convertToRupees("455"), style: .Done, target: self, action: #selector(pendingStatement))
            navigationItem.rightBarButtonItem   =   walletButtonItem
            
        }
        else {
            navigationItem.rightBarButtonItem   =   nil
            
            
            self.transactionCategoryButton.hidden = true
            
            
            let tempConstraint      =   NSLayoutConstraint.init(item: self.tableViewHeightConstraint.firstItem, attribute: self.tableViewHeightConstraint.firstAttribute, relatedBy: self.tableViewHeightConstraint.relation, toItem: self.tableViewHeightConstraint.secondItem, attribute: self.tableViewHeightConstraint.secondAttribute, multiplier: 1, constant: 0)
            
            NSLayoutConstraint.deactivateConstraints([self.tableViewHeightConstraint])
            NSLayoutConstraint.activateConstraints([tempConstraint])
            self.tableViewHeightConstraint =    tempConstraint
            
            UIView.animateWithDuration(0.33, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        
        
        
        // Do any additional setup after loading the view.
        
        fromDateButton.hidden   =   true
        toDateButton.hidden     =   true
        
        for button in self.filterButtons {
            button.hidden   =   true
            
            button.addTarget(self, action: #selector(self.filterButtonTapped(_:)), forControlEvents: .TouchUpInside)
        }
        
        
        
        
        showButton.layer.cornerRadius = 8
        showButton.layer.borderColor     =   UIColor.whiteColor().CGColor
        showButton.layer.borderWidth     =   1.0
        showButton.hidden   =   true
        
        transactionCategoryButton.layer.cornerRadius = 8
        transactionCategoryButton.layer.borderColor     =   UIColor.whiteColor().CGColor
        transactionCategoryButton.layer.borderWidth     =   1.0
        transactionCategoryButton.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20)
        transactionCategoryButton.addTarget(self, action: #selector(transactionCategoryTapped(_:)), forControlEvents: .TouchUpInside)
        
        fromDateButton.addTarget(self, action: #selector(fromDateTapped(_:)), forControlEvents: .TouchUpInside)
        toDateButton.addTarget(self, action: #selector(toDateTapped(_:)), forControlEvents: .TouchUpInside)
        
        self.view.backgroundColor   =   UIColor.blackColor()
        tableView.backgroundColor   =   .blackColor()
        
        tableView.delegate      =   self
        tableView.dataSource    =   self
        
    }
    
    
    
    func pendingStatement() {
        
        let statementVC = storyboard?.instantiateViewControllerWithIdentifier("walletStatementVC") as! WalletStatementViewController
        statementVC.title  =   "Pending Statement"
        statementVC.isPendingStatement  =   true
        let navigationController = UINavigationController.init(rootViewController: statementVC)
        
        
        presentViewController(navigationController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func fromDateTapped(sender: UIButton) {
        
        let calendarVC = storyboard?.instantiateViewControllerWithIdentifier("calendarVC") as! CalendarViewController
        calendarVC.delegate = self
        
        presentViewController(calendarVC, animated: true, completion: nil)
        
        
    }
    
    
    func toDateTapped(sender: UIButton) {
        
        let calendarVC = storyboard?.instantiateViewControllerWithIdentifier("calendarVC") as! CalendarViewController
        calendarVC.delegate = self
        calendarVC.isToDate = true
        
        presentViewController(calendarVC, animated: true, completion: nil)
        
        
    }
    
    
    func transactionCategoryTapped(sender: UIButton) {
        
        let alertController = UIAlertController.init(title: "", message: "", preferredStyle: .ActionSheet)
        
        let allAction = UIAlertAction.init(title: "All", style: .Default) { (_) in
            
            self.transactionCategoryButton.setTitle("All Transactions", forState: .Normal)
            
            
            
            let tempConstraint      =   NSLayoutConstraint.init(item: self.tableViewHeightConstraint.firstItem, attribute: self.tableViewHeightConstraint.firstAttribute, relatedBy: self.tableViewHeightConstraint.relation, toItem: self.tableViewHeightConstraint.secondItem, attribute: self.tableViewHeightConstraint.secondAttribute, multiplier: 0.85, constant: 0)
            
            NSLayoutConstraint.deactivateConstraints([self.tableViewHeightConstraint])
            NSLayoutConstraint.activateConstraints([tempConstraint])
            self.tableViewHeightConstraint =    tempConstraint
            
            self.fromDateButton.hidden  =   true
            self.toDateButton.hidden    =   true
            self.showButton.hidden      = true
            self.isPendingStatement = false
            
            
            for button in self.filterButtons {
                button.hidden   =   true
            }
            
            UIView.animateWithDuration(0.33, animations: { 
                self.view.layoutIfNeeded()
                }, completion: { (_) in
                    self.tableView.reloadSections(NSIndexSet.init(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)

            })
            
            
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        let periodAction = UIAlertAction.init(title: "Period", style: .Default) { (_) in
            
            self.transactionCategoryButton.setTitle("Period Transactions", forState: .Normal)
            
            let tempConstraint      =   NSLayoutConstraint.init(item: self.tableViewHeightConstraint.firstItem, attribute: self.tableViewHeightConstraint.firstAttribute, relatedBy: self.tableViewHeightConstraint.relation, toItem: self.tableViewHeightConstraint.secondItem, attribute: self.tableViewHeightConstraint.secondAttribute, multiplier: 0.72, constant: 0)
            NSLayoutConstraint.deactivateConstraints([self.tableViewHeightConstraint])
            NSLayoutConstraint.activateConstraints([tempConstraint])
            self.tableViewHeightConstraint =    tempConstraint
            
            
            
            UIView.animateWithDuration(0.33, animations: { 
                self.view.layoutIfNeeded()
                }, completion: { (_) in
                    self.fromDateButton.hidden  =   false
                    self.toDateButton.hidden    =   false
                    self.isPendingStatement = false
                    
                    
//                    for button in self.filterButtons {
//                        button.hidden   =   false
//                    }
                    
                    self.showButton.hidden  =   false
                    
                    self.tableView.reloadSections(NSIndexSet.init(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)

            })
            
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        
        let pendingAction = UIAlertAction.init(title: "Pending", style: .Default) { (_) in
            self.transactionCategoryButton.setTitle("Pending Transactions", forState: .Normal)
            
            let tempConstraint      =   NSLayoutConstraint.init(item: self.tableViewHeightConstraint.firstItem, attribute: self.tableViewHeightConstraint.firstAttribute, relatedBy: self.tableViewHeightConstraint.relation, toItem: self.tableViewHeightConstraint.secondItem, attribute: self.tableViewHeightConstraint.secondAttribute, multiplier: 0.85, constant: 0)
            NSLayoutConstraint.deactivateConstraints([self.tableViewHeightConstraint])
            NSLayoutConstraint.activateConstraints([tempConstraint])
            self.tableViewHeightConstraint =    tempConstraint
            
            
            
            UIView.animateWithDuration(0.33, animations: {
                self.view.layoutIfNeeded()
                }, completion: { (_) in
                    self.fromDateButton.hidden  =   true
                    self.toDateButton.hidden    =   true
                    
                    self.showButton.hidden  =   true
                    
                    self.isPendingStatement = true
                    self.tableView.reloadSections(NSIndexSet.init(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)

            })
            
            
            
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        
        alertController.addAction(allAction)
            alertController.addAction(periodAction)
        alertController.addAction(pendingAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func filterButtonTapped(sender: UIButton) {
        
        sender.selected = !sender.selected
        
        if sender.selected {
            sender.setTitleColor(.whiteColor(), forState: .Normal)
        }
        else {
            sender.setTitleColor(self.view.tintColor, forState: .Normal)
        }
    }

    
    func calendarDateSelected(date: NSDate) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        
        let string = dateFormatter.stringFromDate(date)
        
        
        self.fromDateButton.setTitle(string, forState: .Normal)
        self.fromDateButton.selected = true
    }
    
    
    
    func calendarToDateSelected(date: NSDate) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        
        let string = dateFormatter.stringFromDate(date)
        
        
        self.toDateButton.setTitle(string, forState: .Normal)
        self.toDateButton.selected = true
    }
    
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("walletTransactionCellIdentifier", forIndexPath: indexPath) as! WalletTableViewCell
        
        if self.isPendingStatement {
            cell.dayWidthConstraint.constant    =   60
        }
        else {
            cell.dayWidthConstraint.constant =   0
        }
        
        cell.layoutIfNeeded()
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 50))
        view.backgroundColor    =   UIColor.blackColor()
        
        
        let date = UILabel.init(frame: CGRect.init(x: 8, y: 10, width: 75, height: 30))
        date.text   =   "Date"
        date.textAlignment  =   .Center
        date.font   =   UIFont.systemFontOfSize(15)
        date.textColor  =   .greenColor()
        view.addSubview(date)
        
        
        if self.isPendingStatement {
            let amount = UILabel.init(frame: CGRect.init(x: self.view.frame.width - 68 + 16 - 60, y: 10, width: 60, height: 30))
            amount.text =   "Amount"
            amount.font   =   UIFont.systemFontOfSize(15)
            amount.textAlignment    =   .Center
            amount.textColor  =   .greenColor()
            view.addSubview(amount)
            
            let day = UILabel.init(frame: CGRect.init(x: self.view.frame.width - 68 + 16, y: 10, width: 60, height: 30))
            day.text =   "Day"
            day.font   =   UIFont.systemFontOfSize(15)
            day.textAlignment    =   .Center
            day.textColor  =   .greenColor()
            view.addSubview(day)
            
            let activity = UILabel.init(frame: CGRect.init(x: -20, y: 10, width: view.frame.width, height: 30))
            activity.text =   "Activity"
            activity.font   =   UIFont.systemFontOfSize(15)
            activity.textAlignment    =   .Center
            activity.textColor  =   .greenColor()
            view.addSubview(activity)
            
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.whiteColor().CGColor
        }
        else {
            
            let amount = UILabel.init(frame: CGRect.init(x: self.view.frame.width - 68 - 8, y: 10, width: 60, height: 30))
            amount.text =   "Amount"
            amount.font   =   UIFont.systemFontOfSize(15)
            amount.textAlignment    =   .Center
            amount.textColor  =   .greenColor()
            view.addSubview(amount)
            
            
            let activity = UILabel.init(frame: CGRect.init(x: 0, y: 10, width: view.frame.width, height: 30))
            activity.text =   "Activity"
            activity.font   =   UIFont.systemFontOfSize(15)
            activity.textAlignment    =   .Center
            activity.textColor  =   .greenColor()
            view.addSubview(activity)
            
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.whiteColor().CGColor
            
        }
        
        
        
        
        
        
        return view
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.isPendingStatement {
            return 0
        }
        else {
            return 50
        }
    
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let amount = UILabel.init(frame: CGRect.init(x:  8, y: 0, width: self.view.frame.width, height: 50))
        amount.text =   "Export"
        amount.font   =   UIFont.systemFontOfSize(15)
        amount.textAlignment    =   .Center
        amount.textColor  =   .greenColor()
        
        
        return amount
    }

}
