//
//  LoginUtilities.swift
//  AppX
//
//  Created by Pranay Kumar on 05/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit


protocol authenticator {
    func authenticate(username : String, password : String) -> User?
}

class BasicAuthenticator: authenticator{
    func authenticate(username: String, password: String) -> User? {
        var toReturn : User? = nil
        if username == "user@live.in" && password == "passw0rd"
        {
            toReturn = User(name: "User", username: username)
        }
        return toReturn
    }
    
    func loginUserAndNavigate (currentViewController: LoginViewController){
        currentViewController.dismissViewControllerAnimated(true, completion: {
            let mainView = getViewToPresentModally("welcome") as! MainAppController
             mainView.username = currentViewController.usernameFeild.text!
            
        })
    }
}

func getLoginViewToPresent() -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let modalViewController = storyboard.instantiateViewControllerWithIdentifier("loginView")
    modalViewController.modalPresentationStyle = UIModalPresentationStyle.FullScreen
    return modalViewController
}

