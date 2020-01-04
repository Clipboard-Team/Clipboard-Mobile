//
//  ChooseIconController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/2/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class ChooseIconController: UIViewController {
    private var project: Project?
    private var member: Member?

    @IBOutlet weak var tableView: UITableView!
    var icons: [Icon] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(IconCell.self, forCellReuseIdentifier: "iconCell")
        print("** test")
        print(getIcons() as Any)
        
        guard let icons = getIcons() else {return}
        self.icons = icons
    }

    func setProject(project:Project){
        self.project = project
        self.project?.printEntireProject()
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
        self.member?.setIcon(icon: icon.getImage())
        performSegue(withIdentifier: "fromChooseIconToAddMembers", sender: self)
//        print("*test*: "+String((self.member?.getIcon().description)!))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let secondViewController = segue.destination as? AddMembersController{
            secondViewController.modalPresentationStyle = .fullScreen
            guard let project = self.project else {return}
            secondViewController.setProject(project: project)
        }
    }
}
