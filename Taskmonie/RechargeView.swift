//
//  RechargeView.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 05/11/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class RechargeView: UIView, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var applyPromoButton: UIButton!
    @IBOutlet weak var promoTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var operatorTF: UITextField!
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet var rechargeCategoryButtons: [UIButton]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    
    var promoCodeTapped: Bool = false
    var operatorsArray: NSArray = []
    
    override func awakeFromNib() {
       super.awakeFromNib()
        
        for button in rechargeCategoryButtons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), forControlEvents: .TouchUpInside)
        }
        
        rechargeCategoryButtons[0].selected = true
        
        let cancelButton = UIButton.init(type: .Custom)
        cancelButton.setTitle("APPLY", forState: .Normal)
        cancelButton.setTitleColor(.whiteColor(), forState: .Normal)
        cancelButton.backgroundColor = .redColor()
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        cancelButton.frame  =   CGRectMake(0, 0, 70, 30)
        
        promoTF.rightViewMode   =   .Always
        promoTF.rightView       =   cancelButton
        
        applyPromoButton.addTarget(self, action: #selector(promoCodeButtonTapped(_:)), forControlEvents: .TouchUpInside)
        
        
        numberTF.delegate = self
        amountTF.delegate   =   self
        
        self.operatorTF.rightViewMode = .Always
        
        
        
        operatorsArray = ["JIO", "TATA DOCOMO", "VODAFONE", "AIRTEL", "AIRCEL", "BSNL"]
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem.init(title: "Done", style: .Done, target: self, action: #selector(dismissPickerView(_:)))
        
        let toolBar =   UIToolbar.init(frame: CGRectMake(0, 0, self.frame.width, 44))
        toolBar.items = [spaceButton, doneButton]
        
        let pickerView = UIPickerView.init()
        pickerView.delegate =   self
        pickerView.dataSource = self
        operatorTF.inputView = pickerView
        operatorTF.inputAccessoryView = toolBar
    }
    
    
    override func drawRect(rect: CGRect) {
        
        
        var origin  =   promoTF.frame.origin
        origin.x  += self.frame.size.width
        promoTF.frame.origin = origin
        
        scrollView.frame    =   CGRectMake(0, 0, frame.size.width, frame.size.height)
        scrollView.contentSize = contentSizeOfView(self.contentView)
        
        
    }

    
    func dismissPickerView(sender: UIBarButtonItem) {
        self.endEditing(true)
    }
    
    
    func promoCodeButtonTapped(button: UIButton) {
        
        if !promoCodeTapped {
            
            
            UIView.animateWithDuration(0.23, animations: { 
                var origin  =   self.promoTF.frame.origin
                origin.x  -= self.frame.size.width
                self.promoTF.frame.origin = origin
            })
            
            
        }
        promoCodeTapped = true
    }
    
    
    
    func buttonTapped(button: UIButton) {
        
        for tempButton in rechargeCategoryButtons {
            if tempButton == button {
                tempButton.selected = true
            }
            else {
                tempButton.selected = false
            }
        }
        
    }
    
    
    
    
    //MARK: UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == self.numberTF {
            
            if textField.text!.characters.count > 4 {
                
                let cardImageview   =   UIImageView.init(image: UIImage.init(named: "docomo"))
                cardImageview.contentMode = .ScaleAspectFit
                cardImageview.frame =   CGRectMake(0, 2, 50, 26)
                
                self.operatorTF.text        =   "TATA DOCOMO"
                self.operatorTF.rightView   =   cardImageview
                
            }
            else {
                self.operatorTF.text        =   nil
                self.operatorTF.rightView   =   nil
            }
        }
        
        
        
        return true
    }
    
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == self.amountTF {
            
            let string = textField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.symbolCharacterSet())
            
            textField.text = convertToRupees(string!)
        }
    }
    
    
    
    // MARK: PickerView DataSource
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return operatorsArray.count
    }
    
    
    // MARK: PickerView Delegate
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        let currentString   =   operatorsArray[row] as! String
        
        return currentString
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        
        let currentString   =   operatorsArray[row] as! String
        
        operatorTF.text  =   currentString
        
        let cardImageview   =   UIImageView.init(image: UIImage.init(named: currentString))
        cardImageview.contentMode = .ScaleAspectFit
        cardImageview.frame =   CGRectMake(0, 2, 50, 26)
        operatorTF.rightView =  cardImageview
    }
    
}
