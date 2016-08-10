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
        if FBSDKAccessToken.currentAccessToken() != nil {
            let request1 = FBSDKGraphRequest.init(graphPath: "me/picture", parameters: ["type": "large", "redirect": "false"], HTTPMethod: "GET")
            request1.startWithCompletionHandler({ (connection, result, error) in
                if error != nil {
                    print(error.localizedDescription)
                    return
                }
                let imageUrl = result.valueForKey("data")!.valueForKey("url")! as! String
                let request2 = FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "name"], HTTPMethod: "GET")
                request2.startWithCompletionHandler({ (connection, result, error) in
                    if error != nil {
                        print(error.localizedDescription)
                        return
                    }
                    let fullName = result.valueForKey("name")! as! String
                    self.actInd.startAnimating()
                    UIView.animateWithDuration(2.0) {
                        self.googleLoginButton.alpha = 0.1
                        self.facebookLoginButton.alpha = 0.6
                    }
                    self.presentViewController(RootViewController(fullName: fullName, imageUrl: imageUrl), animated: true, completion: nil)
                })
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
                    let request1 = FBSDKGraphRequest.init(graphPath: "me/picture", parameters: ["type": "large", "redirect": "false"], HTTPMethod: "GET")
                    request1.startWithCompletionHandler({ (connection, result, error) in
                        if error != nil {
                            print(error.localizedDescription)
                            return
                        }
                        let imageUrl = result.valueForKey("data")!.valueForKey("url")! as! String
                        let request2 = FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "name"], HTTPMethod: "GET")
                        request2.startWithCompletionHandler({ (connection, result, error) in
                            if error != nil {
                                print(error.localizedDescription)
                                return
                            }
                            let fullName = result.valueForKey("name")! as! String
                            self.actInd.startAnimating()
                            UIView.animateWithDuration(2.0) {
                                self.googleLoginButton.alpha = 0.1
                                self.facebookLoginButton.alpha = 0.6
                            }
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

            actInd.startAnimating()
            UIView.animateWithDuration(2.0) {
                self.googleLoginButton.alpha = 0.6
                self.facebookLoginButton.alpha = 0.1
            }
            presentViewController(RootViewController(fullName: fullName, imageUrl: imageUrl), animated: true, completion: nil)
        }
    }
}