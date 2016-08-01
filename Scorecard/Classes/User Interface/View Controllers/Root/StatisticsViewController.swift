//
//  StatisticsViewController.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/15/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class StatisticViewController: BaseViewController {
    
    let timeFrame = TimeFrame()
    let tableView = StatsTableView()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
    }
    
    override func initUI() {
        view.backgroundColor = Color.mainBackground
        title = "Dashboard"
        let profileButton = Button.Profile.getButton()
        profileButton.addTarget(self, action: #selector(slideLeft), forControlEvents: .TouchUpInside)
        let notificationButton = Button.Notification.getButton()
        notificationButton.addTarget(self, action: #selector(notificationTapped), forControlEvents: .TouchUpInside)
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
    
    func slideLeft() {
        mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func notificationTapped(){
        navigationController?.pushViewController(NotificationViewController(), animated: true)
    }
}

// MARK: - UITableViewDelegate

extension StatisticViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedCell : DashboardCell = tableView.cellForRowAtIndexPath(indexPath)! as! DashboardCell
        
        selectedCell.selectionStyle = UITableViewCellSelectionStyle.None
        navigationController?.pushViewController(DetailedStatisticViewController(metric: self.tableView.projectsStats[indexPath.section].metrics[indexPath.row]), animated: true)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = Color.timeFrameBackground
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.tableView.projectsStats[section].name
        label.textColor = Color.timeFrameSelected
        label.font = UIFont.boldSystemFontOfSize(17.0)
        header.addSubview(label)
        header.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[title]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["title": label]))
        header.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: header, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        return header
    }
}