//
//  TaskCell.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/20/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    var assignedToImageView = UIImageView()
    var taskTitleLabel = UILabel()
    var taskStatusLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(assignedToImageView)
        self.addSubview(taskTitleLabel)
        self.configureImageView()
        self.configureLabel()
    }
    
    override func layoutSubviews() {
        //separatorInset.left = 70
        super.layoutSubviews()

        assignedToImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("super")
    }
    
    func set(task:Task){
        if(task.getAssignedTo() == nil){
            assignedToImageView.image = UIImage(named: defaultImgFile)
        } else{
            assignedToImageView.image = task.getAssignedTo()?.getIcon()
        }
        taskTitleLabel.text = task.getTitle()+", "+task.getStatus()
    }
    
    func configureImageView(){
        assignedToImageView.layer.cornerRadius = 10
        assignedToImageView.clipsToBounds = true
        
        assignedToImageView.translatesAutoresizingMaskIntoConstraints = false
        assignedToImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        assignedToImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        assignedToImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        assignedToImageView.widthAnchor.constraint(equalTo: assignedToImageView.heightAnchor, multiplier: 1/1).isActive = true
        
    }
    
    func configureLabel(){
        taskTitleLabel.numberOfLines = 0
        taskTitleLabel.adjustsFontSizeToFitWidth = true
        
        taskTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        taskTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        taskTitleLabel.leadingAnchor.constraint(equalTo: assignedToImageView.trailingAnchor, constant: 20).isActive = true
        taskTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        taskTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
