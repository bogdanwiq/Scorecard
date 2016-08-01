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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.None
    }
    
    override func initUI() {
        view.backgroundColor = Color.mainBackground
        title = "Notifications"
    }
}