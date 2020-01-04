//
//  MemberController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/2/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class AddMembersController: UIViewController{
    private var project: Project?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(MemberCell.self, forCellReuseIdentifier: "memberCell")
    }
    
    func setProject(project:Project){
        self.project = project
        self.project?.printEntireProject()
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

        if let secondViewController = segue.destination as? ViewController {
            secondViewController.modalPresentationStyle = .fullScreen
        }
        if let secondViewController = segue.destination as? ChooseIconController{
            secondViewController.modalPresentationStyle = .fullScreen
            guard let project = self.project else {return}
            secondViewController.setProject(project: project)
            guard let member = self.project?.getTeam()?.getMembers()?[0] else {return}
            secondViewController.setMember(member: member)
        }
        if let secondViewController = segue.destination as? AddMemberController{
            secondViewController.modalPresentationStyle = .fullScreen
            guard let project = self.project else {return}
            secondViewController.setProject(project: project)
        }
    }
}

extension AddMembersController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = project?.getTeam()?.getMembers()?.count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell") as! MemberCell
        guard let member = project?.getTeam()?.getMembers()?[indexPath.row] else {return UITableViewCell()}
        cell.set(member: member)
        return cell
    }
     
}
