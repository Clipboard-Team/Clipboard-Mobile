//
//  EditMemberController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/13/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class EditMemberController: UIViewController {

    private var member = Member(name: "Default", role: "Default", team: "Default")
    @IBOutlet weak var memberNameTextField: UITextField!
    @IBOutlet weak var roleSlider: UISegmentedControl!
    @IBOutlet weak var iconButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit Member"
        memberNameTextField.text = member.getName()
        // catch slider
        iconButton.setBackgroundImage(member.getIcon(), for: .normal)
    }

    func setMember(member: Member){
        self.member = member
    }
}
