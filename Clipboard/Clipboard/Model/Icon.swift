//
//  Icon.swift
//  Clipboard
//
//  Created by Xavier La Rosa on 1/2/20.
//  Copyright © 2020 Xavier La Rosa. All rights reserved.
//

import Foundation
import UIKit

class Icon{
    private var image = UIImage()
    private var title = String()
    
    init(image:UIImage, title:String){
        self.image = image
        self.title = title
    }
    
    func setImage(image:UIImage){
        self.image = image
    }
    func getImage()->UIImage {
        return image
    }
    
    func setTitle(title:String){
        self.title = title
    }
    func getTitle()->String?{
        return title
    }
}
