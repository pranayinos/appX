//
//  LoginViewController.swift
//  AppX
//
//  Created by Pranay Kumar on 04/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBAction func tapAction(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBOutlet var usernameFeild: UITextField!
    @IBOutlet var passwordFeild: UITextField!

    @IBAction func loginButton(sender: UIButton) {
        
        
        guard isValidNonEmptyEmail(usernameFeild.text) else {
            let alert = showAlertRetry("Invalid Email", message: "Please enter a valid email")
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        login()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField === passwordFeild){
            login()
        }
        return true
    }
    
    func login(){
        spinner.startAnimating()
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            let userAuthenticator = BasicAuthenticator()
            let isLegitimateUser = userAuthenticator.authenticate(self.usernameFeild.text!, password: self.passwordFeild.text!)
            
            if isLegitimateUser {
                let nextView = getViewToPresentModally("welcome")
                self.presentViewController(nextView, animated: true, completion: nil)
                
                // self.usernameFeild.text = "Success"
            }else{
                self.usernameFeild.text = ""
                self.passwordFeild.text = ""
                let alert = showAlertRetry("Authentication Failed", message: "Please check username and password")
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            self.spinner.stopAnimating()
            
        })

    }
}
