//
//  ForgotPasswordViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 18/09/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var closeButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var emailMobileTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.cornerRadius = 6.0
        submitButton.layer.borderColor  = UIColor.clearColor().CGColor
        submitButton.layer.borderWidth  = 1.0
        submitButton.layer.masksToBounds = false
        
        emailMobileTextField.delegate   =   self
        
        
        let closeImage = UIImage.init(named: "close")
        closeButton.setImage(changeColor(.groupTableViewBackgroundColor(), ofImage: closeImage!), forState: .Normal)
        
        closeButton.addTarget(self, action: #selector(closeVC), forControlEvents: .TouchUpInside)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func closeVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
