//
//  CompleteTaskCell.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/21/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class CompleteTaskCell: UITableViewCell {
    
    @IBOutlet weak var assignedToImageView: UIImageView!
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskStatusLabel: UILabel!
    @IBOutlet weak var taskDifficultyLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UITextView!
    @IBOutlet weak var taskStartDateLabel: UILabel!
    @IBOutlet weak var taskDueDateLabel: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("super")
        viewButton.createStandardFullButton(color: UIColor.purple, fontColor: UIColor.white)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
