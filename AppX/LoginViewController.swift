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
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var usernameFeild: UITextField!
    @IBOutlet var passwordFeild: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var footerLabel: UILabel!

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
            view.alpha = 0
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.spinner.startAnimating()
            var username = ""
            var password = ""
            username = self.keyChain.get("uname-x") ?? ""
            password = self.keyChain.get("passw-x") ?? ""
            let userAuthenticator = BasicAuthenticator()
            guard username == "" && password == "" else
            {
                let isLegitimateUser = userAuthenticator.authenticate(username, password: password)
            
                if (isLegitimateUser != nil) {
                    userAuthenticator.loginUserAndNavigate(self)
                }
                self.spinner.stopAnimating()
                return
            }
            self.animateLabels()
            self.spinner.stopAnimating()
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
            
            showAlertOk("Invalid Email", message: "Please enter a valid email", currentView: self)
            return
            
        } else if isValidNonEmptyEmail(usernameFeild.text){
            
            showAlertOk("Invalid Password", message: "Password must be alphanumeric not less than 6 charcters", currentView: self)
            return
            
        } else {
            
            showAlertOk("Invalid Username & Password", message: "Username should be a valid email & Password must be alphanumeric not less than 6 charcters", currentView: self)
            return
            
        }
    }
    
    func login(){
        spinner.startAnimating()
        let username  = self.usernameFeild.text!
        let password  = self.passwordFeild.text!
        let userAuthenticator = BasicAuthenticator()
        
        let isLegitimateUser = userAuthenticator.authenticate(username, password: password)
            
        if (isLegitimateUser != nil) {
            
            self.keyChain.set(username, forKey: "uname-x")
            self.keyChain.set(password, forKey: "passw-x")
            userAuthenticator.loginUserAndNavigate(self)
                
        }else{
            
            self.usernameFeild.text = ""
            self.passwordFeild.text = ""
            showAlertOk("Authentication Failed", message: "Please check username and password", currentView: self)
        }
        
        self.spinner.stopAnimating()
        
    }

}
