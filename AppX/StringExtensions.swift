//
//  StringExtensions.swift
//  AppX
//
//  Created by Pranay Kumar on 04/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import Foundation

extension String{
    
    var length: Int { return characters.count    }
    
    var isNotBlank: Bool{
        get{
            let trimmed = stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return !trimmed.isEmpty
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
    
    static func getEmptyString() -> String{
        return ""
    }
}