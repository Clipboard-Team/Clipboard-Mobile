//
//  ExpandableTask.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/19/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import Foundation

class ExpandableTasks {
    var isExpanded = Bool()
    var tasks = [Task]()
    
    init (isExpanded: Bool, tasks: [Task]){
        self.isExpanded = isExpanded
        self.tasks = tasks
    }
}
