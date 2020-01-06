//
//  CreateProjectController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 12/31/19.
//  Copyright © 2019 Xavier La Rosa. All rights reserved.
//

import UIKit

class CreateProjectController: UIViewController {
    private var state:String? // project, team, admin, member
    private var currentMember:Member?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dynamicTextField: UITextField!
    @IBAction func backTapped(_ sender: Any) {
        switch state {
        case "project":
            print("will segue")
            Constants.currProject.printEntireProject()
            setState(state: "project")
            dynamicTextField.text = ""
            performSegue(withIdentifier: "fromCreateProjectToLogin", sender: self)
        case "team":
            print("will not segue")
            print("will instead change state and ui labels")
            Constants.currProject.printEntireProject()
            setState(state: "project")
            titleLabel.text = "New Project"
            subtitleLabel.text = "Think of a cool name for your project!"
            dynamicTextField.placeholder = "Project name"
            dynamicTextField.text = ""
        case "admin":
            print("will not segue")
            print("will instead change state and ui labels")
            Constants.currProject.printEntireProject()
            setState(state: "team")
            titleLabel.text = "New Team"
            subtitleLabel.text = "What do you want to name your team?"
            dynamicTextField.placeholder = "Team name"
            dynamicTextField.text = ""
        default:
            break
        }
    }
    @IBAction func forwardTapped(_ sender: Any) {
        guard let text = dynamicTextField.text else {return}
        guard let state = state else {return}
        if(!text.isEmpty){
            print("good")
            
            // call for segue if in admin state, else change UI
            switch state {
            case "project":
                print("will not segue")
                print("will instead change state and ui labels")
                Constants.currProject = Project(title: text)
                Constants.currProject.printEntireProject()
                setState(state: "team")
                titleLabel.text = "New Team"
                subtitleLabel.text = "What do you want to name your team?"
                dynamicTextField.placeholder = "Team name"
                dynamicTextField.text = ""
            case "team":
                print("will not segue")
                print("will instead change state and ui labels")
                Constants.currProject.setTeam(team: text)
                Constants.currProject.printEntireProject()
                setState(state: "admin")
                titleLabel.text = "Create your own Admin account"
                subtitleLabel.text = "You can create more admin accounts later on"
                dynamicTextField.placeholder = "Admin name"
                dynamicTextField.text = ""
            case "admin":
                print("will segue")
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
            print("not good")
        }
    }
    
    func setState(state:String){
        self.state = state
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let secondViewController = segue.destination as? ViewController {
            secondViewController.modalPresentationStyle = .fullScreen
        }
        if let secondViewController = segue.destination as? ChooseIconController{
            secondViewController.modalPresentationStyle = .fullScreen

            secondViewController.setMember(member: Constants.currMember)
        }
    }
}
