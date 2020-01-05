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
        
        startDateLabel.text = task.getStartDate().description
        titleTextField.text = task.getTitle()
        statusTextField.text = task.getStatus()
        difficultyTextField.text = task.getDifficulty()
        assignedToTextField.text = task.getAssignedTo().getName()
        dueDateTextField.text = task.getDueDate().description
        descriptionTextField.text = task.getDescription()
        
        statusTextField.isUserInteractionEnabled = false
        difficultyTextField.isUserInteractionEnabled = false
        assignedToTextField.isUserInteractionEnabled = false
    }
    @IBAction func resetTapped(_ sender: Any) {
    }
    @IBAction func editTapped(_ sender: Any) {
    }
    @IBAction func deleteTapped(_ sender: Any) {
    }
    
    
}

extension EditTaskController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
