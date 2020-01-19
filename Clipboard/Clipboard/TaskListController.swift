//
//  TaskListController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/19/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class TaskListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "All Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(IconCell.self, forCellReuseIdentifier: "iconCell")
    }

    @IBAction func filterButtonTapped(_ sender: Any) {
    }
    @IBAction func searchButtonTapped(_ sender: Any) {
    }
}

extension TaskListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
}
