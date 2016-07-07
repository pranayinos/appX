//
//  CommonUtilities.swift
//  AppX
//
//  Created by Pranay Kumar on 05/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit

func showAlertOk(title : String, message : String) -> UIAlertController{
    let ac : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
    ac.addAction(okAction)
    
    return ac
}

func isValidNonEmptyEmail(input : String?) -> Bool{
    guard let emailToValidate = input else{
        return false
    }
    return emailToValidate.isEmail
}

func getViewToPresentModally(storyBoardIdentifier : String) -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let modalViewController = storyboard.instantiateViewControllerWithIdentifier(storyBoardIdentifier)
    modalViewController.modalPresentationStyle = UIModalPresentationStyle.FullScreen
    modalViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
    return modalViewController
}

