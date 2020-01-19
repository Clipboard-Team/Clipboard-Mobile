//
//  Team.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 12/30/19.
//  Copyright © 2019 Xavier La Rosa. All rights reserved.
//

import Foundation

class Team{
    private var title = String()
    private var description = String()
    private var tasks = [Task]()
    private var toDoTasks = [Task]()
    private var inProgressTasks = [Task]()
    private var haltedTasks = [Task]()
    private var doneTasks = [Task]()
    private var members = [Member]()
    
    init(title:String){
        self.title = title
        
//        guard let index = orders.firstIndex(of: videoID) else { return }
//        orders.remove(at: index)
    }
    
    func addTask(task: Task){
        switch task.getStatus() {
        case "To Do":
            toDoTasks.append(task)
            break
        case "In Progress":
            inProgressTasks.append(task)
            break
        case "Halted":
            haltedTasks.append(task)
            break
        case "Done":
            doneTasks.append(task)
            break
        default:
            break
        }
        
        self.tasks.append(task)
    }
    
    func moveTask(task: Task, newStatus: String){
        if(Constants.statuses.contains(newStatus) && task.getStatus() != newStatus){
            print("can move task")
            task.setStatus(status: newStatus)
            updateTasks(tasks: self.toDoTasks, status: Constants.statuses[0])
            updateTasks(tasks: self.inProgressTasks, status: Constants.statuses[1])
            updateTasks(tasks: self.haltedTasks, status: Constants.statuses[2])
            updateTasks(tasks: self.doneTasks, status: Constants.statuses[3])
        }
    }
    
    func deleteTask(task: Task){
        if(Constants.statuses.contains(task.getStatus())){
            switch task.getStatus() {
            case Constants.statuses[0]:
                guard let index = toDoTasks.firstIndex(of: task) else { return }
                self.toDoTasks.remove(at: index)
                break
            case Constants.statuses[1]:
                guard let index = inProgressTasks.firstIndex(of: task) else { return }
                self.inProgressTasks.remove(at: index)
                break
            case Constants.statuses[2]:
                guard let index = haltedTasks.firstIndex(of: task) else { return }
                self.haltedTasks.remove(at: index)
                break
            case Constants.statuses[3]:
                guard let index = doneTasks.firstIndex(of: task) else { return }
                self.doneTasks.remove(at: index)
                break
            default:
                break
            }
            
            guard let index = tasks.firstIndex(of: task) else { return }
            self.tasks.remove(at: index)
        }
    }
    
    func updateTasks(tasks: [Task], status: String){
        for t in tasks {
            if(t.getStatus() != status){
                switch t.getStatus() {
                case "To Do":
                    guard let index = tasks.firstIndex(of: t) else { return }
                    self.tasks.remove(at: index)
                    self.toDoTasks.append(t)
                    break
                case "In Progress":
                    guard let index = tasks.firstIndex(of: t) else { return }
                    self.tasks.remove(at: index)
                    self.inProgressTasks.append(t)
                    break
                case "Halted":
                    guard let index = tasks.firstIndex(of: t) else { return }
                    self.tasks.remove(at: index)
                    self.haltedTasks.append(t)
                    break
                case "Done":
                    guard let index = tasks.firstIndex(of: t) else { return }
                    self.tasks.remove(at: index)
                    self.doneTasks.append(t)
                    break
                default:
                    break
                }
            }
        }
    }
    
    func getTasks()->[Task]{
        return self.tasks
    }
    
    func getToDoTasks()->[Task]{
        return self.toDoTasks
    }
    
    func getInProgressTasks()->[Task]{
        return self.inProgressTasks
    }
    
    func getHaltedTasks()->[Task]{
        return self.haltedTasks
    }
    
    func getDoneTasks()->[Task]{
        return self.doneTasks
    }
    
    func setTitle(title:String){
        self.title = title
    }
    
    func getTitle()->String{
        return title
    }
    
    func setDescription(description: String){
        self.description = description
    }
    
    func getDescription() -> String?{
        return self.description
    }
    
    func doesMemberAlreadyExist(member: Member) -> Bool{
        for mem in members{
            if(mem.getName() == member.getName()){
                return true
            }
        }
        return false
    }
    
    func addMember(member:Member){
        members.append(member)
    }
    
    func getMembers()->[Member]{
        return members
    }
    
    func removeMember(member:Member){
    }
}
