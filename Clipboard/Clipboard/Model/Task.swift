//
//  Task.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 12/30/19.
//  Copyright © 2019 Xavier La Rosa. All rights reserved.
//

import Foundation

class Task{
    private var title = String()
    private var status = String()
    private var difficulty = String()
    private var description = String()
    private var comments = [Comment]()
    private var totalComments: Int = 0
    private var startDate = Date()
    private var dueDate = Date()
    private var assignedTo: Member?
}
    
