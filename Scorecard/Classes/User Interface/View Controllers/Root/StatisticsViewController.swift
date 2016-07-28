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
    
    let timeFrame = TimeFrame()
    let tableView = StatsTableView()
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.sideMenu!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
    }
    
    override func initUI() {
        view.backgroundColor = Color.mainBackground
        navigationController?.navigationBar.translucent = false
        title = "Dashboard"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.navigationTitle]
        navigationController?.navigationBar.barTintColor = Color.navigationBackground
        navigationController?.navigationBar.tintColor = Color.textColor
        let profileButton = Button.Profile.getButton()
        profileButton.addTarget(self, action: #selector(slideLeft), forControlEvents: .TouchUpInside)
        let notificationButton = Button.Notification.getButton()
        notificationButton.addTarget(self, action: #selector(goNotification), forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationButton)
        timeFrame.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeFrame)

        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        
        var allConstraints = [NSLayoutConstraint]()
        let dictionary = ["timeFrame": timeFrame, "tableView": tableView]
        
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[timeFrame]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[timeFrame(30)][tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        view.addConstraints(allConstraints)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedCell : DashboardCell = tableView.cellForRowAtIndexPath(indexPath)! as! DashboardCell
        
        selectedCell.selectionStyle = UITableViewCellSelectionStyle.None
        navigationController?.pushViewController(DetailedStatisticViewController(), animated: true)
    }
    
    func slideLeft(){
        
        let appDelegate = SharedApplication.delegate as! AppDelegate
        
        appDelegate.sideMenu!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func goNotification(){
        navigationController?.pushViewController(NotificationViewController(), animated: true)
    }
}