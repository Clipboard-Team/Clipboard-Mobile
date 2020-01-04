//
//  HomeController.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/3/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    private var project: Project?
    private var currMember: Member?
    override func viewDidLoad() {
        super.viewDidLoad()
        currMember = Constants.currMember
        // Do any additional setup after loading the view.
    }
    
    func setProject(project:Project){
        self.project = project
        self.project?.printEntireProject()
    }

}
