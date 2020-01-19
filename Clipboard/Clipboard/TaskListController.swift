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
    
    
}
