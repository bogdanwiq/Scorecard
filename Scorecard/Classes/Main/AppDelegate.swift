//
//  AppDelegate.swift
//  Scorecard
//
//  Created by Botond Magyarosi on 12/07/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import PasscodeLock

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rootViewController: LoginViewController!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var configureError: NSError?
        let types:UIUserNotificationType = UIUserNotificationType.Alert
        let mySettings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        MainAppearance.setNavigationBarProperties()
        GGLContext.sharedInstance().configureWithError(&configureError)
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
        rootViewController = LoginViewController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: sourceApplication, annotation: annotation) || FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    @available(iOS 9.0, *)
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String?, annotation: options[UIApplicationOpenURLOptionsAnnotationKey]) || FBSDKApplicationDelegate.sharedInstance().application(app, openURL: url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String, annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        let rootViewController = window?.rootViewController as! LoginViewController
        let drawerController = rootViewController.presentedViewController as? RootViewController
        // if user hasn't logged in
        if drawerController != nil {
            let navigationController = drawerController!.centerViewController as? UINavigationController
            
            var passcodeKey: String
            
            if FBSDKAccessToken.currentAccessToken() != nil {
                passcodeKey = FBSDKAccessToken.currentAccessToken().userID
            } else {
                passcodeKey = GIDSignIn.sharedInstance().clientID
            }
            passcodeKey += "pass"
            
            let configuration = PasscodeLockConfiguration(passcodeKey: passcodeKey)
            if configuration.repository.hasPasscode && navigationController != nil {
                let passcodeLockVC = PasscodeLockViewController(state: .EnterPasscode, configuration: configuration)
                navigationController!.topViewController?.presentViewController(passcodeLockVC, animated: true, completion: nil)
            }
        }
    }
}