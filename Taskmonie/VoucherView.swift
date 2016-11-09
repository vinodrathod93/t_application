//
//  VoucherView.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 05/11/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit
import STPopup

class VoucherView: UIView, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var vouchersArray: NSArray = []
    var filterArray: NSArray = []
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        vouchersArray   =   [["name" : "Amazon", "image": "amazon", "amount" : "100", "category": "Shopping", "offer": 0], ["name" : "FreeCharge", "image": "freecharge", "amount" : "200", "category": "Wallet", "offer": 1], ["name" : "Snapdeal", "image": "snapdeal", "amount" : "170", "category": "Shopping", "offer": 0]]
        
        
        searchBar.delegate = self
        
        
        self.tableView.registerNib(UINib.init(nibName: "VoucherTableViewCell", bundle: nil), forCellReuseIdentifier: "voucherCellIdentifier")
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VoucherView.dismissKeyboard))
        
        self.addGestureRecognizer(tap)
        
        filterArray   =   ["Name", "Discount", "Popular", "Value"]
        filterButton.addTarget(self, action: #selector(filterButtonTapped(_:)), forControlEvents: .TouchUpInside)
    }
    
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    
    //MARK: UITableViewDelegate
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vouchersArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("voucherCellIdentifier") as! VoucherTableViewCell
        
        
        let dictionary = vouchersArray[indexPath.row] as! NSDictionary
        cell.voucherName.text       =   dictionary["name"] as? String
        cell.voucherCategory.text   =   dictionary["category"] as? String
        cell.voucherAmount.text     =   convertToRupees(dictionary["amount"] as! String)
        cell.voucherImageView.image =   UIImage.init(named: dictionary["image"] as! String)
        cell.infoButton.addTarget(self, action: #selector(voucherDetailButtonTapped(_:)), forControlEvents: .TouchUpInside)
        
        let offer: Bool =   (dictionary["offer"]?.boolValue)!
        
        if offer {
            cell.offerLabel.hidden =   false
        }
        else {
            cell.offerLabel.hidden =   true
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }

    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.endEditing(true)
    }
    
    
    
    func voucherDetailButtonTapped(button: UIButton) {
        
        let storyboard  =   UIStoryboard.init(name: "Main", bundle: nil)
        let detailVC    =   storyboard.instantiateViewControllerWithIdentifier("videoDetailPopupVC")
        let popupView = STPopupController.init(rootViewController: detailVC)
        popupView.containerView.layer.cornerRadius = 6.0;
        popupView.containerView.layer.borderWidth = 1;
        popupView.containerView.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        
        
        popupView.presentInViewController(self.topViewController())
        
    }
    
    
    func filterButtonTapped(button: UIButton) {
        
        let alertViewController = UIAlertController.init(title: "Sort By", message: "", preferredStyle: .ActionSheet)
        
        
        for filter in filterArray {
            let alertAction =   UIAlertAction.init(title: filter as? String, style: .Default, handler: { (_) in
                
                self.filterButton.setTitle(filter as? String, forState: .Normal)
                alertViewController.dismissViewControllerAnimated(true, completion: nil)
            })
            
            alertViewController.addAction(alertAction)
        }
        
        
        self.topViewController().presentViewController(alertViewController, animated: true, completion: nil)
    }
    
    
    func topViewController() -> UIViewController {
        var topVC = UIApplication.sharedApplication().keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
        }
        
        return topVC!
    }
    
    
    //MARK: UISearchBarDelegate
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
    }
    
    
    
}
