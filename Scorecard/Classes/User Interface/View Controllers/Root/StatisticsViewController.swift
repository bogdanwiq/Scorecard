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
        // CR: [Anyone | High] This method is alrady called in base and thats why the UI is created twice [Atti]
        initUI()
    }
    override func initUI(){
        //Set Background
        self.view.backgroundColor = UIColorFromHex(kBackgroundColor, alpha: 1)
        self.navigationController?.navigationBar.translucent = false
        // Navigation Bar - TITLE
        title = "Statistics"
        navigationController?.navigationBar.titleTextAttributes = kNavigationTitleColor
        navigationController?.navigationBar.barTintColor = UIColorFromHex(kBackgroundColor, alpha: 1)
        // End Statistics Title
        
        // Buttons left & right
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        // Navigation buttons
        let button = ProfileButton()
//        button.addTarget(self, action: #selector(), forControlEvents: <#T##UIControlEvents#>)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: ProfileButton())
        self.navigationItem.rightBarButtonItem = NotificationButton()
        // TimeFrame
        let timeFrame = TimeFrame()
        timeFrame.frame = CGRectMake(0,0, timeFrame.frame.width, 30)
        // Table View
        let tableView = StatsTableView()
        tableView.frame = CGRectMake(0, 30, tableView.frame.width, tableView.frame.height-95)
        
        self.view.addSubview(timeFrame)
        self.view.addSubview(tableView)
    }
}