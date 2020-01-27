//
//  ManageMembersController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/6/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class ManageMembersController: UIViewController {
    private var memberToEditOrDelete = Member(name: "Default", role: "Default", team: "Default")
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Your Team"

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ManageMembersController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(MemberCell.self, forCellReuseIdentifier: "memberCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func addTapped(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddMemberController")
        AddMemberController.state = "login"
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true, completion: nil)
    }
}

extension ManageMembersController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = Constants.currProject.getTeam()?.getMembers().count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell") as! MemberCell
        guard let member = Constants.currProject.getTeam()?.getMembers()[indexPath.row] else {return UITableViewCell()}
        cell.set(member: member)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let DeleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            success(true)
        })
        DeleteAction.backgroundColor = .red

        let EditAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            guard let mem = Constants.currProject.getTeam()?.getMembers()[indexPath.row] else {return}
            self.memberToEditOrDelete = mem
            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "EditMemberController")
            EditMemberController.setMember(member: self.memberToEditOrDelete)
            EditMemberController.memberBackup = self.memberToEditOrDelete
            self.navigationController?.pushViewController(vc, animated: true)
            success(true)
        })
        EditAction.backgroundColor = .blue


        return UISwipeActionsConfiguration(actions: [DeleteAction,EditAction])
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        view.endEditing(true)
    }
}
