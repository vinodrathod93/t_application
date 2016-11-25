//
//  AVCollectionViewCell.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 04/09/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class AVCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var PreviewImageView: UIImageView!
    @IBOutlet weak var ContentName: UILabel!
    @IBOutlet weak var contentEarningAmount: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var validityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    
    
    
    
}
