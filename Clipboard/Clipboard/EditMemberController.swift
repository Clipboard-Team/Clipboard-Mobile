//
//  EditMemberController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/13/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class EditMemberController: UIViewController {

    static var memberBackup  = Member(name: "Default", role: "Default", team: "Default")
    static var member = Member(name: "Default", role: "Default", team: "Default")
    @IBOutlet weak var memberNameTextField: UITextField!
    @IBOutlet weak var roleSlider: UISegmentedControl!
    @IBOutlet weak var iconButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit Member"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memberNameTextField.text = EditMemberController.member.getName()
        // catch slider
        iconButton.setBackgroundImage(EditMemberController.member.getIcon(), for: .normal)
        if(EditMemberController.member.getRole() == Constants.roles[0]){
            roleSlider.selectedSegmentIndex = 0
        } else{
            roleSlider.selectedSegmentIndex = 1
        }
    }

    @IBAction func iconButtonTapped(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChooseIconController")
        vc.modalPresentationStyle = .formSheet
        ChooseIconController.member = EditMemberController.member
        ChooseIconController.state = "edit"
        self.present(vc, animated: true, completion: nil)
    }
    static func setMember(member: Member){
        EditMemberController.member = member
    }
}
