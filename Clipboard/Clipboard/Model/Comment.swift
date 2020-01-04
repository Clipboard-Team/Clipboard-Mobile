//
//  Comment.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/2/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import Foundation

class Comment {
    private var comment = String()
    private var date = Date()
    
    init(comment:String){
        self.comment = comment
        self.date = Date.init()
    }
    
    func setComment(comment:String){
        self.comment = comment
    }
    
    func getComment()->String?{
        return comment
    }
    
    func setDate(date:Date){
        self.date = date
    }
    
    func getDate()->Date?{
        return date
    }
}
