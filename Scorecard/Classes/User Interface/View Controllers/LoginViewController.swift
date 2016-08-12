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

class LoginViewController : BaseViewController, GIDSignInUIDelegate, GIDSignInDelegate{
    
    var authenticationService = AuthenticationService.sharedInstance
    var actInd : UIActivityIndicatorView!
    var googleLoginButton : UIButton!
    var facebookLoginButton : UIButton!
    var root: RootViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        if FBSDKAccessToken.currentAccessToken() != nil {
            self.authenticationService.facebookLogin({ (fullName, imageURL) in
                self.root = RootViewController(fullName: fullName, imageUrl: imageURL)
                NSNotificationCenter.defaultCenter().postNotificationName("userDidSignIn", object: nil)
            })
        } else if (GIDSignIn.sharedInstance() != nil) {
            GIDSignIn.sharedInstance().signInSilently()
        }
    }
    
    override func initUI() {
        view.backgroundColor = Color.mainBackground
        
        actInd = UIActivityIndicatorView()
        actInd.translatesAutoresizingMaskIntoConstraints = false
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
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
        let metrics : [String: CGFloat] = ["padding": 20]
        let views : [String: UIView] = ["googleButton": googleLoginButton, "facebookButton": facebookLoginButton, "actInd": actInd]
        
        allConstraints.append(NSLayoutConstraint(item: actInd, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        allConstraints.append(NSLayoutConstraint(item: googleLoginButton, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 0.15, constant: 0.0))
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[googleButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=padding)-[actInd]-(>=padding)-[googleButton][facebookButton(==googleButton)]|", options: [.AlignAllLeft, .AlignAllRight], metrics: metrics, views: views)
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
    func btnGoogleSignInPressed() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            let fullName = user.profile.name
            let imageUrl = String(user.profile.imageURLWithDimension(130))
            root = RootViewController(fullName: fullName, imageUrl: imageUrl)
            NSNotificationCenter.defaultCenter().postNotificationName("userDidSignIn", object: nil)
        }
    }
    
    func btnFacebookSignInPressed() {
        
        let loginManager = FBSDKLoginManager()
        
        loginManager.logInWithReadPermissions(["public_profile"], fromViewController: self, handler: { (response:FBSDKLoginManagerLoginResult!, error: NSError!) in
            if (error == nil) {
                self.authenticationService.facebookLogin({ (fullName, imageURL) in
                    self.root = RootViewController(fullName: fullName, imageUrl: imageURL)
                    NSNotificationCenter.defaultCenter().postNotificationName("userDidSignIn", object: nil)
                })
            }
        })
    }
}