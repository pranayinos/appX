//
//  Exceptions.swift
//  AppX
//
//  Created by Pranay Kumar on 09/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import Foundation

enum InvalidParameterError: ErrorType{
    case invalidEmail(String)
    case invalidPassword(String)
    case invalidName(String)
    case invalidparam(String)
}