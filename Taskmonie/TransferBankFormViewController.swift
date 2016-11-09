//
//  TransferBankFormViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 26/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

enum TextFields: Int {
    case Banks = 0,
     State,
     City,
     Branch,
     IFSC,
     AccountType,
     AccountNumber,
     AccountHolderName,
     MobileNumber,
     Amount,
     Address
}

class TransferBankFormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var saveDetailsButton: UIButton!
    @IBOutlet weak var couponCodeButton: UIButton!
    @IBOutlet weak var proceedButton: UIButton!
    
    var dataArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArray   =   [["Central Bank", "State Bank"],["Maharashtra", "Karnataka", "Punjab"],["Mumbai", "Pune", "Nashik"],["Andheri", "Bandra", "Cuff Parade", "Bridge Candy"],[], ["Savings", "Current"], [],[],[],[],[]]
        

        // Do any additional setup after loading the view.
        
        self.navigationItem.backBarButtonItem   =   UIBarButtonItem.init(title: "", style: .Plain, target: nil, action: nil)
        
        proceedButton.backgroundColor   =   .redColor()
        proceedButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        proceedButton.layer.cornerRadius    =   12.0
        proceedButton.addTarget(self, action: #selector(proceedButtonTapped(_:)), forControlEvents: .TouchUpInside)

        
        couponCodeButton.addTarget(self, action: #selector(couponCodeTapped(_:)), forControlEvents: .TouchUpInside)
        
        
        
        
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem.init(title: "Done", style: .Done, target: self, action: #selector(dismissPickerView(_:)))
        
        let toolBar =   UIToolbar.init(frame: CGRectMake(0, 0, self.view.frame.width, 44))
        toolBar.items = [spaceButton, doneButton]
        
        
        
        
        
        
        for (index, textField) in textFields.enumerate() {
            
            switch index {
            case TextFields.Banks.rawValue, TextFields.State.rawValue, TextFields.City.rawValue, TextFields.Branch.rawValue, TextFields.AccountType.rawValue:
                let pickerView = UIPickerView.init()
                pickerView.delegate =   self
                pickerView.dataSource = self
                pickerView.tag  =   index
                
                textField.delegate = self
                textField.inputView = pickerView
                textField.inputAccessoryView = toolBar
                
                
            default:
                print("Default Nothing to do")
            }
        }
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func dismissPickerView(sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    
    // MARK: PickerView DataSource
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let currentArray    =   dataArray[pickerView.tag]
        
        return currentArray.count
    }
    
    
    // MARK: PickerView Delegate
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let currentArray    =  dataArray[pickerView.tag] as! Array<AnyObject>
        
        let currentString   =   currentArray[row] as! String
        
        return currentString
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let textfield   =   textFields[pickerView.tag]
        
        let currentArray    =  dataArray[pickerView.tag] as! Array<AnyObject>
        
        let currentString   =   currentArray[row] as! String
        
        textfield.text  =   currentString
    }

   
    
    // MARK: Action Methods
    
    func couponCodeTapped(sender: UIButton) {
        let alert   =   UIAlertController.init(title: "Add Coupon Code", message: "", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder   =   "Type Coupon Code"
            textField.textAlignment =   .Center;
            textField.autocapitalizationType      =   .AllCharacters;
        }
        
        let applyAction = UIAlertAction.init(title: "Apply", style: .Default) { (_) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .Cancel) { (_) in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alert.addAction(applyAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        for textfield in alert.textFields! {
            let container = textfield.superview
            let effectView  =   container?.superview?.subviews[0]
            
            if (effectView != nil && (effectView?.isKindOfClass(UIVisualEffectView))!) {
                container?.backgroundColor = .clearColor()
                effectView?.removeFromSuperview()
            }
        }
        
    }
    
    
    
    func proceedButtonTapped(sender: UIButton) {
        let confirmationVC  =   self.storyboard?.instantiateViewControllerWithIdentifier("redeemConfirmationVC") as! RedeemConfirmationViewController
        confirmationVC.title   =   "Transfer Details"
        confirmationVC.accountNo    =   textFields[TextFields.AccountNumber.rawValue].text!
        confirmationVC.bankName     =   textFields[TextFields.Banks.rawValue].text!
        confirmationVC.bankAddr     =   textFields[TextFields.Address.rawValue].text!
        confirmationVC.ifsc         =   textFields[TextFields.IFSC.rawValue].text!
        
        
        self.navigationController?.pushViewController(confirmationVC, animated: true)
    }
    
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let pickerView  = textField.inputView as! UIPickerView
        
        self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
    }

}
