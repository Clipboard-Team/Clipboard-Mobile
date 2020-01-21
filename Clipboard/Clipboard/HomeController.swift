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
        
        // fake data for testing
        let task1 = Task(title: "Task 1 Test", status: "To Do", difficulty: "Easy")
        task1.setAssignedTo(member: Constants.currMember)
        Constants.currProject.getTeam()?.addTask(task: task1)
        
        let task2 = Task(title: "Task 2 Test", status: "In Progress", difficulty: "Medium")
        task2.setAssignedTo(member: Constants.currMember)
        Constants.currProject.getTeam()?.addTask(task: task2)

        let task3 = Task(title: "Task 3 Test", status: "Halted", difficulty: "Hard")
        Constants.currProject.getTeam()?.addTask(task: task3)

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
