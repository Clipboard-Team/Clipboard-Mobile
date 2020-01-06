 //
//  MemberCell.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/2/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class MemberCell: UITableViewCell {
    var memberImageView = UIImageView()
    var memberNameLabel = UILabel()
    var memberRoleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(memberImageView)
        self.addSubview(memberNameLabel)
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
    
    func set(member:Member){
        memberImageView.image = member.getIcon()
        memberNameLabel.text = member.getName()+", "+member.getRole()
    }
    
    func configureImageView(){
        memberImageView.layer.cornerRadius = 10
        memberImageView.clipsToBounds = true
        
        memberImageView.translatesAutoresizingMaskIntoConstraints = false
        memberImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        memberImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        memberImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        memberImageView.widthAnchor.constraint(equalTo: memberImageView.heightAnchor, multiplier: 1/1).isActive = true
    }
    
    func configureLabel(){
        memberNameLabel.numberOfLines = 0
        memberNameLabel.adjustsFontSizeToFitWidth = true
        
        memberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        memberNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        memberNameLabel.leadingAnchor.constraint(equalTo: memberImageView.trailingAnchor, constant: 20).isActive = true
        memberNameLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        memberNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
