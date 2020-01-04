//
//  IconCell.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/2/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class IconCell: UITableViewCell {
    var iconImageView = UIImageView()
    var iconLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(iconImageView)
        self.addSubview(iconLabel)
        self.configureImageView()
        self.configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("super")
    }
    
    func set(icon:Icon){
        iconImageView.image = icon.getImage()
        iconLabel.text = icon.getTitle()
    }
    
    func configureImageView(){
        iconImageView.layer.cornerRadius = 10
        iconImageView.clipsToBounds = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, multiplier: 1/1).isActive = true
    }
    
    func configureLabel(){
        iconLabel.numberOfLines = 0
        iconLabel.adjustsFontSizeToFitWidth = true
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20).isActive = true
        iconLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        iconLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
