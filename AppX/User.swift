//
//  User.swift
//  AppX
//
//  Created by Pranay Kumar on 09/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import Foundation

class User {
    
    var username : String
    var name : String
    let dateCreated : NSDate
    
    init(username: String, name: String){
        self.username = username
        self.name = name
        self.dateCreated = NSDate()
    }
}
