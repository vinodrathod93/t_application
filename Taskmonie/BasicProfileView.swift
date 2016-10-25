//
//  BasicProfileView.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 23/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class BasicProfileView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.backgroundColor = .blackColor()
        self.contentView.backgroundColor = .blackColor()
        
        scrollView.scrollEnabled = true
        
        
        
        updateButton.layer.cornerRadius = self.updateButton.frame.height/2
        updateButton.layer.borderColor      =   UIColor.whiteColor().CGColor
        updateButton.layer.borderWidth      =   1
        
        changePasswordButton.layer.cornerRadius = self.changePasswordButton.frame.height/2
        changePasswordButton.layer.borderColor      =   UIColor.whiteColor().CGColor
        changePasswordButton.layer.borderWidth      =   1
    }
    
    
    
    
    override func drawRect(rect: CGRect) {
        scrollView.frame        =   CGRectMake(0, 0, self.frame.width, self.frame.height)
        scrollView.contentSize = contentSizeOfView(contentView)
        
        print(NSStringFromCGSize(scrollView.contentSize))
        
        
    }

}
