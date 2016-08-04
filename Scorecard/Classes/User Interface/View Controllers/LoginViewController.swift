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

class LoginViewController : BaseViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    var actInd : UIActivityIndicatorView!
    var googleLoginButton : UIButton!
    var facebookLoginButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func initUI() {
        view.backgroundColor = Color.mainBackground
        
        actInd = UIActivityIndicatorView()
        actInd.translatesAutoresizingMaskIntoConstraints = false
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        actInd.color = Color.timeFrameSelected
        view.addSubview(actInd)
        
        googleLoginButton = LoginButton.Google.getButton()
        googleLoginButton.addTarget(self, action: #selector(btnGoogleSignInPressed), forControlEvents: UIControlEvents.TouchUpInside)
        googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(googleLoginButton)
        
        facebookLoginButton = LoginButton.Facebook.getButton()
        facebookLoginButton.addTarget(self, action: #selector(btnFacebookSignInPressed), forControlEvents: UIControlEvents.TouchUpInside)
        facebookLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(facebookLoginButton)
    }
    
    override func setupConstraints() {
        
        var allConstraints = [NSLayoutConstraint]()
        let dictionary = ["googleButton": googleLoginButton, "facebookButton": facebookLoginButton, "actInd": actInd]
        
        allConstraints.append(NSLayoutConstraint(item: actInd, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[googleButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=20)-[actInd]-(>=20)-[googleButton(>=100)][facebookButton(==googleButton)]|", options: [.AlignAllLeft, .AlignAllRight], metrics: nil, views: dictionary)
        view.addConstraints(allConstraints)
    }
    
    func btnGoogleSignInPressed() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func btnFacebookSignInPressed() {
        
        let loginManager = FBSDKLoginManager()
        
        loginManager.logInWithReadPermissions(["public_profile"], fromViewController: self, handler: { (response:FBSDKLoginManagerLoginResult!, error: NSError!) in
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
                            self.actInd.startAnimating()
                            self.googleLoginButton.alpha = 0.15
                            self.facebookLoginButton.alpha = 0.6
                            self.presentViewController(RootViewController(fullName: fullName, imageUrl: imageUrl), animated: true, completion: nil)
                        })
                    })
                }
            }
        })
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            let fullName = user.profile.name
            let imageUrl = String(user.profile.imageURLWithDimension(130))
            //let email    = user.profile.email
            actInd.startAnimating()
            googleLoginButton.alpha = 0.6
            facebookLoginButton.alpha = 0.15
            presentViewController(RootViewController(fullName: fullName, imageUrl: imageUrl), animated: true, completion: nil)
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!, withError error: NSError!) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            "ToggleAuthUINotification",
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        // do something when user logs out
    }
    
}