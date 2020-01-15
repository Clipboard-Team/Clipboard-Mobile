//
//  CreateProjectController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 12/31/19.
//  Copyright © 2019 Xavier La Rosa. All rights reserved.
//

import UIKit

class CreateProjectController: UIViewController, UIAdaptivePresentationControllerDelegate {
    public static var state = String() // project, team, admin
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dynamicTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateProjectController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        //isModalInPresentation = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(CreateProjectController.state == "project"){
            //backButton.isHidden = true
            /*
             TODO: Figure out how to program a horizontal align on next button
             */
        } else{
            //backButton.isHidden = false
        }
    }
    
    
//    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
//        print("detected:")
//        // Create the action buttons for the alert.
//        let defaultAction = UIAlertAction(title: "Agree",
//                             style: .default) { (action) in
//         // Respond to user selection of the action.
//        }
//        let cancelAction = UIAlertAction(title: "Disagree",
//                             style: .cancel) { (action) in
//         // Respond to user selection of the action.
//        }
//        
//        // Create and configure the alert controller.
//        let alert = UIAlertController(title: "Terms and Conditions",
//              message: "Click Agree to accept the terms and conditions.",
//              preferredStyle: .alert)
//        alert.addAction(defaultAction)
//        alert.addAction(cancelAction)
//             
//        self.present(alert, animated: true) {
//           // The alert was presented
//        }
//    }

    @IBAction func backTapped(_ sender: Any) {
        switch CreateProjectController.state {
        case "project":
            print("segue to login page")
            Constants.currProject.printEntireProject()
            performSegue(withIdentifier: "fromCreateProjectToLogin", sender: self)
        case "team":
            print("state team changing to state project")
            Constants.currProject.printEntireProject()
            changeState(
                state: "project",
                title: "New Project",
                subtitle: "Think of a cool name for your project!",
                placeholder: "Project name")
        case "admin":
            print("state admin changing to state team")
            Constants.currProject.printEntireProject()
            changeState(
                state: "team",
                title: "New Team",
                subtitle: "What do you want to name your team?",
                placeholder: "Team name")
        default:
            break
        }
    }
    
    @IBAction func forwardTapped(_ sender: Any) {
        guard let text = dynamicTextField.text else {return}
        if(!text.isEmpty){
            switch CreateProjectController.state {
            case "project":
                print("state project changing to state team")
                Constants.currProject = Project(title: text)
                Constants.currProject.printEntireProject()
                changeState(
                    state: "team",
                    title: "New Team",
                    subtitle: "What do you want to name your team?",
                    placeholder: "Team name")
            case "team":
                print("state team changing to state admin")
                Constants.currProject.setTeam(team: text)
                Constants.currProject.printEntireProject()
                changeState(
                    state: "admin",
                    title: "Create your own Admin account",
                    subtitle: "You can create more admin accounts later on",
                    placeholder: "Admin name")
            case "admin":
                print("segue to choose icon page")
                guard let teamTitle = Constants.currProject.getTeam()?.getTitle() else {return}
                let newMem = Member(name: text, role: "Admin", team: teamTitle)
                Constants.currProject.getTeam()?.addMember(member: newMem)
                Constants.currMember = newMem
                Constants.currProject.printEntireProject()
                performSegue(withIdentifier: "fromCreateProjectToChooseIcon", sender: self)
            default:
                break
            }
            
        } else{
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let secondViewController = segue.destination as? ViewController {
            secondViewController.modalPresentationStyle = .fullScreen
        }
        if let secondViewController = segue.destination as? ChooseIconController{
            secondViewController.modalPresentationStyle = .formSheet
            ChooseIconController.member = Constants.currMember
        }
    }
    
    func changeState(state: String, title: String, subtitle: String, placeholder: String){
        CreateProjectController.state = state
        titleLabel.text = title
        subtitleLabel.text = subtitle
        dynamicTextField.placeholder = placeholder
        dynamicTextField.text = ""
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        view.endEditing(true)
    }
}
