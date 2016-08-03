//
//  LoginViewController.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/3/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class LoginViewController : BaseViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    var googleLoginButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func initUI() {
        view.backgroundColor = Color.mainBackground
        
        googleLoginButton = GIDSignInButton()
        googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(googleLoginButton)
        
        GIDSignIn.sharedInstance().signOut()
    }
    
    override func setupConstraints() {
        
        var allConstraints = [NSLayoutConstraint]()
        let dictionary = ["googleButton": googleLoginButton]
        
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[googleButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=20)-[googleButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        view.addConstraints(allConstraints)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            let fullName = user.profile.name
            //user.profile.imageURLWithDimension(400)
            let email = user.profile.email
            presentViewController(RootViewController(), animated: true, completion: nil)
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            "ToggleAuthUINotification",
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
    }
    
}