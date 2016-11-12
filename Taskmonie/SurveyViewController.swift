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
    var multiSelectionTableView = UITableView()
    var movableTableView = UITableView()
    var imageTableView = UITableView()
    
    var sliderView = UIView()
    
    var multiSelectionData = NSArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title  =   "1/5"
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .Plain, target: nil, action: nil)
        
        self.submitButton.layer.cornerRadius = 8.0
        self.submitButton.layer.borderColor = UIColor.init(red: 80/255.0, green: 255/255.0, blue: 39/255.0, alpha: 1.0).CGColor
        self.submitButton.layer.borderWidth = 0.8
        self.submitButton.addTarget(self, action: #selector(nextButtonTapped), forControlEvents: .TouchUpInside)
        
        
        self.instrucitonLabel.hidden = true
        
        
        multiSelectionData  =   ["Rock", "Jazz", "Pop", "Ghazal"]
        
        
        
        print(NSStringFromCGRect(self.contentView.frame))
        self.contentView.backgroundColor    =   .clearColor()
        self.contentView.layoutIfNeeded()
        
        print(NSStringFromCGRect(self.contentView.frame))
        
        singleSelectionView()
        sliderQuestionView()
        multiSelectionView()
        movableCellTableView()
        imagedOptionsTableView()
        
        
        self.disableSubmitButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func enableSubmitButton() {
        self.submitButton.layer.borderColor = UIColor.init(red: 80/255.0, green: 255/255.0, blue: 39/255.0, alpha: 1.0).CGColor
        self.submitButton.enabled   =   true
    }
    
    func disableSubmitButton() {
        self.submitButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.submitButton.enabled   =   false
    }
    
    
    
    func nextButtonTapped() {
        
        
        let labelAnimation  =   CATransition.init()
        labelAnimation.timingFunction   =   CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        labelAnimation.startProgress    =   0
        labelAnimation.endProgress      =   1
        labelAnimation.delegate =   self
        labelAnimation.type =   kCATransitionFade
        labelAnimation.fillMode =   kCAFillModeBoth
        labelAnimation.duration =   0.33
        self.questionLabel.layer.addAnimation(labelAnimation, forKey: kCATransitionFade)
        
        self.instrucitonLabel.layer.addAnimation(labelAnimation, forKey: "instructionFadeAnimationTransition")
        
        
        let transition  =   CATransition.init()
        transition.timingFunction   =   CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.startProgress    =   0
        transition.endProgress      =   1
        transition.delegate         =   self
        transition.type             =   kCATransitionPush
        transition.subtype          =   kCATransitionFromRight
        transition.duration         =   0.4
        
        
        if !singleSelectionTableView.hidden {
            self.title = "2/5"
            
            self.questionLabel.text = "How Much would you rate us for our Marketing strategies."
            
            
            
            
            
            self.singleSelectionTableView.layer.addAnimation(transition, forKey: kCATransitionPush)
            self.singleSelectionTableView.hidden       =   true
            self.singleSelectionTableView.alpha        =   0.0
            
            
            self.sliderView.layer.addAnimation(transition, forKey: kCATransitionPush)
            self.sliderView.hidden  =   false
            self.sliderView.alpha   =   1.0
            
            disableSubmitButton()
            
        }
        else if !self.sliderView.hidden {
            
            
            self.title = "3/5"
            
            self.questionLabel.text =   "What kind of music do you like?"
            
            
            self.sliderView.layer.addAnimation(transition, forKey: "sliderViewDoneTransitionPush")
            self.sliderView.hidden  =   true
            self.sliderView.alpha   =   0.0
            
            self.multiSelectionTableView.layer.addAnimation(transition, forKey: "multiSelectionTransitionPush")
            self.multiSelectionTableView.hidden       =   false
            self.multiSelectionTableView.alpha        =   1.0
            
            self.multiSelectionTableView.frame =   CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.height)
            disableSubmitButton()
        }
        else if !self.multiSelectionTableView.hidden {
            
            self.title = "4/5"
            
            self.questionLabel.text =   "Which Service on FreeCharge do you liked the most?"
            
            self.instrucitonLabel.text = "";
            self.instrucitonLabel.hidden = false
            self.instrucitonLabel.text  =   "Arrange your Choices in most preferred first order."
            
            
            
            self.multiSelectionTableView.layer.addAnimation(transition, forKey: "multiSelectionDoneTransitionPush")
            self.multiSelectionTableView.hidden  =   true
            self.multiSelectionTableView.alpha   =   0.0
            
            self.movableTableView.layer.addAnimation(transition, forKey: "movableTableViewTransitionPush")
            self.movableTableView.hidden       =   false
            self.movableTableView.alpha        =   1.0
            
            self.movableTableView.frame =   CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.height)
            
            disableSubmitButton()
        }
        else if !self.movableTableView.hidden {
            self.title = "5/5"
            
            self.questionLabel.text =   "Which logo of FreeCharge do you liked the most?"
            self.instrucitonLabel.text = nil
            self.instrucitonLabel.hidden = true
            
            
            self.movableTableView.layer.addAnimation(transition, forKey: "movableTableViewDoneTransitionPush")
            self.movableTableView.hidden  =   true
            self.movableTableView.alpha   =   0.0
            
            self.imageTableView.layer.addAnimation(transition, forKey: "imagedTableViewTransitionPush")
            self.imageTableView.hidden       =   false
            self.imageTableView.alpha        =   1.0
            
            
            
            
            disableSubmitButton()
            self.submitButton.setTitle("Submit", forState: .Normal)
            
            self.imageTableView.frame =   CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.height)
            

        }
        else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            
            let completeVC = sb.instantiateViewControllerWithIdentifier("videoCompletionVC") as! VideoCompletionViewController
            
            self.navigationController?.pushViewController(completeVC, animated: true)
        }
        
        
        
        
    }
    
    
    
    func sliderQuestionView() {
        
        sliderView    =   UIView.init(frame: CGRectMake(0, 40, contentView.frame.width, 100))
        sliderView.backgroundColor = .blackColor()
        
        
        let slider = UISlider.init(frame: CGRectMake(10, 35, self.view.frame.width - 20, 10))
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.continuous = true
        slider.value = 0
        
        slider.addTarget(self, action: #selector(sliderChanged), forControlEvents: .ValueChanged)
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
        
        
        self.view.layoutIfNeeded()
        singleSelectionTableView   =   UITableView.init(frame: CGRectMake(0, 0, contentView.frame.width, contentView.frame.height), style: .Grouped)
        
        singleSelectionTableView.backgroundColor   =   .clearColor()
        singleSelectionTableView.delegate = self
        singleSelectionTableView.dataSource = self
        singleSelectionTableView.registerNib(UINib.init(nibName: "SingleSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "questionOptionsCellIdentifier")
        
        singleSelectionTableView.layoutIfNeeded()
        singleSelectionTableView.clipsToBounds = true
        contentView.addSubview(singleSelectionTableView)
        
        
    }
    
    
    
    func multiSelectionView() {
        self.view.layoutIfNeeded()
        multiSelectionTableView   =   UITableView.init(frame: CGRectMake(0, 0, contentView.frame.width, contentView.frame.height), style: .Grouped)
        
        multiSelectionTableView.backgroundColor   =     .clearColor()
        multiSelectionTableView.delegate          =     self
        multiSelectionTableView.dataSource        =     self
        multiSelectionTableView.registerNib(UINib.init(nibName: "SingleSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "questionOptionsCellIdentifier")
        multiSelectionTableView.allowsMultipleSelection = true
        multiSelectionTableView.layoutIfNeeded()
        
        
        contentView.addSubview(multiSelectionTableView)
        
        multiSelectionTableView.hidden = true
        multiSelectionTableView.alpha    = 0.0
    }
    
    
    func movableCellTableView() {
        self.view.layoutIfNeeded()
        movableTableView   =   UITableView.init(frame: CGRectMake(0, 0, contentView.frame.width, contentView.frame.height), style: .Grouped)
        
        movableTableView.backgroundColor   =     .clearColor()
        movableTableView.delegate          =     self
        movableTableView.dataSource        =     self
        movableTableView.registerNib(UINib.init(nibName: "SingleSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "questionOptionsCellIdentifier")
        movableTableView.setEditing(true, animated: true)
        movableTableView.layoutIfNeeded()
        
        
        contentView.addSubview(movableTableView)
        
        movableTableView.hidden = true
        movableTableView.alpha    = 0.0
    }
    
    
    
    func imagedOptionsTableView() {
        self.contentView.layoutIfNeeded()
        imageTableView   =   UITableView.init(frame: CGRectMake(0, 0, contentView.frame.width, contentView.frame.height), style: .Grouped)
        
        imageTableView.backgroundColor   =     .clearColor()
        imageTableView.delegate          =     self
        imageTableView.dataSource        =     self
        imageTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "imagedSelectionTableViewCellIdentifier")
        imageTableView.layoutIfNeeded()
        
        contentView.clipsToBounds    =   true
        contentView.addSubview(imageTableView)
        
        imageTableView.hidden = true
        imageTableView.alpha    = 0.0
    }
    
    
    
    
    //MARK: UISlider Action
    
    func sliderChanged() {
        enableSubmitButton()
    }
    
    
    
    // MARK: UITableView Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier  =   (tableView == imageTableView) ? "imagedSelectionTableViewCellIdentifier" : "questionOptionsCellIdentifier"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        if tableView == multiSelectionTableView {
            cell!.textLabel?.text    =   multiSelectionData[indexPath.row] as? String
        }
        else if tableView == imageTableView {
            
            let imageView   =   UIImageView.init(image: UIImage.init(named: "snapdeal"))
            imageView.frame =   CGRectMake(0, 10, self.view.frame.width - 50, 80)
            imageView.contentMode   =   .ScaleAspectFit
            imageView.center    =   (cell?.contentView.center)!
            
            cell?.backgroundView    =   imageView
            
        }
        else {
            cell!.textLabel?.text   =   "EveryDay \(indexPath.row)"
        }
        
        cell!.backgroundColor    =   .clearColor()
        cell!.textLabel?.textColor   =   .whiteColor()
        
        
        
        return cell!
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        enableSubmitButton()
        
        if tableView == self.singleSelectionTableView || tableView == self.multiSelectionTableView {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                cell.accessoryType = .Checkmark
            }
        }
        else if tableView == self.imageTableView {
            let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
            selectedCell.backgroundView!.layer.borderColor = UIColor.redColor().CGColor
            selectedCell.backgroundView?.layer.borderWidth  =   5
        }
        
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == self.singleSelectionTableView || tableView == self.multiSelectionTableView {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                
                print("Index is \(indexPath.row)")
                cell.accessoryType = .None
            }
        }
        else if tableView == self.imageTableView {
            let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
            selectedCell.backgroundView!.layer.borderColor = UIColor.clearColor().CGColor
        }
    
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView == imageTableView {
            return 100
        }
        else {
            return 44
        }
    }
    
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        return .None
    }
    
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if tableView == self.movableTableView {
            return true
        }
        else {
            return false
        }
    }
    
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // nothing
        
        enableSubmitButton()
    }
    
    
    

}
