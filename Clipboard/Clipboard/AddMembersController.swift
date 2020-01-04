//
//  MemberController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/2/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class AddMembersController: UIViewController{
    private var prevMember: Member?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(MemberCell.self, forCellReuseIdentifier: "memberCell")
    }
    
    func setPreviouslyCustomizedMember(member: Member){
        self.prevMember = member
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

        if let secondViewController = segue.destination as? HomeController {
            secondViewController.modalPresentationStyle = .fullScreen
        }
        if let secondViewController = segue.destination as? ChooseIconController{
            secondViewController.modalPresentationStyle = .fullScreen
            guard let member = prevMember else {return}
            secondViewController.setMember(member: member)
        }
        if let secondViewController = segue.destination as? AddMemberController{
            print("match")
            secondViewController.modalPresentationStyle = .fullScreen
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
        return cell
    }
     
}
