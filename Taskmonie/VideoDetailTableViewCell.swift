//
//  VideoDetailTableViewCell.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 24/10/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class VideoDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var expandImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
