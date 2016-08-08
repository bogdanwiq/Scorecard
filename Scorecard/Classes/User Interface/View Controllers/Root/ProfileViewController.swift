//
//  ProfileViewController.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/18/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class ProfileViewController : BaseViewController, UITableViewDataSource {
    
    var settings = ["Notifications", "Alerts"]
    let service = DataService.sharedInstance
    let reuseIdentifier = "PreferenceSliderCell"
    var profilePicture: ProfilePicture!
    var nameLabel: UILabel!
    var settingsTableView: SettingsTableView!
    var logoutButton: UIButton!
    var fullName : String!
    var imageUrl : String!
    
    init(fullName: String, imageUrl: String){
        super.init()
        self.fullName = fullName
        self.imageUrl = imageUrl
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func initUI() {
        super.initUI()
        view.backgroundColor = Color.mainBackground
        title = "Profile"
        
        let image: UIImage = UIImage(data: NSData(contentsOfURL: NSURL(string: imageUrl)!)!)!
        profilePicture = ProfilePicture(image: image)
        profilePicture.image = image
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profilePicture)
        
        nameLabel = UILabel()
        nameLabel.text = fullName
        nameLabel.backgroundColor = Color.mainBackground
        nameLabel.textColor = Color.textColor
        nameLabel.textAlignment = .Center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        settingsTableView = SettingsTableView()
        settingsTableView.dataSource = self
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsTableView)
        
        logoutButton = UIButton(frame: view.frame)
        logoutButton.setTitle("Logout", forState: .Normal)
        logoutButton.titleLabel?.textAlignment = .Center
        logoutButton.backgroundColor = Color.logoutButtonBackground
        logoutButton.tintColor = Color.textColor
        logoutButton.layer.cornerRadius = 10.0
        logoutButton.clipsToBounds = true
        logoutButton.addTarget(self, action: #selector(googleSignOut), forControlEvents: .TouchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
    }
    
    override func setupConstraints() {
        
        var profileScreenConstraints = [NSLayoutConstraint]()
        let dictionary = ["profilePicture": profilePicture, "nameLabel": nameLabel, "settingsTableView": settingsTableView, "logoutButton": logoutButton]
        
        profileScreenConstraints.append(NSLayoutConstraint(item: settingsTableView, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 50.0))
        profileScreenConstraints.append(NSLayoutConstraint(item: profilePicture, attribute: .Width, relatedBy: .Equal, toItem: profilePicture, attribute: .Height, multiplier: 1.0, constant: 0.0))
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-(>=20)-[profilePicture(<=130)]-(>=20)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[settingsTableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[logoutButton(100)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        profileScreenConstraints.append(NSLayoutConstraint(item: logoutButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        profileScreenConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=10)-[profilePicture]-10-[nameLabel]-10-[settingsTableView(>=130)]-[logoutButton]-(>=10)-|", options: .AlignAllCenterX, metrics: nil, views: dictionary)
        view.addConstraints(profileScreenConstraints)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : PreferenceSliderCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PreferenceSliderCell
        
        cell.preferenceName.text = settings[indexPath.row]
        let userId: String
        if FBSDKAccessToken.currentAccessToken() != nil {
            userId = FBSDKAccessToken.currentAccessToken().userID
        }
        else {
            userId = GIDSignIn.sharedInstance().clientID
        }
        cell.slider.setOn(service.getProfileSettings(userId, preferenceName: settings[indexPath.row]), animated: false)
        cell.delegate = self
        cell.backgroundColor = Color.mainBackground
        return cell
    }
    
    func googleSignOut() {
        if FBSDKAccessToken.currentAccessToken() != nil {
            FBSDKAccessToken.setCurrentAccessToken(nil)
            FBSDKProfile.setCurrentProfile(nil)
        } else {
            GIDSignIn.sharedInstance().signOut()
        }
        presentViewController(LoginViewController(), animated: true, completion: nil)
    }
}

extension ProfileViewController: PreferenceSliderCellDelegate {
    func preferenceSliderCellDidChangeValue(cell: PreferenceSliderCell, newState: Bool) {
        
        let userId: String
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            userId = FBSDKAccessToken.currentAccessToken().userID
        }
        else {
            userId = GIDSignIn.sharedInstance().clientID
        }
        service.setProfileSettings(userId, preferenceName: cell.preferenceName.text!, state: newState)
    }
}
