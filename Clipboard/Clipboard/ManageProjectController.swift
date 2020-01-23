//
//  ManageProjectController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/6/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class ManageProjectController: UIViewController {

    private var backupProject = Project(title: "Default")
    private var backupMember = Member(name: "Default", role: "Default", team: "Default")
    @IBOutlet weak var projectStartDateLabel: UILabel!
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var projectDescriptionTextField: UITextField!
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var teamDescriptionTextField: UITextField!
    @IBOutlet weak var memberNameTextField: UITextField!
    @IBOutlet weak var roleToggle: UISegmentedControl!
    @IBOutlet weak var numMembersLabel: UILabel!
    @IBOutlet weak var numAdminsLabel: UILabel!
    @IBOutlet weak var numLeadsLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var projectView: UIView!
    @IBOutlet weak var teamView: UIView!
    @IBOutlet weak var accountView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Manage Project"
        
        logoutButton.createStandardFullButton(color: UIColor.red, fontColor: UIColor.white)
        resetButton.createStandardHollowButton(color: UIColor.purple)
        confirmButton.createStandardFullButton(color: UIColor.purple, fontColor: UIColor.white)
        projectNameTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.purple, placeholderText: "Project name")
        projectDescriptionTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.purple, placeholderText: "Optional project description")
        teamNameTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.purple, placeholderText: "Team name")
        teamDescriptionTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.purple, placeholderText: "Optional team description")
        memberNameTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.purple, placeholderText: "Account name")
        projectView.createSettingDetailComponent()
        teamView.createSettingDetailComponent()
        accountView.createSettingDetailComponent()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ManageProjectController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)

        backupProject = Constants.currProject
        backupMember = Constants.currMember
        displayOriginalProject()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayOriginalProject()
    }

    @IBAction func editTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromManageToManageMembers", sender: self)
    }

    @IBAction func resetTapped(_ sender: Any) {
        displayOriginalProject()
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        if(projectNameTextField.hasText && teamNameTextField.hasText && memberNameTextField.hasText){
            if(projectNameTextField.hasText){
                Constants.currProject.setTitle(title: projectNameTextField.text!)
            }
            if(projectDescriptionTextField.hasText){
                Constants.currProject.setDescription(description: projectDescriptionTextField.text!)
            }
            if(teamNameTextField.hasText){
                Constants.currProject.getTeam()?.setTitle(title: teamNameTextField.text!)
            }
            if(teamDescriptionTextField.hasText){
                Constants.currProject.getTeam()?.setDescription(description: teamDescriptionTextField.text!)
            }
            if(memberNameTextField.hasText){
                guard let name = memberNameTextField.text else {return}
                Constants.currMember.setName(name: name)
                guard let members = Constants.currProject.getTeam()?.getMembers() else {return}
                for mem in members {
                    if(mem.getUUID() == Constants.currMember.getUUID()){
                        print("matched member UUID")
                        mem.setName(name: name)
                    }
                }
            }
            if(roleToggle.selectedSegmentIndex == 0 && Constants.currMember.getRole() != Constants.roles[0]){
                Constants.currMember.setRole(role: Constants.statuses[0])
                guard let members = Constants.currProject.getTeam()?.getMembers() else {return}
                for mem in members {
                    if(mem.getUUID() == Constants.currMember.getUUID()){
                        print("matched member UUID")
                        mem.setRole(role: Constants.statuses[0])
                    }
                }
            } else if(roleToggle.selectedSegmentIndex == 1 && Constants.currMember.getRole() != Constants.roles[1]){
                Constants.currMember.setRole(role: Constants.statuses[1])
                guard let members = Constants.currProject.getTeam()?.getMembers() else {return}
                for mem in members {
                    if(mem.getUUID() == Constants.currMember.getUUID()){
                        print("matched member UUID")
                        mem.setRole(role: Constants.statuses[1])
                    }
                }
            }
            
            _ = navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Could not update project", message: "Make sure project, team, and member name is filled out. \n\nAlso, make sure team name and member name does not already exist.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func displayOriginalProject(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatShort
        projectStartDateLabel.text = dateFormatter.string(from: backupProject.getStartDate())
        projectNameTextField.text = backupProject.getTitle()
        guard let projectDescription = backupProject.getDescription() else {return}
        projectDescriptionTextField.text = projectDescription
        teamNameTextField.text = backupProject.getTeam()?.getTitle()
        guard let teamDescription = backupProject.getTeam()?.getDescription() else {return}
        teamDescriptionTextField.text = teamDescription
        memberNameTextField.text = Constants.currMember.getName()

        guard let members = backupProject.getTeam()?.getMembers() else {return}
        var memCount = Int()
        var adminCount = Int()
        var leadCount = Int()
        for mem in members {
            if(mem.getRole() == "Admin"){
                adminCount+=1
            } else{
                leadCount+=1
            }
            memCount+=1
        }
        numMembersLabel.text = String(memCount) + " total member(s)"
        numAdminsLabel.text = String(adminCount) + " admin(s)"
        numLeadsLabel.text = String(leadCount) + " lead(s)"
        if(Constants.currMember.getRole() == Constants.roles[0]){
            roleToggle.selectedSegmentIndex = 0
        } else{
            roleToggle.selectedSegmentIndex = 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let secondViewController = segue.destination as? ManageMembersController {
            secondViewController.modalPresentationStyle = .formSheet
        }
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        view.endEditing(true)
    }
}
