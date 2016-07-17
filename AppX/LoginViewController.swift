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
    let cSpinner = CustomSpinner(text: Constants.SIGNING_IN_TEXT)
    var currentUser : User? = nil
    var status: LoginViewStatus? = nil

    @IBAction func tapAction(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func loginButton(sender: UIButton) {
        guard isValidEmail(usernameFeild.text) else{
            let okAction = UIAlertAction(title: Constants.OK , style: .Cancel, handler: nil)
            showAlert(ErrorMessages.INVALID_USERNAME_TITLE, message: ErrorMessages.INVALID_USERNAME_MESSAGE, currentView: self, actions: okAction)
            return
        }
        guard isvalidPassword(passwordFeild.text) else{
            let okAction = UIAlertAction(title: Constants.OK, style: .Cancel, handler: nil)
            showAlert(ErrorMessages.INVALID_PASSWORD_TITLE, message: ErrorMessages.INVALID_PASSWORD_MESSAGE, currentView: self, actions: okAction)
            return
        }
        
        do{
            
            try login(usernameFeild.text, password: passwordFeild.text)
            self.dismissViewControllerAnimated(true, completion: nil)
            setUserCredentialsToKeyChain(usernameFeild.text!, password: passwordFeild.text!)
        
        }catch UnauthorizedUser.invalidCredentials {
            let okAction = UIAlertAction(title: Constants.OK, style: .Cancel, handler: nil)
            showAlert(ErrorMessages.INVALID_CREDENTIALS_TITLE, message: ErrorMessages.INVALID_CREDENTIALS_MESSAGE, currentView: self, actions: okAction)
            return
        } catch let error as NSError{
            print("error: \(error)")
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        view.addSubview(cSpinner)
        if status == nil || status == LoginViewStatus.signingIn{
            displaySigningInScreen()
            do{
                let user = try loginUsingStoredCredentials()
                if user != nil{
                    self.dismissViewControllerAnimated(false, completion: nil)
                }
            }catch UnauthorizedUser.invalidCredentials{
                
                let okAction = UIAlertAction(title: Constants.OK, style: .Cancel, handler: {(alert: UIAlertAction!) in self.status = LoginViewStatus.loginView})
                showAlert(ErrorMessages.EXPIRED_CREDENTIALS_TITLE, message: ErrorMessages.EXPIRED_CREDENTIALS_MESSAGE, currentView: self, actions: okAction)
                
            } catch let error as NSError{
                print("error: \(error)")
            }
        }
        self.status = LoginViewStatus.signingIn
        displayLoginScreen()

    }
    
    func displaySigningInScreen() {
        self.appXLabel.alpha = 0
        self.subtitleLabel.alpha = 0
        self.usernameFeild.alpha = 0
        self.passwordFeild.alpha = 0
        self.loginButton.alpha = 0
        self.footerLabel.alpha = 0
        UIView.animateWithDuration(0.5, animations: {
            self.appXLabel.alpha=1
            self.footerLabel.alpha = 1
        })
    }
    
    func displayLoginScreen() {
        UIView.animateWithDuration(0.5, animations: {
            self.cSpinner.alpha = 0
            self.appXLabel.alpha = 1
            self.subtitleLabel.alpha = 1
            self.usernameFeild.alpha = 1
            self.passwordFeild.alpha = 1
            self.loginButton.alpha = 1
            self.footerLabel.alpha = 1
        })
        cSpinner.hide()
    }
}
