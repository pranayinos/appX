//
//  CustomSpinner.swift
//  AppX
//
//  Created by Pranay Kumar on 08/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit

class CustomSpinner: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .Light)
    let vibrancyView: UIVisualEffectView
    
    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
        super.init(coder: aDecoder)!
        self.setup()
        
    }
    
    func setup() {
        contentView.addSubview(vibrancyView)
        vibrancyView.contentView.addSubview(activityIndictor)
        vibrancyView.contentView.addSubview(label)
        activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width:CGFloat = 110.0
            let height: CGFloat = 110.0
            self.frame = CGRectMake(superview.frame.size.width / 2 - width / 2,
                                    superview.frame.height / 2 - height / 2,
                                    width,
                                    height)
            vibrancyView.frame = self.bounds
            
            let activityIndicatorSize: CGFloat = 60
            activityIndictor.frame = CGRectMake(width / 2 - activityIndicatorSize/2, 20,
                                                activityIndicatorSize,
                                                activityIndicatorSize)
            
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            label.textAlignment = NSTextAlignment.Center
            label.frame = CGRectMake(0, activityIndicatorSize + 10, width, height - activityIndicatorSize - 10)
            label.textColor = UIColor.grayColor()
            label.font = UIFont.boldSystemFontOfSize(16)
        }
    }

    func show() {
        self.hidden = false
    }
    
    func hide() {
        self.hidden = true
    }
}