//
//  CreateTaskController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/4/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class CreateTaskController: UIViewController {
    private var pickerData = [Constants.statuses, Constants.difficulties]
    private var datePickerView: UIDatePicker?
    private var pickerView: UIPickerView?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var difficultyTextField: UITextField!
    @IBOutlet weak var assignedToTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var createTaskButton: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Task"
        titleLabel.textColor = UIColor.white
        mainView.backgroundColor = UIColor.purple
        titleTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.white, placeholderText: "What is the task?")
        statusTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.white, placeholderText: "Status")
        difficultyTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.white, placeholderText: "Difficulty")
        
        assignedToTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.white, placeholderText: "Assigned To")
        
        dueDateTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.white, placeholderText: "Optional Due Date")
        
        descriptionTextField.createBottomBorderTextField(borderColor: UIColor.lightGray, width: 0.5, fontColor: UIColor.white, placeholderText: "Optional Description")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateTaskController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        guard let memberNames = Constants.getMemberNames() else {return}
        pickerData.append(memberNames)
        
        datePickerView = UIDatePicker()
        dueDateTextField.inputView = datePickerView
        datePickerView?.datePickerMode = .date
        datePickerView?.addTarget(self, action: #selector(CreateTaskController.dateChanged(datePicker: )), for: .valueChanged)
        
        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self
        
        statusTextField.inputView = pickerView
        difficultyTextField.inputView = pickerView
        assignedToTextField.inputView = pickerView
        
        createTaskButton.createStandardFullButton(color: UIColor.white, fontColor: UIColor.purple)
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
    
    @IBAction func createTaskTapped(_ sender: Any) {
        if(titleTextField.hasText
            && statusTextField.hasText
            && difficultyTextField.hasText){
                    
            let t = Task(
                title: titleTextField.text!,
                status: statusTextField.text!,
                difficulty: difficultyTextField.text!)
            
            if(assignedToTextField.hasText){
                for mem in (Constants.currProject.getTeam()?.getMembers())! {
                    if(mem.getName() == assignedToTextField.text){
                        t.setAssignedTo(member: mem)
                        break
                    } else if(assignedToTextField.text == "none"){
                        t.resetAssignedTo()
                        break
                    }
                }
            }
            
            if(descriptionTextField.hasText){
                t.setDescription(description: descriptionTextField.text!)
            }
            
            if(dueDateTextField.hasText){
                t.setDueDate(date: datePickerView!.date)
            }
            
            Constants.currProject.getTeam()?.addTask(task: t)
            print("added new task")
            Constants.currProject.printEntireProject()
            dismiss(animated: true, completion: nil)
        } else{
        }

    }
    
    
}

extension CreateTaskController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(Constants.statuses.contains(pickerData[component][row]) ){
            statusTextField.text = pickerData[component][row]
        } else if (Constants.difficulties.contains(pickerData[component][row])){
            difficultyTextField.text = pickerData[component][row]
        } else if ((Constants.getMemberNames()?.contains(pickerData[component][row]))!){
                   assignedToTextField.text = pickerData[component][row]
        }
    }
    
}
