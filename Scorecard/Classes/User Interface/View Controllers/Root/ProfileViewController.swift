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
    
    override func initUI() {
        view.backgroundColor = Color.mainBackground
        navigationController?.navigationBar.translucent = false
        title = "Profile"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.navigationTitle]
        navigationController?.navigationBar.barTintColor = Color.navigationBackground
        navigationController?.navigationBar.tintColor = Color.navigationTitle
        
        let image = UIImage(named: "ProfilePicture")
        profilePicture = ProfilePicture(image: image)
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profilePicture)
        
        nameLabel = UILabel()
        nameLabel.text = "Anonymous User"
        nameLabel.backgroundColor = Color.mainBackground
        nameLabel.textColor = Color.textColor
        nameLabel.textAlignment = .Center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        settingsTableView = SettingsTableView()
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsTableView)
        
        logoutButton = UIButton(frame: view.frame)
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
        
        profileScreenConstraints.append(NSLayoutConstraint(item: settingsTableView, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 50.0))
        profileScreenConstraints.append(NSLayoutConstraint(item: profilePicture, attribute: .Width, relatedBy: .Equal, toItem: profilePicture, attribute: .Height, multiplier: 1.0, constant: 0.0))
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-(>=20)-[profilePicture]-(>=20)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[settingsTableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[logoutButton(100)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        profileScreenConstraints.append(NSLayoutConstraint(item: logoutButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=10)-[profilePicture]-10-[nameLabel]-10-[settingsTableView(>=130)]-[logoutButton]-(>=10)-|", options: .AlignAllCenterX, metrics: nil, views: dictionary)
        view.addConstraints(profileScreenConstraints)
    }
}