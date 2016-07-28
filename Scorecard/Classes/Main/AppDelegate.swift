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
    var sideMenu : SideMenuController?
    let centerView = UINavigationController(rootViewController: StatisticViewController())
    let leftView = ProfileViewController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        // Set the battery, carrier , signal, clock to white
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        sideMenu = SideMenuController(centerViewController: centerView, leftDrawerViewController: leftView, rightDrawerViewController: nil)
        window?.rootViewController = sideMenu
        window?.makeKeyAndVisible()
        return true
    }
   
}

