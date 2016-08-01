//
//  RootViewController.swift
//  Scorecard
//
//  Created by Botond Magyarosi on 12/07/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import UIKit

class RootViewController: MMDrawerController {
    
    init() {
        let centerView = UINavigationController(rootViewController: StatisticViewController())
        let leftView = ProfileViewController()
        
        super.init(centerViewController: centerView, leftDrawerViewController: leftView, rightDrawerViewController: nil)
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


