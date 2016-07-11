//
//  MainAppController.swift
//  AppX
//
//  Created by Pranay Kumar on 05/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit

class MainAppController: UIViewController {
    
    var username : String?
    @IBOutlet var userLabel: UILabel!
    var currentUser : User?
    let spinnerC = CustomSpinner(text: Constants.SIGNING_IN_TEXT)
    let keyChain = KeychainSwift()
    
    @IBAction func logoutUser(sender: AnyObject) {
        keyChain.delete(Constants.USERNAME_KEY)
        keyChain.delete(Constants.PASSWORD_KEY)
        presentView(self, storyBoardIdentifier: Constants.LOGIN_VIEW_ID, style: .CoverVertical)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for view in self.view.subviews{
            view.alpha = 0
        }
        self.navigationController!.navigationBarHidden = true
        self.view.addSubview(spinnerC)
        sleep(1)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(currentUser != nil){
            userLabel.text = currentUser?.name
            navigationItem.title = Constants.APP_TITLE
            self.navigationController?.navigationBarHidden = false
            return
        }else{
            
        let tempUsername = self.keyChain.get(Constants.USERNAME_KEY) ?? nil
        let tempPassword = self.keyChain.get(Constants.PASSWORD_KEY) ?? nil
        let userAuthenticator = BasicAuthenticator()
        
        if let userName = tempUsername, let password = tempPassword {
            self.currentUser = userAuthenticator.authenticate(userName, password: password)
            if currentUser != nil {
                for view in self.view.subviews{
                    if let label = view as? UILabel{
                        label.alpha = 1
                    }
                }
                userLabel.text = currentUser?.name
                navigationItem.title = Constants.APP_TITLE
                self.navigationController?.navigationBarHidden = false
                spinnerC.hide()
            }
            else{
                spinnerC.hide()
                presentView(self, storyBoardIdentifier: Constants.LOGIN_VIEW_ID, style: .CrossDissolve)
            }
        }else{
            spinnerC.hide()
            presentView(self, storyBoardIdentifier: Constants.LOGIN_VIEW_ID, style: .CrossDissolve)
        }
        }
        
    }
    
}
