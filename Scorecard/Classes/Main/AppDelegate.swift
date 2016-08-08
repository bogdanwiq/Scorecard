//
//  AppDelegate.swift
//  Scorecard
//
//  Created by Botond Magyarosi on 12/07/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import UIKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootViewController: LoginViewController!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        MainAppearance.setNavigationBarProperties()
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        let types:UIUserNotificationType = UIUserNotificationType.Alert
        let mySettings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
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
}

