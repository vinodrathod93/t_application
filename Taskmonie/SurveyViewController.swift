//
//  SurveyViewController.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 08/11/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var instrucitonLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    
    
    var singleSelectionTableView = UITableView()
    var sliderView = UIView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title  =   "1/5"
        
        self.submitButton.layer.cornerRadius = 8.0
        self.submitButton.layer.borderColor = UIColor.init(red: 80/255.0, green: 255/255.0, blue: 39/255.0, alpha: 1.0).CGColor
        self.submitButton.layer.borderWidth = 0.8
        self.submitButton.addTarget(self, action: #selector(nextButtonTapped), forControlEvents: .TouchUpInside)
        
        
        self.instrucitonLabel.hidden = true
        
        
        
        
        
        singleSelectionView()
        sliderQuestionView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func nextButtonTapped() {
        
        /*
         
         viewObjB.alpha=1.0;
         viewObjB.hidden=NO;
         [UIView transitionWithView:viewObjB
         duration:1.5
         options:UIViewAnimationOptionTransitionFlipFromRight
         animations:^{
         viewObjB.hidden=YES;
         viewObjB.alpha=0.0;
         } completion:nil];
         
         viewObjC.alpha=0.0;
         viewObjC.hidden=YES;
         [UIView transitionWithView:viewObjC
         duration:1.5
         options:UIViewAnimationOptionTransitionFlipFromLeft
         animations:^{
         viewObjC.hidden=NO;
         viewObjC.alpha=1.0;
         } completion:nil];
 */
        
        self.title = "2/5"
        
        
        
        let labelAnimation  =   CATransition.init()
        labelAnimation.timingFunction   =   CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        labelAnimation.startProgress    =   0
        labelAnimation.endProgress      =   1
        labelAnimation.delegate =   self
        labelAnimation.type =   kCATransitionFade
        labelAnimation.fillMode =   kCAFillModeBoth
        labelAnimation.duration =   0.33
        
        self.questionLabel.layer.addAnimation(labelAnimation, forKey: kCATransitionFade)
        
        
        self.questionLabel.text = "How Much would you rate us for our Marketing strategies."
        
        /*
        UIView.transitionWithView(tableView, duration: 0.8, options: .TransitionFlipFromRight, animations: {
            self.tableView.hidden = true
            self.tableView.alpha = 0.0
            }, completion: nil)
        
        
        UIView.transitionWithView(sliderView, duration: 0.8, options: .TransitionFlipFromLeft, animations: {
            self.sliderView.hidden = false
            self.sliderView.alpha = 1.0
            }, completion: nil)
        */
        
        
        
        
//        let filter  =   CIFilter.init(name: "CIBarsSwipeTransition")
//        filter?.setValue(NSNumber(float: 3.14), forKey: "inputAngle")
//        filter?.setValue(NSNumber(float: 30.0), forKey: "inputWidth")
//        filter?.setValue(NSNumber(float: 10.0), forKey: "inputBarOffset")
        
        
        let transition  =   CATransition.init()
        transition.timingFunction   =   CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.startProgress    =   0
        transition.endProgress      =   1
        transition.delegate         =   self
        transition.type             =   kCATransitionPush
        transition.subtype          =   kCATransitionFromRight
        transition.duration         =   0.4
        
        self.singleSelectionTableView.layer.addAnimation(transition, forKey: kCATransitionPush)
        
        self.singleSelectionTableView.hidden       =   true
        self.singleSelectionTableView.alpha        =   0.0

        
        self.sliderView.layer.addAnimation(transition, forKey: kCATransitionPush)
        
        self.sliderView.hidden  =   false
        self.sliderView.alpha   =   1.0
        
        
        
    }
    
    
    
    func sliderQuestionView() {
        
        sliderView    =   UIView.init(frame: CGRectMake(0, 40, contentView.frame.width, 100))
        sliderView.backgroundColor = .blackColor()
        
        
        let slider = UISlider.init(frame: CGRectMake(10, 35, self.view.frame.width - 20, 10))
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.continuous = true
        slider.value = 0
        sliderView.addSubview(slider)
        
        
        let minLabel    =   UILabel.init(frame: CGRectMake(15, 0, 50, 15))
        minLabel.text   =   "0"
        minLabel.textColor = .whiteColor()
        sliderView.addSubview(minLabel)
        
        
        
        let maxLabel    =   UILabel.init(frame: CGRectMake(self.view.frame.width-30, 0, 50, 15))
        maxLabel.text   =   "30"
        maxLabel.textColor = .whiteColor()
        sliderView.addSubview(maxLabel)
        
        
        
        let minStatus    =   UILabel.init(frame: CGRectMake(15, 60, 50, 15))
        minStatus.text   =   "Bad"
        minStatus.textColor = .whiteColor()
        sliderView.addSubview(minStatus)
        
        
        
        let maxStatus    =   UILabel.init(frame: CGRectMake(self.view.frame.width-100, 60, 80, 15))
        maxStatus.text   =   "Excellent"
        maxStatus.textColor = .whiteColor()
        maxStatus.textAlignment =   .Right
        sliderView.addSubview(maxStatus)
        
        
        contentView.addSubview(sliderView)
        
        sliderView.hidden = true
        sliderView.alpha    = 0.0
    }
    

    func singleSelectionView() {
        
        
        
        singleSelectionTableView   =   UITableView.init(frame: CGRectMake(0, 0, contentView.frame.width, contentView.frame.height), style: .Grouped)
        
        singleSelectionTableView.backgroundColor   =   .clearColor()
        singleSelectionTableView.delegate = self
        singleSelectionTableView.dataSource = self
        singleSelectionTableView.tintColor  =  UIColor.blueColor()
        singleSelectionTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "questionOptionsCellIdentifier")
        
        contentView.backgroundColor =   .clearColor()
        contentView.addSubview(singleSelectionTableView)
        
        
    }
    
    
    
    // MARK: UITableView Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("questionOptionsCellIdentifier")
        
        
        if cell == nil
        {
            cell = UITableViewCell.init(style: .Subtitle, reuseIdentifier: "questionOptionsCellIdentifier")
        }
        
        cell!.backgroundColor   =   .clearColor()
        cell!.textLabel?.text   =   "EveryDay"
        cell!.textLabel?.textColor  =   .whiteColor()
        cell!.tintColor         =   .orangeColor()
        
        return cell!
    }
    
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if let oldIndex = tableView.indexPathForSelectedRow {
            tableView.cellForRowAtIndexPath(oldIndex)?.accessoryType = .None
        }
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        
        return indexPath
    }
    
    
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
//            cell.accessoryType = .Checkmark
//            
//        }
//        
//    }
//    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
//            cell.accessoryType = .None
//        }
//    }
    
    
    

}
