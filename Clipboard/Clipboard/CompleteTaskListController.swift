//
//  CompleteTaskListController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/21/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class CompleteTaskListController: UIViewController {

    public static var type = String()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = CompleteTaskListController.type + " Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 320
        
        let completeTaskCell = UINib(nibName: "CompleteTaskCell", bundle: nil)
        tableView.register(completeTaskCell, forCellReuseIdentifier: "CompleteTaskCell")
    }

    func getTasks() -> [Task]{
        guard let team = Constants.currProject.getTeam() else {return [Task]()}
        switch CompleteTaskListController.type {
        case Constants.statuses[0]:
            return team.getToDoTasks()
        case Constants.statuses[1]:
            return team.getInProgressTasks()
        case Constants.statuses[2]:
            return team.getHaltedTasks()
        case Constants.statuses[3]:
            return team.getDoneTasks()
        default:
            return team.getTasks()
        }
    }
    @IBAction func addTaskTapped(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CreateTaskController")
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
    }
}

extension CompleteTaskListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getTasks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "completeTaskCell")
        as! CompleteTaskCell
        let task: Task
        let tasks = getTasks()
        task = tasks[indexPath.row]
        
        if(task.getAssignedTo() == nil){
            cell.assignedToImageView.image = UIImage(named: defaultImgFile)
        } else{
            cell.assignedToImageView.image = task.getAssignedTo()?.getIcon()
        }
        cell.taskTitleLabel.text = task.getTitle()
        cell.taskStatusLabel.text = task.getStatus()
        cell.taskDifficultyLabel.text = task.getDifficulty()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatShort
        cell.taskStartDateLabel.text = dateFormatter.string(from: task.getStartDate())
        guard let dueDate = task.getDueDate() else{
            cell.taskDueDateLabel.text = ""
            return cell
        }
        guard let days = dueDate.daysTo(Date()) else {
            return cell
        }
        cell.taskDueDateLabel.text = String(days*(-1)) + " day(s) left"
        return cell
    }
    
    
}
