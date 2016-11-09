//
//  VoucherTableViewCell.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 05/11/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class VoucherTableViewCell: UITableViewCell {

    @IBOutlet weak var voucherImageView: UIImageView!
    @IBOutlet weak var voucherName: UILabel!
    @IBOutlet weak var voucherCategory: UILabel!
    @IBOutlet weak var voucherAmount: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 0.5
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        
        set(newframe){
            let inset: CGFloat = 2
            var frame   =   newframe
            frame.origin.x  +=  inset
            frame.size.width     -=  2*inset
            
            frame.origin.y  +=  inset
            frame.size.height   -=  2*inset
            
            super.frame     =   frame
        }
        
    }
    
}
