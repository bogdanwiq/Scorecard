//
//  SideMenuController.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/27/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation

class SideMenuController : MMDrawerController {

    override init!(centerViewController: UIViewController!, leftDrawerViewController: UIViewController!, rightDrawerViewController: UIViewController!) {
        super.init(centerViewController: centerViewController, leftDrawerViewController: leftDrawerViewController, rightDrawerViewController: rightDrawerViewController)
        openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
        closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}