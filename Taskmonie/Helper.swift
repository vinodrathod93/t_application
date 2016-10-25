//
//  Helper.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 05/09/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import Foundation
import UIKit


func convertToRupees(value: String) -> String {
    let numberFormatter =   NSNumberFormatter.init()
    numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
    numberFormatter.locale = NSLocale.init(localeIdentifier: "en_IN")
    numberFormatter.maximumFractionDigits = 0
    
    return numberFormatter.stringFromNumber(NSNumber.init(integer: Int(value)!))!
    
}

//static CGSize contentSizeOfView(UIView *contentView) {
//    int lastViewY = CGRectGetMaxY(((UIView *)[contentView.subviews lastObject]).frame);
//    
//    CGFloat height = SCROLLVIEW_BOTTOM_SPACE + lastViewY;
//    
//    return CGSizeMake(CGRectGetWidth(contentView.frame), height);
//}

func contentSizeOfView(view: UIView) -> CGSize {
    
    let lastViewY = CGRectGetMaxY((view.subviews.last?.frame)!)
    
    let height = lastViewY+20
    
    return CGSize.init(width: CGRectGetWidth(view.frame), height: height)
    
}


func imageFromColor(color: UIColor) -> UIImage {
    let rect = CGRect.init(x: 0, y: 0, width: 2.0, height: 0.5)
    UIGraphicsBeginImageContext(rect.size)
    
    let context =   UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
    
}


func changeColor(color: UIColor, ofImage: UIImage) -> UIImage? {
    var image = ofImage.imageWithRenderingMode(.AlwaysTemplate)
    UIGraphicsBeginImageContextWithOptions(ofImage.size, false, ofImage.scale)
    color.set()
    image.drawInRect(CGRect(x: 0, y: 0, width: ofImage.size.width, height: ofImage.size.height))
    image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}
