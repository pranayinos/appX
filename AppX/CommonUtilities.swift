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

func isValidEmail(input : String?) -> Bool {
    if input == nil {
        return false
    }
    do {
        let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .CaseInsensitive)
        return regex.firstMatchInString(input!, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, input!.characters.count)) != nil
    } catch {
        return false
    }
}

func getView(storyboardName storyboard : String, storyboardIdentifier : String) -> UIViewController{
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    let viewController = storyboard.instantiateViewControllerWithIdentifier(storyboardIdentifier)
    return viewController
}
