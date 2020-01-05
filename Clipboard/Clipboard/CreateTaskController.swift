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

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var difficultyTextField: UITextField!
    @IBOutlet weak var assignedToTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    private var datePickerView: UIDatePicker?
    private var pickerView: UIPickerView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        statusTextField.isUserInteractionEnabled = false
//        difficultyTextField.isUserInteractionEnabled = false
        assignedToTextField.isUserInteractionEnabled = false
        
        datePickerView = UIDatePicker()
        dueDateTextField.inputView = datePickerView
        datePickerView?.datePickerMode = .date
        datePickerView?.addTarget(self, action: #selector(CreateTaskController.dateChanged(datePicker: )), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateTaskController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self
        statusTextField.inputView = pickerView
        difficultyTextField.inputView = pickerView
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
        if(titleTextField.hasText && statusTextField.hasText
            && difficultyTextField.hasText){
            _ = navigationController?.popViewController(animated: true)
            let t = Task(title: titleTextField.text!, status: statusTextField.text!, difficulty: difficultyTextField.text!)
            if(assignedToTextField.hasText){
                for mem in (Constants.currProject.getTeam()?.getMembers())! {
                    if(mem.getName() == Constants.currMember.getName()){
                        t.setAssignedTo(member: mem)
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
        } else{
            print("cant")
        }

    }
    
    
}

extension CreateTaskController: UIPickerViewDataSource, UIPickerViewDelegate {
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
