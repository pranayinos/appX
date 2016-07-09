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
    
    init?(name: String?, username: String){
        if username.isEmail {
        dateCreated = NSDate()
        self.name = name!
        self.username = username
        }
        else{
            return nil
        }
    }
}
