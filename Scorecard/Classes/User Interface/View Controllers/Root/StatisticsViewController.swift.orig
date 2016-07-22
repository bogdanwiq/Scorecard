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
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
    }
    
    override func initUI(){
        //Set Background
        view.backgroundColor = Color.mainBackground
        navigationController?.navigationBar.translucent = false
        
        // Navigation Bar - TITLE
        title = "Dashboard"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.navigationTitle]
        navigationController?.navigationBar.barTintColor = Color.navigationBackground
        // End Statistics Title
        
        // Buttons left & right
        navigationController?.navigationBar.tintColor = Color.textColor
        // Navigation buttons
        let profileButton = Button.Profile.getButton()
        profileButton.addTarget(self, action: #selector(slideLeft), forControlEvents: .TouchUpInside)
        let notificationButton = Button.Notification.getButton()
        notificationButton.addTarget(self, action: #selector(slideRight), forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationButton)
        
        // TimeFrame
        let timeFrame = TimeFrame()
        timeFrame.frame = CGRectMake(0,0, timeFrame.frame.width, 30)
        // Table View
        let tableView = StatsTableView()
        tableView.delegate = self
        tableView.frame = CGRectMake(0, 30, tableView.frame.width, tableView.frame.height-95)
        
        view.addSubview(timeFrame)
        view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell : DashboardCell = tableView.cellForRowAtIndexPath(indexPath)! as! DashboardCell
        selectedCell.contentView.backgroundColor = UIColor.redColor()
        print(selectedCell.typeName.text!)
        navigationController?.pushViewController(DetailedStatisticViewController(), animated: true)
    }
    
    func slideLeft(){
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func slideRight(){
        
    }
}