//
//  MainAppController.swift
//  AppX
//
//  Created by Pranay Kumar on 05/07/16.
//  Copyright © 2016 Pranay Kumar. All rights reserved.
//

import UIKit

class MainAppController: UIViewController {
    
    @IBOutlet var userLabel: UILabel!
    var username : String = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "App X"
        userLabel.text = username
    }
    
}
