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
        tintColor = UIColor.purple
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }

}

extension UIView {
    func createStatusComponent(){
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.25
        layer.cornerRadius = 5
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
}
