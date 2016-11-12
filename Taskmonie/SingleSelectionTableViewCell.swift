//
//  SingleSelectionTableViewCell.swift
//  Taskmonie
//
//  Created by Vinod Rathod on 10/11/16.
//  Copyright © 2016 Linkcube. All rights reserved.
//

import UIKit

class SingleSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
