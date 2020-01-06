//
//  HomeController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/3/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBAction func addTaskTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromHomeToCreateTask", sender: self)
    }
    @IBAction func viewTaskTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromHomeToEditTask", sender: self)
    }
    @IBAction func manageTapped(_ sender: Any) {
        performSegue(withIdentifier: "fromHomeToManage", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }

}
