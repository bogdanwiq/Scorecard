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
import FBSDKLoginKit

class LoginViewController : BaseViewController, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate {
    
    var googleLoginButton: GIDSignInButton!
    var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
//        facebookLoginButton.readPermissions = ["public_profile", "user_photos"]
        facebookLoginButton.delegate = self
    }
    
    override func initUI() {
        view.backgroundColor = Color.mainBackground
        
        googleLoginButton = GIDSignInButton()
        googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(googleLoginButton)
        
        facebookLoginButton = FBSDKLoginButton()
        facebookLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(facebookLoginButton)
    }
    
    override func setupConstraints() {
        
        var allConstraints = [NSLayoutConstraint]()
        let dictionary = ["googleButton": googleLoginButton, "facebookButton": facebookLoginButton]
        
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[googleButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=20)-[googleButton][facebookButton]|", options: [.AlignAllLeft, .AlignAllRight], metrics: nil, views: dictionary)
        view.addConstraints(allConstraints)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            let fullName = user.profile.name
            let imageUrl = String(user.profile.imageURLWithDimension(100))
            //let email    = user.profile.email
            presentViewController(RootViewController(fullName: fullName, imageUrl: imageUrl), animated: true, completion: nil)
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!, withError error: NSError!) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            "ToggleAuthUINotification",
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if (error == nil) {
            if FBSDKAccessToken.currentAccessToken() != nil {
                var fullName = ""
                var imageUrl = ""
                let request1 = FBSDKGraphRequest.init(graphPath: "me/picture", parameters: ["type": "large", "redirect": "false"], HTTPMethod: "GET")
                request1.startWithCompletionHandler({ (connection, result, error) in
                    if error != nil {
                        print(error.localizedDescription)
                        return
                    }
                    imageUrl = result.valueForKey("data")!.valueForKey("url")! as! String
                    let request2 = FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "name"], HTTPMethod: "GET")
                    request2.startWithCompletionHandler({ (connection, result, error) in
                        if error != nil {
                            print(error.localizedDescription)
                            return
                        }
                        fullName = result.valueForKey("name")! as! String
                        self.presentViewController(RootViewController(fullName: fullName, imageUrl: imageUrl), animated: true, completion: nil)
                    })
                })
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        // do something when user logs out
    }
    
}