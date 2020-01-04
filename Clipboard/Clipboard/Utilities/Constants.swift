//
//  Constants.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/2/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import Foundation
import UIKit

let h = "icons8-"
let t = "-50"
let mid = [
    "bear",
    "bird",
    "black-jaguar",
    "bull",
    "cat",
    "chicken",
    "cobra",
    "cow",
    "deer",
    "elephant",
    "female-lion",
    "fish",
    "fox",
    "frog",
    "giraffe",
    "gorilla",
    "hamster",
    "hedgehog",
    "hippopotamus",
    "horse",
    "jellyfish",
    "lamb",
    "lion",
    "lizard",
    "llama",
    "mouse-animal",
    "octopus",
    "orangutan",
    "owl",
    "panda",
    "penguin",
    "pig",
    "polar-bear",
    "rabbit",
    "rhinoceros",
    "salamander",
    "shark",
    "snail",
    "snake",
    "squirrel",
    "starfish",
    "turtle",
    "walrus",
    "whale",
    "white-jaguar",
    "wolf"
]

func getIcons()->[Icon]?{
    var icons : [Icon] = []
    for n in 0...mid.count-1 {
        guard let image = UIImage(named: (h+mid[n]+t)) else {return nil}
        let title = mid[n].replacingOccurrences(of: "-", with: " ")
        icons.append(Icon(image: image, title: title))
    }
    return icons
}

struct Constants{
    public static var currProject = Project(title: "Default")
    public static var currMember = Member(name: "Default", role: "Default", team: "Default")
    public static let resetProject = Project(title: "Default")
    public static let resetMember = Member(name: "Default", role: "Default", team: "Default")
    public static let statuses = ["To Do", "In Progress", "Halted", "Done"]
    public static let difficulties = ["Easy", "Medium", "Hard", "Unknown"]
    
    func updateMember(member:Member){
        for mem in (Constants.currProject.getTeam()?.getMembers())! {
            if(member.getName() == mem.getName()){
                
            }
        }
    }
}

