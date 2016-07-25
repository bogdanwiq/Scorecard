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
    
    var profilePicture: ProfilePicture!
    var nameLabel: UILabel!
    var settingsTableView: SettingsTableView!
    var logoutButton: UIButton!
    
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
        profilePicture = ProfilePicture(image: image)
        //profilePicture.frame.origin.x = 94.0
            //profilePicture.frame.origin.y = 90.0
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profilePicture)
        
        // User name
        nameLabel = UILabel()
        nameLabel.text = "Anonymous User"
        nameLabel.backgroundColor = Color.mainBackground
        nameLabel.textColor = Color.textColor
            //nameLabel.frame = CGRectMake(94.0, 252.0, 131.0, 22.0)
        nameLabel.textAlignment = .Center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        // Settings
        settingsTableView = SettingsTableView()
            //settingsTableView.frame = CGRectMake(0.0, 300.0, settingsTableView.frame.width, 286.0)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsTableView)
        
        // Logout button
        logoutButton = UIButton(frame: view.frame)
            //logoutButton.frame = CGRectMake(107.0, 598.0, 100.0, 40.0)
        logoutButton.setTitle("Logout", forState: .Normal)
        logoutButton.titleLabel?.textAlignment = .Center
        logoutButton.backgroundColor = Color.logoutButtonBackground
        logoutButton.tintColor = Color.textColor
        logoutButton.layer.cornerRadius = 10.0
        logoutButton.clipsToBounds = true
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
    }
    
    override func setupConstraints() {
        var profileScreenConstraints = [NSLayoutConstraint]()
        let dictionary = ["profilePicture": profilePicture, "nameLabel": nameLabel, "settingsTableView": settingsTableView, "logoutButton": logoutButton]
        
        profileScreenConstraints.append(NSLayoutConstraint(item: profilePicture, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        profileScreenConstraints.append(NSLayoutConstraint(item: settingsTableView, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 50.0))
        profileScreenConstraints.append(NSLayoutConstraint(item: profilePicture, attribute: .Width, relatedBy: .Equal, toItem: profilePicture, attribute: .Height, multiplier: 1.0, constant: 0.0))
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-(>=40)-[profilePicture]-(>=40)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-[nameLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[settingsTableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[logoutButton(100)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        profileScreenConstraints.append(NSLayoutConstraint(item: logoutButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=20)-[profilePicture]-10-[nameLabel(20)]-10-[settingsTableView(130)]-[logoutButton(40)]-(>=20)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        
        view.addConstraints(profileScreenConstraints)
    }
}