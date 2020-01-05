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

    private var datePickerView: UIDatePicker?
    private var pickerView: UIPickerView?
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
        
        guard let memberNames = Constants.getMemberNames() else {return}
        pickerData.append(memberNames)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        
        datePickerView = UIDatePicker()
        dueDateTextField.inputView = datePickerView
        datePickerView?.datePickerMode = .date
        datePickerView?.addTarget(self, action: #selector(EditTaskController.dateChanged(datePicker: )), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditTaskController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatShort
        startDateLabel.text = dateFormatter.string(from: task.getStartDate())
        titleTextField.text = task.getTitle()
        statusTextField.text = task.getStatus()
        difficultyTextField.text = task.getDifficulty()
        assignedToTextField.text = task.getAssignedTo()?.getName()
        dueDateTextField.text = dateFormatter.string(from: task.getDueDate())
        descriptionTextField.text = task.getDescription()
        
        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self
        
        statusTextField.inputView = pickerView
        difficultyTextField.inputView = pickerView
        assignedToTextField.inputView = pickerView
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatShort
        dueDateTextField.text = dateFormatter.string(from: datePickerView!.date)
        view.endEditing(true)
    }
    @IBAction func resetTapped(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatShort
        startDateLabel.text = dateFormatter.string(from: task.getStartDate())
        titleTextField.text = backupTask.getTitle()
        statusTextField.text = backupTask.getStatus()
        difficultyTextField.text = backupTask.getDifficulty()
        assignedToTextField.text = backupTask.getAssignedTo()?.getName()
        dueDateTextField.text = dateFormatter.string(from: backupTask.getDueDate())
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
                if(assignedToTextField.hasText){
                    for mem in (Constants.currProject.getTeam()?.getMembers())! {
                        if(mem.getName() == assignedToTextField.text){
                            task.setAssignedTo(member: mem)
                            break
                        } else if(assignedToTextField.text == "none"){
                            task.resetAssignedTo()
                            break
                        }
                    }
                }
                guard let date = datePickerView?.date else {return}
                task.setDueDate(date: date)
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
        return self.pickerData[component].count
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
        } else if ((Constants.getMemberNames()?.contains(pickerData[component][row]))!){
            assignedToTextField.text = pickerData[component][row]
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
        guard let date = task.getComments()[indexPath.row].getDate() else {return cell}
        cell.textLabel?.text = comment
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatLong

        cell.detailTextLabel?.text = dateFormatter.string(from: date)
        view.endEditing(true)
        
        return cell
    }
    
    
}
