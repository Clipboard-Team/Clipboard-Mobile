//
//  HomeController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/3/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fake data
        for n in 0...8{
            let rand1 = Int.random(in: 0..<2)
            let rand2 = Int.random(in: 0..<getIcons()!.count-1)
            guard let teamTitle = Constants.currProject.getTeam()?.getTitle() else { return }
            let member = Member(name: "Member "+String(n), role: Constants.roles[rand1], team: teamTitle)
            guard let image = UIImage(named: (h+mid[rand2]+t)) else {return}
            member.setIcon(icon: image)
            Constants.currProject.getTeam()?.addMember(member: member)
        }
        
        for n in 0...20{
            let rand1 = Int.random(in: 0..<4)
            let rand2 = Int.random(in: 0..<4)
            let rand3 = Int.random(in: 0..<4)
            let task = Task(title: "Task "+String(n)+" Test", status: Constants.statuses[rand1], difficulty: Constants.difficulties[rand1])
            task.setDescription(description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            if(rand2 != 0){
                guard let members = Constants.currProject.getTeam()?.getMembers() else {return}
                let randMem = Int.random(in: 0..<members.count)
                task.setAssignedTo(member: members[randMem])
            }
            if(rand3 != 0){
                task.setDueDate(date: Date())
            }
            Constants.currProject.getTeam()?.addTask(task: task)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        navigationItem.title = "Task Board"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.purple
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor.white

        addButton.createFloatingAddButton()
    }
    
    @IBAction func manageBarButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromHomeToManage", sender: self)
    }
    @IBAction func taskListButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromHomeToTaskList", sender: self)
    }
    @IBAction func addTaskTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromHomeToCreateTask", sender: self)
    }
    
    @IBAction func viewTaskTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromHomeToEditTask", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let secondViewController = segue.destination as? CreateTaskController {
            secondViewController.modalPresentationStyle = .fullScreen
        }
        if let secondViewController = segue.destination as? HomeController {
            secondViewController.modalPresentationStyle = .fullScreen
        }
        if let secondViewController = segue.destination as? ManageProjectController {
            secondViewController.modalPresentationStyle = .fullScreen
        }
        if let secondViewController = segue.destination as? EditTaskController {
            secondViewController.modalPresentationStyle = .fullScreen
            
            guard let task = Constants.currProject.getTeam()?.getTasks()[0] else {return}
            secondViewController.setTask(task: task)
        }
        if let secondViewController = segue.destination as? TaskListController {
            secondViewController.modalPresentationStyle = .fullScreen
        }
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        view.endEditing(true)
    }

}
