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
    
    override func initUI(){
        //Set Background
        view.backgroundColor = Color.mainBackground
        navigationController?.navigationBar.translucent = false
        
        // Navigation Bar - TITLE
        title = "Profile"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.navigationTitle]
        navigationController?.navigationBar.barTintColor = Color.navigationBackground
        // Buttons left & right
        navigationController?.navigationBar.tintColor = Color.navigationTitle
        
        // Profile image
        let image = UIImage(named: "ProfilePicture")
        let profilePicture = ProfilePicture(image: image)
        profilePicture.frame.origin.x = 94.0
        profilePicture.frame.origin.y = 90.0
        view.addSubview(profilePicture)
        
        // User name
        let nameLabel = UILabel()
        nameLabel.text = "Anonymous User"
        nameLabel.backgroundColor = Color.mainBackground
        nameLabel.textColor = Color.textColor
        nameLabel.frame = CGRectMake(94.0, 252.0, 131.0, 22.0)
        view.addSubview(nameLabel)
        
        // Settings
        let settingsTableView = SettingsTableView()
        settingsTableView.frame = CGRectMake(0.0, 300.0, settingsTableView.frame.width, 286.0)
        view.addSubview(settingsTableView)
        
        // Logout button
        let logoutButton = UIButton(frame: view.frame)
        logoutButton.frame = CGRectMake(107.0, 598.0, 100.0, 40.0)
        logoutButton.setTitle("Logout", forState: .Normal)
        logoutButton.titleLabel?.textAlignment = .Center
        logoutButton.backgroundColor = Color.logoutButtonBackground
        logoutButton.tintColor = Color.textColor
        logoutButton.layer.cornerRadius = 10.0
        logoutButton.clipsToBounds = true
        view.addSubview(logoutButton)
    }
}