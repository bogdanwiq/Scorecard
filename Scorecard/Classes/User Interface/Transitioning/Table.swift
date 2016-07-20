//
//  Table.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit
import SideMenuController

class Table : UITabBarController {
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(){
    self.init()
    let sideMenuViewController = SideMenuController()
    
    // create the view controllers for center containment
    let vc1 = StatisticViewController()
    let nc1 = UINavigationController(rootViewController: vc1)
    vc1.navigationItem.title = "first"
    
    let vc2 = StatisticViewController()
   
    let nc2 = UINavigationController(rootViewController: vc2)
    vc2.navigationItem.title = "second"
    
    let vc3 = StatisticViewController()
    
    let nc3 = UINavigationController(rootViewController: vc3)
    vc3.navigationItem.title = "third"
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [nc1, nc2, nc3]
    
    // create the side controller
    let sideController = ProfileViewController()
    
    // embed the side and center controllers
    sideMenuViewController.embed(sideViewController: sideController)
    sideMenuViewController.embed(centerViewController: tabBarController)
    
    // add the menu button to each view controller embedded in the tab bar controller
    [nc1, nc2, nc3].forEach({ controller in
    controller.addSideMenuButton()
    })
        
        self.showViewController(sideMenuViewController, sender: nil)
    }
   
}