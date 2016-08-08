//
//  MainAppearance.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/1/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class MainAppearance {
    
    static func setNavigationBarProperties() {
        // Set the battery, carrier , signal, clock to white
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // Get rid of shadow between navigation bar and content
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: Color.navigationTitle]
        UINavigationBar.appearance().barTintColor = Color.navigationBackground
        UINavigationBar.appearance().tintColor = Color.textColor
    }
}