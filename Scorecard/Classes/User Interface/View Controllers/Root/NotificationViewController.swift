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
        let appDelegate = SharedApplication.delegate as! AppDelegate
        appDelegate.centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.None
    }
    
    override func initUI(){
        view.backgroundColor = Color.mainBackground
        navigationController?.navigationBar.translucent = false
        title = "Notifications"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.navigationTitle]
        navigationController?.navigationBar.barTintColor = Color.navigationBackground
        navigationController?.navigationBar.tintColor = Color.textColor
    }
    
    override func setupConstraints() {

    }
}