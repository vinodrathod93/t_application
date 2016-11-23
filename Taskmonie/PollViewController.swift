//
//  PollViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 22/11/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit
import PNChart

class PollViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var graphView: PNBarChart!
    @IBOutlet weak var timerLabel: UILabel!
    
    var pollChoices: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pollChoices = [50, 60, 25, 80]
        

        graphView.frame     =   CGRectMake(0, 100, self.view.frame.size.width, graphView.frame.size.height)
        graphView.xLabels   = ["1", "2", "3", "4"]
        graphView.yValues   =   [50, 60, 25, 80]
        graphView.showLevelLine =   false
        graphView.showChartBorder   =   false
        graphView.showLabel         =   false
        
        graphView.strokeChart()
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.layoutIfNeeded()
//        graphView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*
    
    //MARK: GKBarGraphDataSource
    
    
    func numberOfBars() -> Int {
        return pollChoices.count
    }
    
    func valueForBarAtIndex(index: Int) -> NSNumber! {
        
        let value   =   pollChoices.objectAtIndex(index) as! Int
        
        return NSNumber(integer: value)
        
    }
    
    func colorForBarAtIndex(index: Int) -> UIColor! {
        return UIColor.blueColor()
    }
    
    func animationDurationForBarAtIndex(index: Int) -> CFTimeInterval {
//        CGFloat percentage = [[self valueForBarAtIndex:index] doubleValue];
//        percentage = (percentage / 100);
//        return (self.graphView.animationDuration * percentage);
        
        var percent =   self.valueForBarAtIndex(index).doubleValue
        percent     =   percent/100.0
        
        return self.graphView.animationDuration * percent
    }

    
    func titleForBarAtIndex(index: Int) -> String! {
        
        let number  =   pollChoices.objectAtIndex(index) as! NSNumber
        
        
        return String(number.integerValue)
    }
    
    func percentTitleForBarAtIndex(index: Int) -> String! {
        let number  =   pollChoices.objectAtIndex(index) as! NSNumber
        
        
        return String(number.integerValue)
    }
 
 */
}
