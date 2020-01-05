//
//  EditTaskController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/4/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class EditTaskController: UIViewController {
    private var task = Task(title: "Default", status: "Default", difficulty: "Default")
    private var backupTask = Task(title: "Default", status: "Default", difficulty: "Default")
    private var pickerData = [Constants.statuses, Constants.difficulties]

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var difficultyTextField: UITextField!
    @IBOutlet weak var assignedToTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    func setTask(task:Task){
        self.task = task
        self.backupTask = task
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        
        startDateLabel.text = task.getStartDate().description
        titleTextField.text = task.getTitle()
        statusTextField.text = task.getStatus()
        difficultyTextField.text = task.getDifficulty()
        assignedToTextField.text = task.getAssignedTo()?.getName()
        dueDateTextField.text = task.getDueDate().description
        descriptionTextField.text = task.getDescription()
        
//        statusTextField.isUserInteractionEnabled = false
//        difficultyTextField.isUserInteractionEnabled = false
        assignedToTextField.isUserInteractionEnabled = false
        dueDateTextField.isUserInteractionEnabled = false
        
        pickerView.delegate = self
        pickerView.dataSource = self
        statusTextField.inputView = pickerView
        difficultyTextField.inputView = pickerView
    }
    @IBAction func resetTapped(_ sender: Any) {
        startDateLabel.text = backupTask.getStartDate().description
        titleTextField.text = backupTask.getTitle()
        statusTextField.text = backupTask.getStatus()
        difficultyTextField.text = backupTask.getDifficulty()
        assignedToTextField.text = backupTask.getAssignedTo()?.getName()
        dueDateTextField.text = backupTask.getDueDate().description
        descriptionTextField.text = backupTask.getDescription()
        commentTextField.text = ""
    }
    @IBAction func editTapped(_ sender: Any) {
        guard let tasks = Constants.currProject.getTeam()?.getTasks() else {return}
        for task in tasks {
            if(task.getTitle() == backupTask.getTitle()){
                task.setTitle(title: titleTextField.text ?? "")
                task.setStatus(status: statusTextField.text!)
                task.setDifficulty(difficulty: difficultyTextField.text!)
                //task.setAssignedTo(member: )
                //task.setDueDate(date: )
                task.setDescription(description: descriptionTextField.text ?? "")
                
                if(commentTextField.hasText){
                    task.addComment(comment: Comment(comment: commentTextField.text!))
                }
            }
        }
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func deleteTapped(_ sender: Any) {
        
    }
    
    
}
extension EditTaskController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.pickerData.count
    }
    

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        if(Constants.statuses.contains(pickerData[component][row]) ){
            statusTextField.text = pickerData[component][row]
        } else if (Constants.difficulties.contains(pickerData[component][row])){
            difficultyTextField.text = pickerData[component][row]
        }
    }
    
}
extension EditTaskController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.getComments().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "commentCell")

        guard let comment = task.getComments()[indexPath.row].getComment() else {return cell}
        guard let date = task.getComments()[indexPath.row].getDate()?.description else {return cell}
        cell.textLabel?.text = comment
        cell.detailTextLabel?.text = date
        
        return cell
    }
    
    
}
