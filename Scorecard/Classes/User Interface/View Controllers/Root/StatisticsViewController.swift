//
//  StatisticsViewController.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/15/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class StatisticViewController: BaseViewController, UITableViewDelegate{
    
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
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        // TimeFrame
        let timeFrame = TimeFrame()
        timeFrame.frame = CGRectMake(0,0, timeFrame.frame.width, 30)
        // Table View
        let tableView = StatsTableView()
        tableView.delegate = self
        tableView.frame = CGRectMake(0, 30, tableView.frame.width, tableView.frame.height-95)
        
        self.view.addSubview(timeFrame)
        self.view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell : DashboardCell = tableView.cellForRowAtIndexPath(indexPath)! as! DashboardCell
        selectedCell.contentView.backgroundColor = UIColor.redColor()
        print(selectedCell.typeName.text!)
        navigationController?.pushViewController(DetailedStatisticViewController(), animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
    }
}