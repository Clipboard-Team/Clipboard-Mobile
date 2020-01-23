//
//  MemberController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/2/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class AddMembersController: UIViewController{
    public static var previousMember = Member(name: "Default", role: "Default", team: "Default")
    private var memberToEditOrDelete = Member(name: "Default", role: "Default", team: "Default")
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var finalizeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = UIColor.purple
        titleLabel.textColor = UIColor.white
        subtitleLabel.textColor = UIColor.white
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = .clear
        backButton.createStandardHollowButton(color: UIColor.white)
        addButton.createStandardHollowButton(color: UIColor.white)
        finalizeButton.createStandardFullButton(color: UIColor.white, fontColor: UIColor.purple)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddMembersController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(MemberCell.self, forCellReuseIdentifier: "memberCell")
    }

    @IBAction func backTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromAddMembersToChooseIcon", sender: self)
    }
    @IBAction func addTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromAddMembersToAddMember", sender: self)
    }
    @IBAction func finalizeTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromAddMembersToHome", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let secondViewController = segue.destination as? UINavigationController {
            print("caught")
            secondViewController.modalPresentationStyle = .fullScreen
        }
        if let secondViewController = segue.destination as? ChooseIconController{
            secondViewController.modalPresentationStyle = .fullScreen
            ChooseIconController.member = AddMembersController.previousMember
        }
        if let secondViewController = segue.destination as? AddMemberController{
            secondViewController.modalPresentationStyle = .formSheet
        }
    }
}

extension AddMembersController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = Constants.currProject.getTeam()?.getMembers().count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell") as! MemberCell
        guard let member = Constants.currProject.getTeam()?.getMembers()[indexPath.row] else {return UITableViewCell()}
        cell.set(member: member)
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.backgroundColor = .clear
        cell.memberNameLabel.textColor = UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let DeleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            success(true)
        })
        DeleteAction.backgroundColor = .red


        return UISwipeActionsConfiguration(actions: [DeleteAction])
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        view.endEditing(true)
    }
}
