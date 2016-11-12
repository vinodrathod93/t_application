//
//  VideoCompletionViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 24/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class VideoCompletionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var tempVCs: Array =   (self.navigationController?.viewControllers)!
        
        for viewcontroller in tempVCs {
            if viewcontroller.isKindOfClass(VideoPlayerViewController) {
                
                let index = tempVCs.indexOf(viewcontroller)
                tempVCs.removeAtIndex(index!)
            }
            else if viewcontroller.isKindOfClass(SurveyViewController) {
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
