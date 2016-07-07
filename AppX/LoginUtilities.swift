//
//  LoginUtilities.swift
//  AppX
//
//  Created by Pranay Kumar on 05/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit


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
    
    func loginUserAndNavigate (currentViewController: LoginViewController){
        
        let nextView = getViewToPresentModally("nav") as! UINavigationController
        let mainView = nextView.viewControllers[0] as! MainAppController
        mainView.username = currentViewController.usernameFeild.text!
        currentViewController.presentViewController(nextView, animated: true, completion: nil)
    }
}

