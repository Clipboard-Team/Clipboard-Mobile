//
//  ChooseIconController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/2/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class ChooseIconController: UIViewController {
    public static var member = Member(name: "Default", role: "Default", team: "Default")
    var icons: [Icon] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(IconCell.self, forCellReuseIdentifier: "iconCell")
        guard let icons = getIcons() else {return}
        self.icons = icons
    }
}

extension ChooseIconController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconCell") as! IconCell
        let icon = icons[indexPath.row]
        cell.set(icon: icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let icon = icons[indexPath.row]
        let count = (Constants.currProject.getTeam()?.getMembers().count)!-1
        for n in 0...count{
            if(Constants.currProject.getTeam()?.getMembers()[n].getName() == ChooseIconController.member.getName()){
                Constants.currProject.getTeam()?.getMembers()[n].setIcon(icon: icon.getImage())
                ChooseIconController.member = (Constants.currProject.getTeam()?.getMembers()[n])!
                break
            }
        }
        performSegue(withIdentifier: "fromChooseIconToAddMembers", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let secondViewController = segue.destination as? AddMembersController{
            secondViewController.modalPresentationStyle = .fullScreen
            AddMembersController.previousMember = ChooseIconController.member
        }
    }
}
