//
//  ManageProjectController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/6/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class ManageProjectController: UIViewController {

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
    
    private var backupProject = Project(title: "Default")
    private var backupMember = Member(name: "Default", role: "Default", team: "Default")
    override func viewDidLoad() {
        super.viewDidLoad()

        backupProject = Constants.currProject
        backupMember = Constants.currMember
        displayOriginalProject()
    }

    @IBAction func editTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromManageToManageMembers", sender: self)
    }
    @IBAction func resetTapped(_ sender: Any) {
        displayOriginalProject()
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
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
        
        

//        if(memberNameTextField.hasText){
//            guard let members = Constants.currProject.getTeam()?.getMembers() else {return}
//            for mem in members {
//                if(mem.getName() == backupMember.getName()){
//                    mem.setName(name: memberNameTextField.text!)
//                    Constants.currMember.setName(name: memberNameTextField.text!)
//                }
//            }
//        }
//        guard let role = roleToggle.titleForSegment(at: roleToggle.selectedSegmentIndex) else {return}
//        if(role != Constants.currMember.getRole()){
//            guard let members = Constants.currProject.getTeam()?.getMembers() else {return}
//            for mem in members {
//                if(mem.getName() == backupMember.getName()){
//                    mem.setName(name: memberNameTextField.text!)
//                    Constants.currMember.setName(name: memberNameTextField.text!)
//                }
//            }
//        }
        
        _ = navigationController?.popViewController(animated: true)
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
        if(Constants.currMember.getRole() == "Admin"){
            roleToggle.setEnabled(true, forSegmentAt: 0)
        } else{
            roleToggle.setEnabled(false, forSegmentAt: 0)
        }
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
    }
}
