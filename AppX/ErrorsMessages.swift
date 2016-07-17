//
//  Errors.swift
//  AppX
//
//  Created by Pranay Kumar on 11/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import Foundation

struct ErrorMessages {
    static let INVALID_PASSWORD_TITLE = "Invalid Password"
    static let INVALID_PASSWORD_MESSAGE = "Password must be alphanumeric not less than \(Constants.MIN_PASSWORD_LENGTH) charcters"
    static let INVALID_USERNAME_TITLE = "Invalid Username"
    static let INVALID_USERNAME_MESSAGE = "Please enter a valid email as username"
    static let INVALID_USERNAME_PASSWORD_TITLE = "Invalid Username & Password"
    static let INVALID_USERNAME_PASSWORD_MESSAGE = "Username should be a valid email & Password must be alphanumeric not less than \(Constants.MIN_PASSWORD_LENGTH) charcters"
    static let INVALID_CREDENTIALS_TITLE = "Authentication Failed"
    static let INVALID_CREDENTIALS_MESSAGE = "Please check username and password & Try Again"
    static let EXPIRED_CREDENTIALS_TITLE = "Login Again"
    static let EXPIRED_CREDENTIALS_MESSAGE = "Old Password Expired, Please enter new password"
}