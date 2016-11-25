//
//  CalendarCellView.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 16/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import JTAppleCalendar

class CalendarCellView: JTAppleDayCellView {

    @IBInspectable var todayColor: UIColor!
    @IBInspectable var normalDayColor: UIColor!
    
    @IBOutlet weak var selectedView: AnimationView!
    @IBOutlet weak var dayLabel: UILabel!
    let textSelectedColor = UIColor.blackColor()
    let textDeselectedColor = UIColor.groupTableViewBackgroundColor()
    let previousMonthTextColor = UIColor.grayColor()
    
    lazy var todayDate:String = {
        [weak self] in
        let aString = self!.c.stringFromDate(NSDate())
        
        return aString
    }()
    
    lazy var c: NSDateFormatter = {
       let f = NSDateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        
        return f
    }()

    
    func setupCellBeforeDisplay(cellState: CellState, date: NSDate) {
        // Setup Cell text
        dayLabel.text =  cellState.text
        
        // Setup text color
        configureTextColor(cellState)
        
        // Setup Cell Background color
        self.backgroundColor = c.stringFromDate(date) == todayDate ? todayColor:normalDayColor
        
        // Setup cell selection status
        delayRunOnMainThread(0.0) {
            self.configueViewIntoBubbleView(cellState)
        }
        
        // Configure Visibility
        configureVisibility(cellState)
        

    }
    
    func configureVisibility(cellState: CellState) {
        if
            cellState.dateBelongsTo == .ThisMonth ||
                cellState.dateBelongsTo == .PreviousMonthWithinBoundary ||
                cellState.dateBelongsTo == .FollowingMonthWithinBoundary {
            self.hidden = false
        } else {
            self.hidden = false
        }
        
    }
    
    func configureTextColor(cellState: CellState) {
        if cellState.isSelected {
            dayLabel.textColor = textSelectedColor
        } else if cellState.dateBelongsTo == .ThisMonth {
            dayLabel.textColor = textDeselectedColor
        } else {
            dayLabel.textColor = previousMonthTextColor
        }
    }
    
    func cellSelectionChanged(cellState: CellState) {
        if cellState.isSelected == true {
            if selectedView.hidden == true {
                configueViewIntoBubbleView(cellState)
                selectedView.animateWithBounceEffect(withCompletionHandler: {
                })
            }
        } else {
            configueViewIntoBubbleView(cellState, animateDeselection: true)
        }
    }
    
    private func configueViewIntoBubbleView(cellState: CellState, animateDeselection: Bool = false) {
        if cellState.isSelected {
            self.selectedView.layer.cornerRadius =  self.selectedView.frame.width  / 2
            self.selectedView.hidden = false
            configureTextColor(cellState)
            
        } else {
            if animateDeselection {
                configureTextColor(cellState)
                if selectedView.hidden == false {
                    selectedView.animateWithFadeEffect(withCompletionHandler: { () -> Void in
                        self.selectedView.hidden = true
                        self.selectedView.alpha = 1
                    })
                }
            } else {
                selectedView.hidden = true
            }
        }
    }
    
    
    
}




class AnimationView: UIView {
    
    func animateWithFlipEffect(withCompletionHandler completionHandler:(()->Void)?) {
        AnimationClass.flipAnimation(self, completion: completionHandler)
    }
    func animateWithBounceEffect(withCompletionHandler completionHandler:(()->Void)?) {
        let viewAnimation = AnimationClass.BounceEffect()
        viewAnimation(self){ _ in
            completionHandler?()
        }
    }
    func animateWithFadeEffect(withCompletionHandler completionHandler:(()->Void)?) {
        let viewAnimation = AnimationClass.FadeOutEffect()
        viewAnimation(self) { _ in
            completionHandler?()
        }
    }
}