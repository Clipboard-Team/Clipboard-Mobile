//
//  TaskListController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/19/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class TaskListController: UIViewController {
    private var taskToEditOrDelete = Task(title: "Default", status: "Default", difficulty: "Default")
    var taskLists = [ExpandableTasks]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "All Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(TaskCell.self, forCellReuseIdentifier: "taskCell")
        
        guard let toDos = Constants.currProject.getTeam()?.getToDoTasks() else {return}
        guard let inProgs = Constants.currProject.getTeam()?.getInProgressTasks() else {return}
        guard let halts = Constants.currProject.getTeam()?.getHaltedTasks() else {return}
        guard let dones = Constants.currProject.getTeam()?.getDoneTasks() else {return}
        
        taskLists.append(ExpandableTasks(isExpanded: true, tasks: toDos))
        taskLists.append(ExpandableTasks(isExpanded: true, tasks: inProgs))
        taskLists.append(ExpandableTasks(isExpanded: true, tasks: halts))
        taskLists.append(ExpandableTasks(isExpanded: true, tasks: dones))
    }

    @IBAction func filterButtonTapped(_ sender: Any) {
    }
    @IBAction func searchButtonTapped(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let secondViewController = segue.destination as? EditTaskController {
            secondViewController.modalPresentationStyle = .fullScreen
            secondViewController.setTask(task: taskToEditOrDelete)
        }
    }
}

extension TaskListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !taskLists[section].isExpanded {
            return 0
        }
        
        return taskLists[section].tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskCell
        let task = taskLists[indexPath.section].tasks[indexPath.row]
        cell.set(task: task)
               return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.statuses.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tail = " Tasks"
        switch section {
        case 0:
            return Constants.statuses[0]+tail
        case 1:
            return Constants.statuses[1]+tail
        case 2:
            return Constants.statuses[2]+tail
        case 3:
            return Constants.statuses[3]+tail
        default:
            return "Default Header"
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        
        return button
    }
    
    @objc func handleExpandClose(button: UIButton) {
        print("Trying to expand and close section...")
        
        let section = button.tag
         
        // we'll try to close the section first by deleting the rows
        var indexPaths = [IndexPath]()
        for row in taskLists[section].tasks.indices {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = taskLists[section].isExpanded
        taskLists[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == tableView.indexPathForSelectedRow?.section
            && indexPath.row == tableView.indexPathForSelectedRow?.row
            ){
            print("caught to big")
            return 75
        } else {
            print("caught to small")
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let DeleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            switch indexPath.section {
            case 0:
                guard let task = Constants.currProject.getTeam()?.getToDoTasks()[indexPath.row] else {return}
                self.taskToEditOrDelete = task
                //Constants.currProject.getTeam()?.deleteTask(task: self.taskToEditOrDelete)
                break
            case 1:
                guard let task = Constants.currProject.getTeam()?.getInProgressTasks()[indexPath.row] else {return}
                self.taskToEditOrDelete = task
                //Constants.currProject.getTeam()?.deleteTask(task: self.taskToEditOrDelete)
                break
            case 2:
                guard let task = Constants.currProject.getTeam()?.getHaltedTasks()[indexPath.row] else {return}
                self.taskToEditOrDelete = task
                //Constants.currProject.getTeam()?.deleteTask(task: self.taskToEditOrDelete)
                break
            case 3:
                guard let task = Constants.currProject.getTeam()?.getDoneTasks()[indexPath.row] else {return}
                self.taskToEditOrDelete = task
                //Constants.currProject.getTeam()?.deleteTask(task: self.taskToEditOrDelete)
                break
            default:
                break
            }
            tableView.reloadData()
            success(true)
        })
        DeleteAction.backgroundColor = .red

        let ViewAction = UIContextualAction(style: .normal, title:  "View", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            
            switch indexPath.section {
            case 0:
                guard let task = Constants.currProject.getTeam()?.getToDoTasks()[indexPath.row] else {return}
                self.taskToEditOrDelete = task
                break
            case 1:
                guard let task = Constants.currProject.getTeam()?.getInProgressTasks()[indexPath.row] else {return}
                self.taskToEditOrDelete = task
                break
            case 2:
                guard let task = Constants.currProject.getTeam()?.getHaltedTasks()[indexPath.row] else {return}
                self.taskToEditOrDelete = task
                break
            case 3:
                guard let task = Constants.currProject.getTeam()?.getDoneTasks()[indexPath.row] else {return}
                self.taskToEditOrDelete = task
                break
            default:
                break
            }
            self.performSegue(withIdentifier: "fromTaskListToEditTask", sender: self)
            success(true)
        })
        ViewAction.backgroundColor = .green


        return UISwipeActionsConfiguration(actions: [DeleteAction,ViewAction])
    }
}
