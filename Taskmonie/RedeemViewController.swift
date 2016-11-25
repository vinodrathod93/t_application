//
//  RedeemViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 24/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class RedeemViewController: UIViewController {

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var segmentedView: UISegmentedControl!
    
    var rechargeView = RechargeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let closeBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "close"), style: .Plain, target: self, action: #selector(dismissVC))
        
        navigationItem.leftBarButtonItem    =   closeBarButtonItem
        navigationItem.backBarButtonItem    =   UIBarButtonItem.init(title: "", style: .Done, target: nil, action: nil)
        
        
        let walletButtonItem = UIBarButtonItem.init(title: convertToRupees("455"), style: .Done, target: self, action: #selector(walletViewVC))
        navigationItem.rightBarButtonItem   =   walletButtonItem
        
        
        drawVoucherView()
        drawTransferView()
        drawRechargeView()
        
        
        
        segmentedView.addTarget(self, action: #selector(segmentControlTapped(_:)), forControlEvents: .ValueChanged)
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let view =  self.view.viewWithTag(3001)
        view!.layoutIfNeeded()
        
    }
    
    
    
    func dismissVC() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func walletViewVC() {
        
    }
    
    func proceedButtonTapped(button: UIButton) {
        let bankForm    =   self.storyboard?.instantiateViewControllerWithIdentifier("TranferBankFormVC")
        bankForm?.title =   "Transfer to Bank"
        self.navigationController?.pushViewController(bankForm!, animated: true)
    }
    
    
    func segmentControlTapped(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.viewWithTag(3001)?.hidden = false
            self.view.viewWithTag(3002)?.hidden = true
        case 1:
            self.view.viewWithTag(3001)?.hidden = true
            self.view.viewWithTag(3002)?.hidden = false
            
        default:
            self.view.viewWithTag(3001)?.hidden = true
            self.view.viewWithTag(3002)?.hidden = true
            self.view.viewWithTag(3003)?.hidden = false
        }
    }
    
    
    
    func drawRechargeView() {
        rechargeView = NSBundle.mainBundle().loadNibNamed("RechargeView", owner: self, options: nil)!.last as! RechargeView
        rechargeView.frame  =   CGRectMake(0, CGRectGetMaxY(segmentedView.frame), self.view.frame.width, self.view.frame.height-CGRectGetMaxY(segmentedView.frame))
        rechargeView.tag    =   3001
        
        self.view.addSubview(rechargeView)
        self.view.bringSubviewToFront(rechargeView)
        
    }
    
    func drawTransferView() {
        let transferView = TransferRewardView.init(frame: CGRectMake(0, CGRectGetMaxY(segmentedView.frame), self.view.frame.width, self.view.frame.height-CGRectGetMaxY(segmentedView.frame)))
        
        transferView.proceedButton.addTarget(self, action: #selector(proceedButtonTapped(_:)), forControlEvents: .TouchUpInside)
        transferView.tag    =   3002
        
        self.view.addSubview(transferView)
        self.view.bringSubviewToFront(transferView)
        
        transferView.layoutIfNeeded()
    }
    
    func drawVoucherView() {
        let voucherView = NSBundle.mainBundle().loadNibNamed("VoucherView", owner: self, options: nil)!.last as! VoucherView
        voucherView.frame  =   CGRectMake(0, CGRectGetMaxY(segmentedView.frame), self.view.frame.width, self.view.frame.height-CGRectGetMaxY(segmentedView.frame))
        voucherView.tag    =   3003
        
        self.view.addSubview(voucherView)
        self.view.bringSubviewToFront(voucherView)
    }

}
