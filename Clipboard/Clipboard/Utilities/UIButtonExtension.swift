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

    func createStandardFullButton(color: UIColor, fontColor: UIColor){
        frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        backgroundColor = color
        layer.cornerRadius = frame.width * 0.1875
        layer.borderColor = color.cgColor
        layer.borderWidth = 1
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
        tintColor = fontColor
    }
    
    func createStandardHollowButton(color: UIColor){
        frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        backgroundColor = UIColor.clear
        layer.cornerRadius = frame.width * 0.1875
        layer.borderColor = color.cgColor
        layer.borderWidth = 1
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
        tintColor = color
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
    
    func createSettingDetailComponent(){
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.25
        layer.cornerRadius = 5
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
}

extension Date {
    func daysTo(_ date: Date) -> Int? {
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day  // This will return the number of day(s) between dates
    }
}

extension UITextField {
    func createBottomBorderTextField(borderColor: UIColor, width: CGFloat, fontColor: UIColor, placeholderText: String) {
        self.borderStyle = .none
        let border = CALayer()
        border.backgroundColor = borderColor.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,
                              width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
        self.layer.borderColor = fontColor.cgColor
        self.textColor = fontColor
        self.tintColor = fontColor
        self.backgroundColor = UIColor.clear
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
}
