//
//  ChooseIconController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/2/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class ChooseIconController: UIViewController {
    public static var state = String() // create, login, edit
    public static var member = Member(name: "Default", role: "Default", team: "Default")
    var icons: [Icon] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.backgroundColor = UIColor.purple
        titleLabel.textColor = UIColor.white
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.backgroundColor = .clear
        
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
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.backgroundColor = .clear
        cell.iconLabel.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let icon = icons[indexPath.row]
        let count = (Constants.currProject.getTeam()?.getMembers().count)!-1
        for n in 0...count{
            if(Constants.currProject.getTeam()?.getMembers()[n].getUUID() == ChooseIconController.member.getUUID()){
                Constants.currProject.getTeam()?.getMembers()[n].setIcon(icon: icon.getImage())
                ChooseIconController.member.setIcon(icon: icon.getImage())
                break
            }
        }
        if(ChooseIconController.state == "login"){
            dismiss(animated: true, completion: nil)
        } else if(ChooseIconController.state == "edit"){
            EditMemberController.setMember(member: ChooseIconController.member)
            dismiss(animated: true, completion: nil)
        } else{
            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddMembersController")
            vc.modalPresentationStyle = .fullScreen
            AddMembersController.previousMember = ChooseIconController.member
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func popViewControllerss(popViews: Int, animated: Bool = true) {
        if self.navigationController!.viewControllers.count > popViews
        {
            let vc = self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - popViews - 1]
             self.navigationController?.popToViewController(vc, animated: animated)
        }
    }
    

}
