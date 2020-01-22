//
//  Member.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 12/30/19.
//  Copyright © 2019 Xavier La Rosa. All rights reserved.
//

import Foundation
import UIKit

class Member{
    let uuid = UUID().uuidString
    private var name = String()
    private var role = String()
    private var team = String()
    private var icon = UIImage()
    
    init(name: String, role: String, team: String){
        self.name = name
        self.role = role
        self.team = team
    }
    
    func getUUID() -> String{
        return self.uuid
    }
    
    func setName(name: String){
        self.name = name
    }
    func getName() -> String {
        return name
    }
    
    func setRole(role: String){
        self.role = role
    }
    func getRole() -> String{
        return role
    }
    
    func setTeam(team: String){
        self.team = team
    }
    func getTeam() -> String{
        return team
    }
    
    func setIcon(icon:UIImage){
        self.icon = icon
    }
    func getIcon()->UIImage{
        return icon
    }
}
