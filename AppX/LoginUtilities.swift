//
//  LoginUtilities.swift
//  AppX
//
//  Created by Pranay Kumar on 05/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit


protocol authenticator {
    func authenticate(username : String, password : String) throws -> User
}

class BasicAuthenticator: authenticator{
    
    
    func authenticate(username: String, password: String) throws -> User {
        var authenticatedUser : User? = nil
        authenticatedUser = User(username: username, name: "User")
        guard let toReturn = authenticatedUser else{
            throw UnauthorizedUser.invalidCredentials
        }
        return toReturn
    }
}


func setUserCredentialsToKeyChain(username : String, password : String){
    let keyChain = KeychainSwift()
    keyChain.set(username, forKey: Constants.USERNAME_KEY)
    keyChain.set(password, forKey: Constants.PASSWORD_KEY)
}

func loginUsingStoredCredentials() throws -> User?{
    var loggedInUser : User? = nil
    let keyChain = KeychainSwift()
    let userName = keyChain.get(Constants.USERNAME_KEY) ?? nil
    let password = keyChain.get(Constants.PASSWORD_KEY) ?? nil
    let userAuthenticator = BasicAuthenticator()
    sleep(1)
    
    guard let tempUsername = userName, let tempPassword = password else{
        return loggedInUser
    }
    
    try loggedInUser = userAuthenticator.authenticate(tempUsername, password: tempPassword)

    return loggedInUser

}

func login(userName : String?, password : String?) throws -> User {
    var loggedInUser : User? = nil
    let userAuthenticator = BasicAuthenticator()
    
    try loggedInUser = userAuthenticator.authenticate(userName!, password: password!)
    
    return loggedInUser!
    
}



