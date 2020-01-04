//
//  AddMemberController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/3/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class AddMemberController: UIViewController {
    private var project: Project?

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var roleToggle: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func setProject(project:Project){
        self.project = project
        self.project?.printEntireProject()
    }

    @IBAction func backTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromAddMemberToAddMembers", sender: self)
    }
    @IBAction func nextTapped(_ sender: Any) {
        guard let name = usernameTextField.text else {return}
        guard let role = roleToggle.titleForSegment(at: roleToggle.selectedSegmentIndex) else {return}
        guard let team = project?.getTeam()?.getTitle() else {return}
        
        project?.getTeam()?.addMember(member: Member(name: name, role: role, team: team))
        performSegue(withIdentifier: "fromAddMemberToChooseIcon", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let secondViewController = segue.destination as? AddMembersController{
            secondViewController.modalPresentationStyle = .fullScreen
            guard let project = self.project else {return}
            secondViewController.setProject(project: project)
        }
        if let secondViewController = segue.destination as? ChooseIconController{
            secondViewController.modalPresentationStyle = .fullScreen
            guard let project = self.project else {return}
            secondViewController.setProject(project: project)
            guard let count = self.project?.getTeam()?.getMembers()?.count else {return}
            guard let member = self.project?.getTeam()?.getMembers()?[count-1] else {return}
            secondViewController.setMember(member: member)
        }
    }
}
