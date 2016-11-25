//
//  PollCompletionViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 25/11/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class PollCompletionViewController: UIViewController {

    @IBOutlet weak var successMessageLabel: UILabel!
    @IBOutlet weak var trackingIDLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    
    var answeredChoice: String = ""
    var trackingID: String = ""
    var rewardString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if !answeredChoice.isEmpty {
            successMessageLabel.text    =   "Your Answer '\(answeredChoice)' is Successfully Recorded"
        }
        
        
        if !trackingID.isEmpty {
            trackingIDLabel.text        =   "Tracking ID: \(trackingID)"
        }
        
        
        if !rewardString.isEmpty {
            rewardLabel.text            =   convertToRupees(rewardString)
        }
        
        
        
        var tempVCs: Array =   (self.navigationController?.viewControllers)!
        
        for viewcontroller in tempVCs {
            if viewcontroller.isKindOfClass(PollViewController) {
                
                let index = tempVCs.indexOf(viewcontroller)
                tempVCs.removeAtIndex(index!)
            }
            else if viewcontroller.isKindOfClass(InformationViewController) {
                let index = tempVCs.indexOf(viewcontroller)
                tempVCs.removeAtIndex(index!)
            }
        }
        
        self.navigationController?.viewControllers = tempVCs
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
