//
//  LoginViewController.swift
//  AppX
//
//  Created by Pranay Kumar on 04/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    let keyChain = KeychainSwift()
    
    //let createLoginButtonTag = 0
    //let loginButtonTag = 1
    @IBOutlet var appXLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var usernameFeild: UITextField!
    @IBOutlet var passwordFeild: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var footerLabel: UILabel!
    let cSpinner = CustomSpinner(text: Constants.SIGNING_IN_TEXT)

    @IBAction func tapAction(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func loginButton(sender: UIButton) {
        loginOrDisplayAlerts()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if(textField === passwordFeild){
           loginOrDisplayAlerts()
        }
        return true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        for view in self.view.subviews {
            view.alpha = 1
        }
        view.addSubview(cSpinner)
        cSpinner.hide()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var username = ""
        var password = ""
        username = self.keyChain.get(Constants.USERNAME_KEY) ?? ""
        password = self.keyChain.get(Constants.PASSWORD_KEY) ?? ""
        let userAuthenticator = BasicAuthenticator()
        guard username == "" && password == "" else
        {
            let isLegitimateUser = userAuthenticator.authenticate(username, password: password)
            
            if (isLegitimateUser != nil) {
                    userAuthenticator.loginUserAndNavigate(self)
            }
            return
        }
        //self.animateLabels()
    }
    
    func animateLabels(){
        UIView.animateWithDuration(1, animations: {
            for view in self.view.subviews {
                view.alpha = 1
            }
        })
    }
    
    func loginOrDisplayAlerts(){
        if isValidNonEmptyEmail(usernameFeild.text) && isvalidPassword(passwordFeild.text){
            
            login()
            
        }else if isvalidPassword(passwordFeild.text){
            
            showAlertOk(Errors.INVALID_USERNAME_TITLE, message: Errors.INVALID_USERNAME_MESSAGE, currentView: self)
            return
            
        } else if isValidNonEmptyEmail(usernameFeild.text){
        
            showAlertOk(Errors.INVALID_PASSWORD_TITLE, message: Errors.INVALID_PASSWORD_MESSAGE, currentView: self)
            return
            
        } else {
            
            showAlertOk(Errors.INVALID_USERNAME_PASSWORD_TITLE, message: Errors.INVALID_USERNAME_PASSWORD_MESSAGE, currentView: self)
            return
            
        }
    }
    
    func login(){
        cSpinner.show()
        let username  = self.usernameFeild.text!
        let password  = self.passwordFeild.text!
        let userAuthenticator = BasicAuthenticator()
        
        let isLegitimateUser = userAuthenticator.authenticate(username, password: password)
            
        if (isLegitimateUser != nil) {
            cSpinner.hide()
            self.keyChain.set(username, forKey: Constants.USERNAME_KEY)
            self.keyChain.set(password, forKey: Constants.PASSWORD_KEY)
            userAuthenticator.loginUserAndNavigate(self)
                
        }else{
            cSpinner.hide()
            self.usernameFeild.text = String.getEmptyString()
            self.passwordFeild.text = String.getEmptyString()
            showAlertOk(Errors.INVALID_CREDENTIALS_TITLE, message: Errors.INVALID_CREDENTIALS_MESSAGE, currentView: self)
        }
        cSpinner.hide()
        
    }

}
