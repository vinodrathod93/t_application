//
//  PollChoiceTableViewCell.swift
//  Taskmonie
//
//  Created by Sachin Ahirrao on 11/24/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class PollChoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var currentStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
