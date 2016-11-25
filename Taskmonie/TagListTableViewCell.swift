//
//  TagListTableViewCell.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 06/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit
import TagListView

class TagListTableViewCell: UITableViewCell, TagListViewDelegate {

    @IBOutlet weak var tagListView: TagListView!
//    var tagArray: [String: Array<String>] = [:]
    var tagArray: NSArray = [] {
        didSet {
            tagListView.removeAllTags()
            
            for tagString in tagArray {
                
                tagListView.addTag(tagString as! String)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
        
        tagListView.delegate = self
        tagListView.textFont = UIFont.systemFontOfSize(15)
        tagListView.shadowRadius = 2
        tagListView.shadowOpacity = 0.4
        tagListView.shadowColor = UIColor.blackColor()
        tagListView.shadowOffset = CGSizeMake(1, 1)
        tagListView.alignment = .Center
        tagListView.clipsToBounds   =   false
        
        
        print(tagArray)
        
        invalidateIntrinsicContentSize()
        superview?.layoutIfNeeded()
        
        
        tagListView.removeAllTags()
        
        for tagString in tagArray {
            
            tagListView.addTag(tagString as! String)
        }
    }

    override func sizeThatFits(size: CGSize) -> CGSize {
        return CGSize.init(width: self.frame.width, height: tagListView.frame.height)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        
    }
    
    
    
    
    // MARK: TagListViewDelegate
    func tagPressed(title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.selected = !tagView.selected
    }
    
    func tagRemoveButtonPressed(title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}
