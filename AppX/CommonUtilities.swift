//
//  CommonUtilities.swift
//  AppX
//
//  Created by Pranay Kumar on 05/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit

func showAlertOk(title: String, message: String, currentView: UIViewController) {
    let ac : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
    ac.addAction(okAction)
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

func getViewToPresentModally(storyBoardIdentifier : String) -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let modalViewController = storyboard.instantiateViewControllerWithIdentifier(storyBoardIdentifier)
    return modalViewController
}