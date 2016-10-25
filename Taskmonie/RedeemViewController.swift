//
//  RedeemViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 24/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class RedeemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let closeBarButtonItem = UIBarButtonItem.init(title: "Close", style: .Done, target: self, action: #selector(dismissVC))
        navigationItem.leftBarButtonItem    =   closeBarButtonItem
        
        
        let walletButtonItem = UIBarButtonItem.init(title: convertToRupees("455"), style: .Done, target: self, action: #selector(walletViewVC))
        navigationItem.rightBarButtonItem   =   walletButtonItem
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

        func dismissVC() {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        func walletViewVC() {
            
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
