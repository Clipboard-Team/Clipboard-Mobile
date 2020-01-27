//
//  ViewController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 12/30/19.
//  Copyright © 2019 Xavier La Rosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        projectTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.purple, placeholderText: "Project name")
                usernameTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.purple, placeholderText: "Username")
                
        //        titleLabel.textColor = UIColor.purple
        //        subtitleLabel.textColor = UIColor.purple
                
                logoImageView.image = UIImage(named: logoPurple)
                
                loginButton.createStandardFullButton(color: UIColor.purple, fontColor: UIColor.white)
                createButton.createStandardHollowButton(color: UIColor.purple, backColor: UIColor.white)
    }
    @IBAction func loginTapped(_ sender: Any) {
        guard let projectText = projectTextField.text else {return}
        guard let usernameText = usernameTextField.text else {return}
        
        if(projectText.isEmpty || usernameText.isEmpty){
        } else{
        }
    }
    
    @IBAction func createTapped(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CreateProjectController")
        CreateProjectController.state = "project"
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        view.endEditing(true)
    }
}

