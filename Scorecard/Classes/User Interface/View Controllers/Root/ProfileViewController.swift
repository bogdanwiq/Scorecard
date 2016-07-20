//
//  ProfileViewController.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/18/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController : BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    override func initUI(){
        //Set Background
        self.view.backgroundColor = UIColorFromHex(kBackgroundColor, alpha: 1)
        self.navigationController?.navigationBar.translucent = false
        
        // Navigation Bar - TITLE
        self.title = "Profile"
        self.navigationController?.navigationBar.titleTextAttributes = kNavigationTitleColor
        self.navigationController?.navigationBar.barTintColor = UIColorFromHex(kBackgroundColor, alpha: 1)
        // End Title & Color
        // Buttons left & right
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let image = UIImage(named: "ProfilePicture")
        let profilePicture = ProfilePicture(image: image)
        self.view.addSubview(profilePicture)
    }
}