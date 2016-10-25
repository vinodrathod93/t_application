//
//  SignupViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 09/09/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    
    @IBOutlet var signupTextFields: [TMTextField]!
    
    @IBOutlet weak var scrollView: TPKeyboardAvoidingScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var termServicesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.layer.cornerRadius = 6.0
        signupButton.layer.borderColor  = UIColor.clearColor().CGColor
        signupButton.layer.borderWidth  = 1.0
        signupButton.layer.masksToBounds = false
        
        termServicesLabel.attributedText = tpAttributedString()
        
        closeButton.addTarget(self, action: #selector(closeVC), forControlEvents: .TouchUpInside)
        
        let closeImage = UIImage.init(named: "close")
        closeButton.setImage(changeColor(.groupTableViewBackgroundColor(), ofImage: closeImage!), forState: .Normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let contentSize = contentSizeOfView(contentView)
        
        scrollView.contentSize = contentSize
        
    }
    
    
    func closeVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
}

func tpAttributedString() -> NSAttributedString {
    let paragraph = NSMutableParagraphStyle.init()
    paragraph.alignment = .Center
    paragraph.lineSpacing = 3
    
    let string = "By Tapping Register you agree to have read and understood the {0} and {1} of TaskMonie."
    
    
    let attributedString = NSMutableAttributedString.init(string: string.uppercaseString, attributes: [
        NSForegroundColorAttributeName: UIColor.groupTableViewBackgroundColor()])
    
    let termsAttributedString = NSAttributedString.init(string: "TERMS OF USE", attributes: [
        NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
    let policyAttributedString = NSAttributedString.init(string: "PRIVACY POLICY", attributes: [
        NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
    
    let range0 = (attributedString.string as NSString).rangeOfString("{0}")
    if ((range0.location) != NSNotFound) {
        attributedString.replaceCharactersInRange(range0, withAttributedString: termsAttributedString)
        
    }
    
    
    let range1 = (attributedString.string as NSString).rangeOfString("{1}")
    if range1.location != NSNotFound {
        attributedString.replaceCharactersInRange(range1, withAttributedString: policyAttributedString)
    }
    
    attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSRange.init(location: 0, length: attributedString.length))
    
    return attributedString
    
}
