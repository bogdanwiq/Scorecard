//
//  AppDelegate.swift
//  Scorecard
//
//  Created by Botond Magyarosi on 12/07/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var centerContainer : MMDrawerController?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        
        //let rootViewController = UINavigationController(rootViewController: StatisticViewController())
        //window?.rootViewController = rootViewController
        
        // Set the battery, carrier , signal, clock to white
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // Side Menu
        let centerView = UINavigationController(rootViewController: StatisticViewController())
        let leftView = ProfileViewController()
        centerContainer = MMDrawerController(centerViewController: centerView, leftDrawerViewController: leftView)
        centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
        centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView
        window?.rootViewController = centerContainer
        window?.makeKeyAndVisible()
        return true
    }
}

