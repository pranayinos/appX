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
    
    @IBOutlet var appXLabel: UILabel!
 
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBAction func tapAction(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBOutlet var usernameFeild: UITextField!
    @IBOutlet var passwordFeild: UITextField!

    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var footerLabel: UILabel!
    @IBAction func loginButton(sender: UIButton) {
        
        if isValidNonEmptyEmail(usernameFeild.text) && isvalidPassword(passwordFeild.text){
            login()
        }else if isvalidPassword(passwordFeild.text){
            let alert = showAlertOk("Invalid Email", message: "Please enter a valid email")
            self.presentViewController(alert, animated: true, completion: nil)
            return
        } else if isValidNonEmptyEmail(usernameFeild.text){
            let alert = showAlertOk("Invalid Password", message: "Password must be alphanumeric not less than 6 charcters")
            self.presentViewController(alert, animated: true, completion: nil)
            return
        } else {
            let alert = showAlertOk("Invalid Username & Password", message: "Username should be a valid email & Password must be alphanumeric not less than 6 charcters")
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField === passwordFeild){
            if isValidNonEmptyEmail(usernameFeild.text) && isvalidPassword(passwordFeild.text){
                login()
            }else if isvalidPassword(passwordFeild.text){
                let alert = showAlertOk("Invalid Email", message: "Please enter a valid email")
                self.presentViewController(alert, animated: true, completion: nil)
                return true
            } else if isValidNonEmptyEmail(usernameFeild.text){
                let alert = showAlertOk("Invalid Password", message: "Password must be alphanumeric not less than 6 charcters")
                self.presentViewController(alert, animated: true, completion: nil)
                return true
            } else {
                let alert = showAlertOk("Invalid Username & Password", message: "Username should be a valid email & Password must be alphanumeric not less than 6 charcters")
                self.presentViewController(alert, animated: true, completion: nil)
                return true
            }

        }
        return true
    }
    
    func login(){
        spinner.startAnimating()
          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            let username  = self.usernameFeild.text!
            let password  = self.passwordFeild.text!
            let userAuthenticator = BasicAuthenticator()
            let isLegitimateUser = userAuthenticator.authenticate(username, password: password)
            
            if isLegitimateUser {
            
                self.keyChain.set(username, forKey: "uname-x")
                self.keyChain.set(password, forKey: "passw-x")
                userAuthenticator.loginUserAndNavigate(self)
                
            }else{
                self.usernameFeild.text = ""
                self.passwordFeild.text = ""
                let alert = showAlertOk("Authentication Failed", message: "Please check username and password")
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            self.spinner.stopAnimating()
        })

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        appXLabel.alpha = 0
        subtitleLabel.alpha = 0
        usernameFeild.alpha = 0
        passwordFeild.alpha = 0
        loginButton.alpha = 0
        footerLabel.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.spinner.startAnimating()
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            var username = ""
            var password = ""
            username = self.keyChain.get("uname-x") ?? ""
            password = self.keyChain.get("passw-x") ?? ""
            let userAuthenticator = BasicAuthenticator()
            guard username == "" && password == "" else
            {
                let isLegitimateUser = userAuthenticator.authenticate(username, password: password)
            
                if isLegitimateUser {
                    userAuthenticator.loginUserAndNavigate(self)
                }
                self.spinner.stopAnimating()
                return
            }
            self.animateLabels()
            self.spinner.stopAnimating()
        })
    }
    
    func animateLabels(){
        UIView.animateWithDuration(0.5, animations: {
            self.appXLabel.alpha = 1
            self.subtitleLabel.alpha = 1
            self.usernameFeild.alpha = 1
            self.passwordFeild.alpha = 1
            self.loginButton.alpha = 1
            self.footerLabel.alpha = 1

        })
    }

}
