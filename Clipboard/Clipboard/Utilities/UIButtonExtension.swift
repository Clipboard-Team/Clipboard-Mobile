//
//  UIButtonExtension.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/14/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

extension UIButton {

    func createFloatingAddButton(){
        let addConfig = UIImage.SymbolConfiguration(pointSize: 20.0)
        let addImage = UIImage(systemName: "plus.circle.fill", withConfiguration: addConfig)
//        setImage(addImage, for: .normal)
        tintColor = UIColor.purple
        //layer.cornerRadius = frame.height/2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }

}
