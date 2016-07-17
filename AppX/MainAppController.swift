//
//  MainAppController.swift
//  AppX
//
//  Created by Pranay Kumar on 05/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit

class MainAppController: UIViewController {
    
    var currentUser : User?
    let keyChain = KeychainSwift()
    
    @IBAction func logoutUser(sender: AnyObject) {
        keyChain.delete(Constants.USERNAME_KEY)
        keyChain.delete(Constants.PASSWORD_KEY)
        let view = getView(storyboardName: Constants.LOGIN_STORYBOARD_NAME, storyboardIdentifier: Constants.LOGIN_VIEW_ID) as! LoginViewController
        self.presentViewController(view, animated: true, completion: {
            view.status = LoginViewStatus.signingIn
        })
    }
   
    @IBOutlet var userLabel: UILabel!
    var username : String = String.getEmptyString()
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
}
