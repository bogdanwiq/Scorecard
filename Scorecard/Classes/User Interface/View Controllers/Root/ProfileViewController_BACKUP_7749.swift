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
        
        // Buttons left & right
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // Profile image
        let image = UIImage(named: "ProfilePicture")
        let profilePicture = ProfilePicture(image: image)
        profilePicture.frame.origin.x = 94.0
        profilePicture.frame.origin.y = 90.0
        self.view.addSubview(profilePicture)
<<<<<<< HEAD
        
        // User name
        let nameLabel = UILabel()
        nameLabel.text = "Anonymous User"
        nameLabel.backgroundColor = UIColorFromHex(kBackgroundColor)
        nameLabel.textColor = UIColor.lightTextColor()
        nameLabel.frame = CGRectMake(94.0, 252.0, 131.0, 22.0)
        self.view.addSubview(nameLabel)
        
        // Settings
        let settingsTableView = SettingsTableView()
        settingsTableView.frame = CGRectMake(0.0, 300.0, settingsTableView.frame.width, 286.0)
        self.view.addSubview(settingsTableView)
        
        // Logout button
        let logoutButton = LogoutButton()
        logoutButton.frame = CGRectMake(107.0, 598.0, 100.0, 40.0)
        self.view.addSubview(logoutButton)
=======
>>>>>>> daaeca1be86797df66ac504ff55dc6277ddb7753
    }
}