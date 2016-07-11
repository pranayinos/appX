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
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var usernameFeild: UITextField!
    @IBOutlet var passwordFeild: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var footerLabel: UILabel!
    
    @IBAction func tapAction(sender: AnyObject) {
        view.endEditing(true)
    }

    //On click of loginButton
    @IBAction func loginButton(sender: UIButton) {
        if isValidNonEmptyEmail(usernameFeild.text) && isvalidPassword(passwordFeild.text){
            login(self)
        }else{
            displayAppropriateAlert(usernameFeild.text, passW: passwordFeild.text, currentView: self)
        }
    }
    
    //On return password feild
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if isValidNonEmptyEmail(usernameFeild.text) && isvalidPassword(passwordFeild.text){
            login(self)
        }else{
            displayAppropriateAlert(usernameFeild.text, passW: passwordFeild.text, currentView: self)
        }
        return true
    }

}
