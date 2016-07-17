//
//  Constants.swift
//  AppX
//
//  Created by Pranay Kumar on 11/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import Foundation

struct Constants {
    static let SIGNING_IN_TEXT = "Signing in..."
    static let OK = "Ok"
    
    static let USERNAME_KEY = "uname-x"
    static let PASSWORD_KEY = "passw-x"
    
    static let MIN_PASSWORD_LENGTH = 6
    
    static let MAIN_STORYBOARD_NAME = "Main"
    static let ROOT_NAVIGATION_CONTROLLER_ID = "NavigationRoot"
    static let FIRST_NAVIGATION_CONTROLLER_ID = "welcome"
    
    static let LOGIN_STORYBOARD_NAME = "Login"
    static let LOGIN_VIEW_CONTROLLER_ID = "LoginView"
    
    static let LAUNCH_STORYBOARD_NAME = "LaunchScreen"
    static let LAUNCH_VIEW_NAME = "LaunchScr"
    
    static let LOGIN_VIEW_ID = "LoginView"
    static let MAIN_VIEW_ID = "welcome"
}

enum LoginViewStatus {
    case signingIn
    case loginView
}