//
//  TaskCell.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/20/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var assignedToImageView: UIImageView!
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskStartDateLabel: UILabel!
    
    func set(task:Task){
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("super")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
