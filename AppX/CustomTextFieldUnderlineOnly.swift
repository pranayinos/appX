//
//  CustomTextFeild.swift
//  AppX
//
//  Created by Pranay Kumar on 05/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit

class CustomTextFieldUnderlineOnly: UITextField {
        override func drawRect(rect: CGRect) {
        
        let startingPoint   = CGPoint(x: rect.minX, y: rect.maxY)
        let endingPoint     = CGPoint(x: rect.maxX, y: rect.maxY)
        let strokeColor     = UIColor.whiteColor()
        let path = UIBezierPath()
        
        path.moveToPoint(startingPoint)
        path.addLineToPoint(endingPoint)
        path.lineWidth = 1.0
        strokeColor.setStroke()
        tintColor.CGColor
        
        path.stroke()
    }
}
