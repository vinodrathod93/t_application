
//
//  RedeemConfirmationViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 02/11/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class RedeemConfirmationViewController: UIViewController {
    
    
    
    
    
    
    @IBOutlet weak private var accountNumberLabel: UILabel!
    @IBOutlet weak private var bankNameLabel: UILabel!
    @IBOutlet weak private var branchAddressLabel: UILabel!
    @IBOutlet weak private var ifscCodeLabel: UILabel!
    @IBOutlet weak private var walletBalanceLabel: UILabel!
    @IBOutlet weak private var redeemingAmountLabel: UILabel!
    @IBOutlet weak private var totalCalcuatedLabel: UILabel!
    @IBOutlet weak private var convenienceChargeLabel: UILabel!
    @IBOutlet weak private var balanceCalcuatedLabel: UILabel!
    @IBOutlet weak private var confirmButton: UIButton!
    
    
    var accountNo: String = ""
    var bankName: String = ""
    var bankAddr: String = ""
    var ifsc: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.layoutIfNeeded()
        confirmButton.layer.cornerRadius    =   12.0
        
        self.accountNumberLabel.text    =   accountNo
        self.bankNameLabel.text         =   bankName
        self.branchAddressLabel.text    =   bankAddr
        self.ifscCodeLabel.text         =   ifsc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
