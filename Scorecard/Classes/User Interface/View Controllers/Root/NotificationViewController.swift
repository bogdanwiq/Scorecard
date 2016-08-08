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
    
    let tableView = NotificationTableView()
    var allNotifications: [UILocalNotification] = []
    let reuseIdentifier : String = "NotificationCell"
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.None
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notification: UILocalNotification = UILocalNotification()
        notification.alertBody = "HI, ALERT"
        notification.fireDate = NSDate().dateByAddingTimeInterval(1.0)
        
        allNotifications.append(notification)
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    override func initUI() {
        view.backgroundColor = Color.mainBackground
        title = "Notifications"
        
        tableView.dataSource = self
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        
        var allConstraints = [NSLayoutConstraint]()
        let dictionary = ["tableView": tableView]
        
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        view.addConstraints(allConstraints)
    }
}

// MARK: - UITableViewDataSource

extension NotificationViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : NotificationCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NotificationCell
        print(allNotifications[indexPath.row].alertBody!)
        cell.notificationText.text = "Maked At date : \(cell.date)"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNotifications.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            allNotifications.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
    }
}

