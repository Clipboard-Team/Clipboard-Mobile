//
//  ChooseIconController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/2/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class ChooseIconController: UIViewController {
    private var member: Member?

    @IBOutlet weak var tableView: UITableView!
    var icons: [Icon] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(IconCell.self, forCellReuseIdentifier: "iconCell")

        
        guard let icons = getIcons() else {return}
        self.icons = icons
    }
    
    func setMember(member:Member){
        self.member = member
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
        for n in 0...(Constants.currProject.getTeam()?.getMembers().count)!-1{
            if(Constants.currProject.getTeam()?.getMembers()[n].getName() == member?.getName()){
                print("found")
                Constants.currProject.getTeam()?.getMembers()[n].setIcon(icon: icon.getImage())
                print("new: "+(Constants.currProject.getTeam()?.getMembers()[n].getIcon().description)!)
                member = Constants.currProject.getTeam()?.getMembers()[n]
                break
            }
        }
        performSegue(withIdentifier: "fromChooseIconToAddMembers", sender: self)
//        print("*test*: "+String((self.member?.getIcon().description)!))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let secondViewController = segue.destination as? AddMembersController{
            secondViewController.modalPresentationStyle = .fullScreen
            guard let member = self.member else {return}
            secondViewController.setPreviouslyCustomizedMember(member: member)
        }
    }
}
