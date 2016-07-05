//
//  LoginUtilities.swift
//  AppX
//
//  Created by Pranay Kumar on 05/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import Foundation


protocol authenticator {
    func authenticate(username : String, password : String) -> Bool
}

class BasicAuthenticator: authenticator{
    func authenticate(username: String, password: String) -> Bool {
        var toReturn : Bool = false
        if username == "user@live.in" && password == "passw0rd"
        {
            toReturn = true
        }
        return toReturn
    }
}

