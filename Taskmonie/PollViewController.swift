//
//  PollViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 22/11/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class PollViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerInstructionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    var pollChoices: [Int]!
    var choices: [String]!
    
    var count = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pollChoices = [50, 60, 25, 80]
        
        
        tableView.delegate          =   self
        tableView.dataSource        =   self
        tableView.backgroundColor   =   .blackColor()
        
        
        timerLabel.text         =   "00:00"
        
        
        doneButton.layer.cornerRadius   =   5.0
        doneButton.layer.borderColor    =   UIColor.whiteColor().CGColor
        doneButton.layer.borderWidth    =   0.5
        doneButton.addTarget(self, action: #selector(doneButtonTapped), forControlEvents: .TouchUpInside)
        doneButton.setTitleColor(.whiteColor(), forState: .Normal)
        doneButton.hidden               =   true
        
        
        choices = ["AUS", "NZ", "SA", "IND"]
        
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)

    }
    
    
  
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: UITableViewDelegate
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell    =   tableView.dequeueReusableCellWithIdentifier("pollChoiceCellIdentifier", forIndexPath: indexPath) as! PollChoiceTableViewCell
        
        cell.selectionStyle     =   .None
        cell.backgroundColor    =   .blackColor()
        
        
        let choice  =   choices[indexPath.row]
        cell.choiceLabel.text   =   choice
        cell.choiceLabel.textColor = .whiteColor()
        
        cell.currentStatus.text     =   "\(pollChoices[indexPath.row])%"
        cell.currentStatus.hidden   =   true
        
        return cell
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        
        
        
        var i = 0
        
        for _ in pollChoices {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: i, inSection: 0)) as! PollChoiceTableViewCell
            
            cell.choiceLabel.textAlignment  =   .Center
            cell.currentStatus.hidden       =   false
            
            
            
            
            
            
            
            let statusValue =   pollChoices[i]
            
            var frame   =   cell.frame
            
            
            frame.size.width    =   frame.size.width * (CGFloat(statusValue)/100.0)
            frame.origin.x      =   0
            
            let background      =   UIView.init(frame: cell.bounds)
            cell.backgroundView     =   background
            
            
            let bar              =   UIView.init(frame: CGRectMake(0, 0, 0, frame.size.height))
            print(NSStringFromCGRect(bar.frame))
            bar.backgroundColor  =   self.view.tintColor
            
            background.addSubview(bar)
            
            
            UIView.animateWithDuration(0.33, animations: { 
                bar.frame   =   CGRectMake(0, 0, frame.size.width, frame.size.height)
            })
            
            
            if i == indexPath.row {
                cell.choiceLabel.textColor  =   .greenColor()
                cell.choiceLabel.font       =   UIFont.systemFontOfSize(18, weight: UIFontWeightBold)
                
                cell.currentStatus.textColor    =   .whiteColor()
                cell.currentStatus.font         =   UIFont.systemFontOfSize(16, weight: UIFontWeightThin)
            }
            
            
            
            
            i += 1
        }
        
        
        tableView.userInteractionEnabled    =   false
        timerInstructionLabel.hidden        =   true
        timerLabel.hidden   =   true
        doneButton.hidden   =   false
        

    }
    
    
    
    func doneButtonTapped() {
        let pollCompletionVC   =   self.storyboard?.instantiateViewControllerWithIdentifier("pollCompletionVC") as! PollCompletionViewController
        pollCompletionVC.rewardString   =   "6"
        pollCompletionVC.answeredChoice =   ""
        
        
        self.navigationController?.pushViewController(pollCompletionVC, animated: true)
    }
    
    
    func update() {
        
        if(count > 0){
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            timerLabel.text = minutes + ":" + seconds
            count -= 1
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    /*
    func setupBarLineChartView(chartView: HorizontalBarChartView) {
        
        
        chartView.drawGridBackgroundEnabled =   false
        chartView.dragEnabled               =   false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled          =   false
        chartView.leftAxis.enabled          =   false
        chartView.rightAxis.enabled         =   false
        chartView.leftAxis.drawZeroLineEnabled  = false
        
        chartView.drawValueAboveBarEnabled  =   false
        
        
        let xAxis                           =   chartView.xAxis
        xAxis.gridLineWidth                 =   0.5
        xAxis.gridColor                     =   .whiteColor()
        xAxis.axisLineColor                 =   .clearColor()
        xAxis.labelFont                     =   UIFont.systemFontOfSize(15, weight: UIFontWeightHeavy)
        xAxis.labelTextColor                =   .blueColor()
        
        
        

    }
    
    */
    
    
    /*
     
     func setCharts(dataPoints: [String], values: [Double]) {
     
     graphView.noDataText = "Currently No Polls."
     
     var dataEntries: [BarChartDataEntry] = []
     
     for i in 0..<dataPoints.count {
     let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
     dataEntries.append(dataEntry)
     }
     
     let chartDataSet            =   BarChartDataSet(yVals: dataEntries, label: "")
     let chartData               =   BarChartData(xVals: months, dataSet: chartDataSet)
     
     
     graphView.data              =   chartData
     graphView.descriptionText   =   ""
     
     chartDataSet.colors         =   [.blueColor()]
     chartDataSet.valueFont      =   UIFont.systemFontOfSize(15, weight: UIFontWeightThin)
     chartDataSet.valueColors    =   [.whiteColor()]
     
     
     graphView.xAxis.labelPosition = .Bottom
     graphView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)
     
     
     }
     */
    
    
//    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
//        print("\(entry.value) in \(months[entry.xIndex])")
//    }
    
    
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
