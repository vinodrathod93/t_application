//
//  LoginViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 17/09/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: TMTextField!
    @IBOutlet weak var passwordTextfield: TMTextField!
    
    @IBOutlet weak var scrollView: TPKeyboardAvoidingScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        
        
        passwordTextfield.rightView =   ForgotButton()
        passwordTextfield.rightViewMode =   .Always
        
        createAccountButton .setAttributedTitle(attributedCreateAccountButton(), forState: .Normal)
        
        loginButton.layer.cornerRadius = 6.0
        loginButton.layer.borderColor  = UIColor.clearColor().CGColor
        loginButton.layer.borderWidth  = 1.0
        loginButton.layer.masksToBounds = false
        loginButton.addTarget(self, action: #selector(loginTapped(_:)), forControlEvents: .TouchUpInside)
        
        
        let closeImage = UIImage.init(named: "close")
        closeButton.setImage(changeColor(.groupTableViewBackgroundColor(), ofImage: closeImage!), forState: .Normal)
        
        
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var size = contentSizeOfView(contentView)
        
        size.height += 25
        
        scrollView.contentSize  = size
        
        scrollView.frame    =   CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        
    }
    
    func ForgotButton() -> UIButton {
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        
        let forgotImage = UIImage.init(named: "forgot_password")
        
        
        button.addTarget(self, action: #selector(forgotPasswordTapped(_:)), forControlEvents: .TouchUpInside)
        button.setImage(changeColor(UIColor.darkGrayColor(), ofImage: forgotImage!), forState: .Normal)
        button.imageView?.contentMode = .ScaleAspectFit
        
        
        
        return button
    }
    
    
    func forgotPasswordTapped(sender: UIButton) {
        let forgotPasswordVC    =   self.storyboard?.instantiateViewControllerWithIdentifier("forgotPasswordVC")
        
        presentViewController(forgotPasswordVC!, animated: true, completion: nil)
    }
    
    
    func loginTapped(button: AnyObject) {
        
        
        
        
        
        let loginString =  "http://ec2-35-154-7-228.ap-south-1.compute.amazonaws.com/api/auth/login"
        
        
        let indicatorView   =   UIActivityIndicatorView.init(activityIndicatorStyle: .WhiteLarge)
        indicatorView.center    =   self.view.center
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        self.view.addSubview(indicatorView)
        
        
        let parameter   =   ["email" : self.emailTextfield.text!, "password" : self.passwordTextfield.text!]
        
        Alamofire.request(.POST, loginString, parameters: parameter, encoding: .URL, headers: nil).responseJSON { (response) in
            
            indicatorView.stopAnimating()
            
            
            
            switch response.result {
                case .Success:
                    if let JSON =   response.result.value {
                        print("\(JSON)")
                        
                        
                        let  statusCode =   JSON["code"] as! Int
                        
                        if statusCode == 200 {
                            let homeVC  =   self.storyboard?.instantiateViewControllerWithIdentifier("rootTMTabBarController")
                            
                            
                            let appDelegate =   UIApplication.sharedApplication().delegate as! AppDelegate
                            
                            appDelegate.window?.rootViewController = homeVC
                            
                            
                            saveUser(JSON["data"] as! NSDictionary)
                            
                            
                        }
                        else {
                            
                        }
                        
                        
                    }
                    
                case .Failure(let error):
                    print(error)
            }
            
        }
        
        
    }
    
    
}


func saveUser(data: NSDictionary) {
    let defaults    =   NSUserDefaults.standardUserDefaults()
    defaults.setObject(data["email"], forKey: "email")
    defaults.setObject(data["id"], forKey: "id")
    defaults.setObject(data["name"], forKey: "name");
    defaults.setObject(data["phone_number"], forKey: "phone")
    
    defaults.synchronize()
}




func attributedCreateAccountButton() -> NSAttributedString {
    
    let buttonString = "DON'T HAVE AN ACCOUNT? SIGNUP"
    
    
    let attributedString = NSAttributedString.init(string: "SIGNUP", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(10, weight: UIFontWeightLight)])
    
    let mutableAttributedString = NSMutableAttributedString.init(string: buttonString, attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
    
    let signupRange = (buttonString as NSString).rangeOfString("SIGNUP")
    
    mutableAttributedString.replaceCharactersInRange(signupRange, withAttributedString: attributedString)
    
    
    return mutableAttributedString
    
    
}
