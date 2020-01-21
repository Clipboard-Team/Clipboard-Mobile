//
//  Task.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 12/30/19.
//  Copyright © 2019 Xavier La Rosa. All rights reserved.
//

import Foundation
import UIKit

class Task: Equatable{
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.getTitle() == rhs.getTitle()
    }
    /*
     TODO: ADD IMAGE
     let title = mid[n].replacingOccurrences(of: "-", with: " ")
     **/
    let uuid = UUID().uuidString
    private var title = String()
    private var status = String()
    private var difficulty = String()
    private var description = String()
    private var comments = [Comment]()
    private var totalComments: Int = 0
    private var startDate = Date()
    private var dueDate = Date()
    private var assignedTo: Member?
    
    init(title:String, status:String, difficulty:String) {
        self.title = title
        self.status = status
        self.difficulty = difficulty
        self.startDate = Date.init()
    }
    
    func getUUID() -> String{
        return self.uuid
    }
    
    func setTitle(title:String){
        self.title = title
    }
    
    func getTitle()->String{
        return self.title
    }
    
    func setStatus(status:String){
        self.status = status
    }
    
    func getStatus()->String{
        return self.status
    }
    
    func setDifficulty(difficulty:String){
        self.difficulty = difficulty
    }
    
    func getDifficulty()->String{
        return self.difficulty
    }
    
    func setDescription(description:String){
        self.description = description
    }
    
    func getDescription()->String{
        return self.description
    }
    
    func setStartDate(date:Date){
        self.startDate = date
    }
    
    func getStartDate()->Date{
        return self.startDate
    }
    
    func setDueDate(date:Date){
        self.dueDate = date
    }
    
    func getDueDate()->Date{
        return self.dueDate
    }
    
    func addComment(comment:Comment){
        self.comments.append(comment)
    }
    
    func getComments()->[Comment]{
        return self.comments
    }
    
    func setAssignedTo(member:Member){
        self.assignedTo = member
    }
    
    func getAssignedTo()->Member?{
        guard let assignedTo = self.assignedTo else {
            let title = defaultImgFile.replacingOccurrences(of: "-", with: " ")
            let image = UIImage(named: defaultImgFile)!
            let member = Member(name: "Default", role: "Default", team: "Default")
            member.setIcon(icon: image)
            return member
            
        }
        return assignedTo
    }
    
    func resetAssignedTo(){
        self.assignedTo = nil
    }
}
    
