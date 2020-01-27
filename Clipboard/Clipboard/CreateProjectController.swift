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
    
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = UIColor(red:0.50, green:0.00, blue:0.50, alpha:1.0)
        titleLabel.textColor = UIColor.white
        subtitleLabel.textColor = UIColor.white
    
        dynamicTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.white, placeholderText: "Project name")
        backButton.createStandardHollowButton(color: UIColor.white, backColor: UIColor.purple)
        nextButton.createStandardFullButton(color: UIColor.white, fontColor: UIColor.purple)

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateProjectController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        //isModalInPresentation = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(CreateProjectController.state == "project"){
        } else{
        }
    }

    @IBAction func backTapped(_ sender: Any) {
        switch CreateProjectController.state {
        case "project":
            print("segue to login page")
            Constants.currProject.printEntireProject()
            dismiss(animated: true, completion: nil)
        case "team":
            print("state team changing to state project")
            Constants.currProject.printEntireProject()
            changeState(
                state: "project",
                title: "New Project",
                subtitle: "Think of a cool name for your project!",
                placeholder: "Project name")
            backButton.setTitle("Cancel",for: .normal)
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
                backButton.setTitle("Back",for: .normal)
            case "team":
                print("state team changing to state admin")
                Constants.currProject.setTeam(team: text)
                Constants.currProject.printEntireProject()
                changeState(
                    state: "admin",
                    title: "New Admin Account",
                    subtitle: "You can create more admin accounts later on",
                    placeholder: "Admin name")
                nextButton.setTitle("Finalize",for: .normal)
            case "admin":
                print("segue to choose icon page")
                guard let teamTitle = Constants.currProject.getTeam()?.getTitle() else {return}
                let newMem = Member(name: text, role: "Admin", team: teamTitle)
                Constants.currProject.getTeam()?.addMember(member: newMem)
                Constants.currMember = newMem
                Constants.currProject.printEntireProject()
                let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "ChooseIconController")
                ChooseIconController.member = Constants.currMember
                self.present(vc, animated: true, completion: nil)
            default:
                break
            }
            
        } else{
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
