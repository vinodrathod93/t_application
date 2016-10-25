//
//  TMTextField.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 11/09/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class TMTextField: JVFloatLabeledTextField {

    override func awakeFromNib() {
        let bottomLayer   =     CALayer()
        bottomLayer.frame   =   CGRect.init(x: 0, y: frame.height-0.5, width: frame.width, height: 0.5)
        bottomLayer.backgroundColor = UIColor.groupTableViewBackgroundColor().CGColor
        layer.addSublayer(bottomLayer)
        
        
        attributedPlaceholder    =   NSAttributedString.init(string: placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
        textColor           =   UIColor.whiteColor()
        floatingLabelTextColor =    UIColor.groupTableViewBackgroundColor()
        floatingLabelYPadding   =   5.0
        floatingLabelTextColor  =   UIColor.lightGrayColor()
        
        keyboardAppearance      =   .Dark
    }
}
