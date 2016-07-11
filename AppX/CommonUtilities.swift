//
//  CommonUtilities.swift
//  AppX
//
//  Created by Pranay Kumar on 05/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit

func showAlert(title: String = "Alert", message: String, currentView: UIViewController, style: UIAlertControllerStyle = .Alert, actions : UIAlertAction...) {
    let ac : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: style)
    for action in actions{
        ac.addAction(action)
    }
    currentView.presentViewController(ac, animated: true, completion: nil)
}

func isValidNonEmptyEmail(input : String?) -> Bool{
    guard let emailToValidate = input else{
        return false
    }
    return emailToValidate.isEmail
}

func isvalidPassword(input : String?) -> Bool{
    guard let passordToValidate = input else{
        return false
    }
    let alphabetSet = NSCharacterSet.letterCharacterSet()
    let numberSet = NSCharacterSet.decimalDigitCharacterSet()
    let doesContainAlphabets = passordToValidate.rangeOfCharacterFromSet(alphabetSet)
    let doesContainNumbers = passordToValidate.rangeOfCharacterFromSet(numberSet)
    
    if doesContainAlphabets != nil && doesContainNumbers != nil && passordToValidate.length >= Constants.MIN_PASSWORD_LENGTH{
        return true
    }else{
        return false
    }
}

func getViewById(storyBoardIdentifier : String) -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let modalViewController = storyboard.instantiateViewControllerWithIdentifier(storyBoardIdentifier)
    return modalViewController
}

func presentView(currentView: UIViewController, storyBoardIdentifier : String, style: UIModalTransitionStyle, completion: (() -> Void)? = nil){
    let loginViewController = getViewById(storyBoardIdentifier)
    loginViewController.modalTransitionStyle = style
    currentView.presentViewController(loginViewController, animated: true, completion: completion)
}