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
        toReturn = User(name: "User", username: username)
        return toReturn
    }
    
    func loginUserAndNavigate (currentViewController: LoginViewController){
        currentViewController.dismissViewControllerAnimated(true, completion: {
            let mainView = getViewById(Constants.MAIN_VIEW_ID) as! MainAppController
             mainView.username = currentViewController.usernameFeild.text!
            
        })
    }
}

func displayAppropriateAlert(uName: String?, passW: String?, currentView: UIViewController) {
    let okAction = UIAlertAction(title: ErrorsMessages.OK, style: .Default, handler: nil)
    
    if !isvalidPassword(passW) && !isValidNonEmptyEmail(uName){
        showAlert(ErrorsMessages.INVALID_USERNAME_PASSWORD_TITLE, message: ErrorsMessages.INVALID_USERNAME_PASSWORD_MESSAGE, currentView: currentView, style: .Alert, actions: okAction)
        return
    }else if !isvalidPassword(passW){
        showAlert(ErrorsMessages.INVALID_PASSWORD_TITLE, message: ErrorsMessages.INVALID_PASSWORD_MESSAGE, currentView: currentView, style: .Alert, actions: okAction)
        return
        
    } else {
        showAlert(ErrorsMessages.INVALID_USERNAME_TITLE, message: ErrorsMessages.INVALID_USERNAME_MESSAGE, currentView: currentView, style: .Alert, actions: okAction)
        return
    }
}

func login(loginView : LoginViewController){
    let username  = loginView.usernameFeild.text!
    let password  = loginView.passwordFeild.text!
    let userAuthenticator = BasicAuthenticator()
    
    let isLegitimateUser = userAuthenticator.authenticate(username, password: password)
    
    if (isLegitimateUser != nil) {
        loginView.keyChain.set(username, forKey: Constants.USERNAME_KEY)
        loginView.keyChain.set(password, forKey: Constants.PASSWORD_KEY)
        userAuthenticator.loginUserAndNavigate(loginView)
        
    }else{
        let okAction = UIAlertAction(title: ErrorsMessages.OK, style: .Default, handler: nil)
        showAlert(ErrorsMessages.INVALID_CREDENTIALS_TITLE, message: ErrorsMessages.INVALID_CREDENTIALS_MESSAGE, currentView: loginView, style: .Alert, actions: okAction)
        loginView.usernameFeild.text = String.getEmptyString()
        loginView.passwordFeild.text = String.getEmptyString()
    }
}

