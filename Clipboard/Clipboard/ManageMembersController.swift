//
//  ManageMembersController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/6/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class ManageMembersController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(MemberCell.self, forCellReuseIdentifier: "memberCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func addTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromManageMembersToAddMember", sender: self)
        AddMemberController.state = "login"
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
            success(true)
        })
        EditAction.backgroundColor = .blue


        return UISwipeActionsConfiguration(actions: [DeleteAction,EditAction])
    }
    
}
