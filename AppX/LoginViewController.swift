//
//  LoginViewController.swift
//  AppX
//
//  Created by Pranay Kumar on 04/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let gradientLayer = CAGradientLayer()
    let keyChain = KeychainSwift()
    @IBOutlet var appXLabel: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureGradientBackground(UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1.0).CGColor, UIColor.whiteColor().CGColor)
        
     }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if status == nil || status == LoginViewStatus.signingIn{
            displaySigningInScreen()
           
        }else{
            displayLoginScreen()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func displaySigningInScreen() {
        self.view.addSubview(cSpinner)
        self.appXLabel.alpha = 0
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
            self.usernameFeild.alpha = 1
            self.passwordFeild.alpha = 1
            self.loginButton.alpha = 1
            self.footerLabel.alpha = 1
        })
        cSpinner.hide()
    }
    
    func configureGradientBackground(colors:CGColorRef...){
        
        let gradient: CAGradientLayer = CAGradientLayer()
        let maxWidth = max(self.view.bounds.size.height,self.view.bounds.size.width)
        let squareFrame = CGRect(origin: self.view.bounds.origin, size: CGSizeMake(maxWidth, maxWidth))
        gradient.frame = squareFrame
        
        gradient.colors = colors
        view.layer.insertSublayer(gradient, atIndex: 0)
    }
}
