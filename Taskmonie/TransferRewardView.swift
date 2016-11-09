//
//  TransferRewardView.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 25/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class TransferRewardView: UIView {

    
    var buttons: NSArray = []
    
    
    var bank: UIButton!
    var another: UIButton!
    var wallet: UIButton!
    
    var proceedButton: UIButton!
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        bank    =   UIButton.init(frame: CGRectMake(10, 20, self.frame.width-(2*10), 30))
        bank.contentHorizontalAlignment = .Left
        bank.setTitle("Transfer To Bank Account", forState: .Normal)
        bank.setImage(UIImage.init(named: "deselect"), forState: .Normal)
        bank.setImage(UIImage.init(named: "select"), forState: .Selected)
        bank.addTarget(self, action: #selector(buttonTapped(_:)), forControlEvents: .TouchUpInside)
        bank.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        self.addSubview(bank)
        
        another = UIButton.init(frame: CGRectMake(10, CGRectGetMaxY(bank.frame) + 10, bank.frame.width, 30))
        another.contentHorizontalAlignment = .Left
        another.setImage(UIImage.init(named: "deselect"), forState: .Normal)
        another.setImage(UIImage.init(named: "select"), forState: .Selected)
        another.setTitle("Transfer To Other User", forState: .Normal)
        another.addTarget(self, action: #selector(buttonTapped(_:)), forControlEvents: .TouchUpInside)
        another.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        self.addSubview(another)
        
        wallet  =   UIButton.init(frame: CGRectMake(10, CGRectGetMaxY(another.frame) + 10, another.frame.width, 30))
        wallet.setImage(UIImage.init(named: "deselect"), forState: .Normal)
        wallet.setImage(UIImage.init(named: "select"), forState: .Selected)
        wallet.contentHorizontalAlignment = .Left
        wallet.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        wallet.addTarget(self, action: #selector(buttonTapped(_:)), forControlEvents: .TouchUpInside)
        wallet.setTitle("Transfer To Other Wallet", forState: .Normal)
        self.addSubview(wallet)
        
        
        proceedButton   =   UIButton.init(frame: CGRectMake(0, CGRectGetMaxY(wallet.frame) + 35, 110, 40))
        proceedButton.center.x  =   self.center.x
        proceedButton.setTitle("PROCEED", forState: .Normal)
        proceedButton.backgroundColor = UIColor.redColor()
        proceedButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        proceedButton.layer.cornerRadius = 12.0;
        self.addSubview(proceedButton)
        
        
        buttons = [bank, another, wallet]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        
    }
    
    
    func buttonTapped(button: UIButton) {
        
        
        for case let tempButton as UIButton in buttons {
            if tempButton == button {
                tempButton.selected = true
            }
            else {
                tempButton.selected = false
            }
        }
        
    }
    
    
    

}
