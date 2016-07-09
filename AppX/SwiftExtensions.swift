//
//  SwiftExtensions.swift
//  AppX
//
//  Created by Pranay Kumar on 04/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import Foundation

extension String{
    var isNotBlank: Bool{
        get{
            let trimmed = stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return !trimmed.isEmpty
        }
    }
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .CaseInsensitive)
            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool{
        let alphabetSet = NSCharacterSet.letterCharacterSet()
        let numberSet = NSCharacterSet.decimalDigitCharacterSet()
        let doesContainAlphabets = self.rangeOfCharacterFromSet(alphabetSet)
        let doesContainNumbers = self.rangeOfCharacterFromSet(numberSet)
        
        if doesContainAlphabets != nil && doesContainNumbers != nil {
            return true
        }else{
            return false
        }
    }
    
    var doesContainOnlyAlphabets: Bool{
        let alphabetSet = NSCharacterSet.letterCharacterSet()
        let doesContainAlphabets = self.rangeOfCharacterFromSet(alphabetSet)
    
        if doesContainAlphabets != nil{
            return true
        }else{
            return false
        }

    }
}