//
//  ViewController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 12/30/19.
//  Copyright © 2019 Xavier La Rosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }

    @IBAction func loginTapped(_ sender: Any) {
        guard let projectText = projectTextField.text else {return}
        guard let usernameText = usernameTextField.text else {return}
        
        if(projectText.isEmpty || usernameText.isEmpty){
        } else{
        }
    }
    
    @IBAction func createTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromLoginToCreateProject", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let secondViewController = segue.destination as? CreateProjectController {
            secondViewController.modalPresentationStyle = .formSheet
            CreateProjectController.state = "project"
        }
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        view.endEditing(true)
    }
}

