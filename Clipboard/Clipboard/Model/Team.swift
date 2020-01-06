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
    private var members = [Member]()
    
    init(title:String){
        self.title = title
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
    
    func addTask(task: Task){
        self.tasks.append(task)
    }
    func getTasks()->[Task]{
        return self.tasks
    }
}
