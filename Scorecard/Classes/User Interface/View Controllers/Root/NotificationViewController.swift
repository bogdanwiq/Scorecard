//
//  NotificationViewController.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/26/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class NotificationViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // CR: [Anyone | High] Never access AppDelegate instnace from your controllers. [MBoti]
        let appDelegate = SharedApplication.delegate as! AppDelegate
        appDelegate.sideMenu!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.None
    }
    
    override func initUI() {
        view.backgroundColor = Color.mainBackground
        navigationController?.navigationBar.translucent = false
        title = "Notifications"
        // CR: [Anyone | Medium] Create a class named MainAppearance (in the Appearance folder) and move these lines there. Set these variables globally by accessing throuh UINavigationBar.appearance() [MBoti]
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.navigationTitle]
        navigationController?.navigationBar.barTintColor = Color.navigationBackground
        navigationController?.navigationBar.tintColor = Color.textColor
    }
    
    override func setupConstraints() {
        // CR: [Anyone | Low] Don't leave empty methods in the code. [MBoti]
    }
}