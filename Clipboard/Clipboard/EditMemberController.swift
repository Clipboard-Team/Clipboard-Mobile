//
//  EditMemberController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/13/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class EditMemberController: UIViewController {


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
    }

    @IBAction func iconButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromEditMemberToChooseIcon", sender: self)
    }
    func setMember(member: Member){
        EditMemberController.member = member
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let secondViewController = segue.destination as? ChooseIconController{
            secondViewController.modalPresentationStyle = .formSheet
            
            ChooseIconController.member = EditMemberController.member
            ChooseIconController.state = "edit"
        }
    }
}
