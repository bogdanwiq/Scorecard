//
//  StatisticsViewController.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/15/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class StatisticViewController: BaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    override func initUI(){
        //Set Background
        self.view.backgroundColor = UIColorFromHex(kBackgroundColor, alpha: 1)
        self.navigationController?.navigationBar.translucent = false
        // Navigation Bar - TITLE
        self.title = "Statistics"
        self.navigationController?.navigationBar.titleTextAttributes = kNavigationTitleColor
        self.navigationController?.navigationBar.barTintColor = UIColorFromHex(kBackgroundColor, alpha: 1)
        // End Statistics Title
        
        // Buttons left & right
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        // Navigation buttons
        self.navigationItem.leftBarButtonItem = ProfileButton()
        self.navigationItem.rightBarButtonItem = NotificationButton()
        
        // Table View
        let tableView = StatsTableView()
        tableView.frame = CGRectMake(0, 40, tableView.frame.width, tableView.frame.height-105)
        self.view.addSubview(tableView)
    }
}