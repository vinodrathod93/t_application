//
//  InformationViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 25/11/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var proceedButton: UIButton!
    
    var instruInformation: String = ""
    var isPoll: Bool = false
    var isInformation: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        textView.text   =   instruInformation
        
        proceedButton.layer.cornerRadius    =   5.0
        proceedButton.layer.borderWidth     =   0.5
        
        if !isInformation {
            self.title  =   "Instruction"
            textView.text   =   instruInformation
            proceedButton.layer.borderColor     =   UIColor.whiteColor().CGColor
            
        }
        else {
            textView.font       =   UIFont.systemFontOfSize(16, weight: UIFontWeightThin)
            textView.textColor =   .whiteColor()
            proceedButton.setTitleColor(UIColor.greenColor(), forState: .Normal)
            proceedButton.layer.borderColor     =   UIColor.greenColor().CGColor
            proceedButton.backgroundColor       =   .clearColor()
        }
        
        
        

        textView.setContentOffset(CGPointZero, animated: false)

        
        proceedButton.addTarget(self, action: #selector(proceedButtonTapped), forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func proceedButtonTapped() {
        if isPoll {
            let pollVC  =   self.storyboard?.instantiateViewControllerWithIdentifier("pollQuestionVC")
            self.navigationController?.pushViewController(pollVC!, animated: true)
        }
    }
    

}
