//
//  StatisticsViewController.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/15/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import PasscodeLock

class StatisticViewController: BaseViewController {
    
    let service = DataService.sharedInstance
    let reuseIdentifier : String = "DashboardCell"
    var tableView : UITableView!
    let timeFrame = TimeFrame()
    var originalProjectsStats: [Project] = []
    var projectsStats: [Project] = []
    var projectDifferenceAndPercent : [String: [String: (Int, Double)]] = [:]
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
    }
    
    override func initUI() {
        
        presentPasscodeScreen()
        
        let profileButton = Button.Profile.getButton()
        profileButton.addTarget(self, action: #selector(slideLeft), forControlEvents: .TouchUpInside)
        let notificationButton = Button.Notification.getButton()
        notificationButton.addTarget(self, action: #selector(notificationTapped), forControlEvents: .TouchUpInside)
        
        view.backgroundColor = Color.mainBackground
        title = "Dashboard"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationButton)
        
        timeFrame.delegate = self
        timeFrame.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeFrame)
        
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.clearColor()
        tableView.backgroundColor = Color.mainBackground
        tableView.registerClass(DashboardCell.self, forCellReuseIdentifier: "DashboardCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        originalProjectsStats = service.setupStats()
        projectDifferenceAndPercent = service.getPreviousCount(originalProjectsStats, type: .All)
        projectsStats = []
        projectsStats.appendContentsOf(originalProjectsStats)
    }
    
    func presentPasscodeScreen() {
        
        var passcodeKey: String
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            passcodeKey = FBSDKAccessToken.currentAccessToken().userID
        } else {
            passcodeKey = GIDSignIn.sharedInstance().clientID
        }
        passcodeKey += "pass"
        
        let configuration = PasscodeLockConfiguration(passcodeKey: passcodeKey)
        if configuration.repository.hasPasscode {
            let passcodeLockVC = PasscodeLockViewController(state: .EnterPasscode, configuration: configuration)
            presentViewController(passcodeLockVC, animated: true, completion: nil)
        }
    }
    
    override func setupConstraints() {
        
        var allConstraints = [NSLayoutConstraint]()
        let views : [String: UIView] = ["timeFrame": timeFrame, "tableView": tableView]
        
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[timeFrame]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[timeFrame(30)][tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
    func slideLeft() {
        mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func notificationTapped() {
        navigationController?.pushViewController(NotificationViewController(), animated: true)
    }
}

// MARK: - UITableViewDelegate

extension StatisticViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedCell : DashboardCell = tableView.cellForRowAtIndexPath(indexPath)! as! DashboardCell
        
        selectedCell.selectionStyle = UITableViewCellSelectionStyle.None
        navigationController?.pushViewController(DetailedStatisticViewController(originalMetric: originalProjectsStats[indexPath.section].metrics[indexPath.row], metric: projectsStats[indexPath.section].metrics[indexPath.row], differenceAndPercent: projectDifferenceAndPercent[projectsStats[indexPath.section].id]![projectsStats[indexPath.section].metrics[indexPath.row].id]!, timeFrame: timeFrame.selectedIndex), animated: true)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView()
        let label = UILabel()
        
        header.backgroundColor = Color.timeFrameBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = originalProjectsStats[section].name
        label.textColor = Color.timeFrameSelected
        label.font = Font.system(.Metric)
        header.addSubview(label)
        header.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[title]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["title": label]))
        header.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: header, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        return header
    }
}

// MARK: - UITableViewDataSource

extension StatisticViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return originalProjectsStats[section].name
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section >= projectsStats.count) ? 0 : projectsStats[section].metrics.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return originalProjectsStats.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : DashboardCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DashboardCell
        
        cell.typeName.text = projectsStats[indexPath.section].metrics[indexPath.row].name
        cell.counter.text = service.sumMetricValues(projectsStats[indexPath.section].metrics[indexPath.row])
        
        let array = projectDifferenceAndPercent[projectsStats[indexPath.section].id]!
        
        if array[projectsStats[indexPath.section].metrics[indexPath.row].id]!.0 < 0 {
            cell.difference.text = "\(array[projectsStats[indexPath.section].metrics[indexPath.row].id]!.0.prettyString())"
            cell.difference.textColor = Color.statsFall
            cell.percent.textColor = Color.statsFall
            cell.percent.text = String(format: "%.2f",array[projectsStats[indexPath.section].metrics[indexPath.row].id]!.1) + "%"
            cell.sign.image = EvolutionSign.ArrowDown.getSign()
        }
        else if array[projectsStats[indexPath.section].metrics[indexPath.row].id]!.0 == 0 {
            cell.difference.text = ""
            cell.difference.textColor = Color.textColor
            cell.percent.textColor = Color.textColor
            cell.percent.text = ""
            cell.sign.image = EvolutionSign.None.getSign()
        }
        else if array[projectsStats[indexPath.section].metrics[indexPath.row].id]!.0 > 0 {
            cell.difference.text = "+\(array[projectsStats[indexPath.section].metrics[indexPath.row].id]!.0.prettyString())"
            cell.difference.textColor = Color.statsRise
            cell.percent.textColor = Color.statsRise
            cell.percent.text = String(format: "+%.2f",array[projectsStats[indexPath.section].metrics[indexPath.row].id]!.1) + "%"
            cell.sign.image = EvolutionSign.ArrowUp.getSign()
        }
        
        var hue : CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness : CGFloat = 0.0
        var alpha : CGFloat = 0.0
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        Color.mainBackground.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        cell.backgroundColor = UIColor(hue: hue, saturation: saturation-(0.06*CGFloat(indexPath.row)), brightness: brightness+(0.03*CGFloat(indexPath.row)), alpha: alpha)
        return cell
    }
}

// MARK - TimeFrameDelegate

extension StatisticViewController: TimeFrameDelegate {
    
    func timeFrameSelectedValue(selectedIndex: Int) {
        
        switch selectedIndex {
        case 0 :
            projectsStats = service.filter(originalProjectsStats, type: .OneDay)
            projectDifferenceAndPercent = service.getPreviousCount(originalProjectsStats, type: .OneDay)
            break
        case 1 :
            projectsStats = service.filter(originalProjectsStats, type: .OneWeek)
            projectDifferenceAndPercent = service.getPreviousCount(originalProjectsStats, type: .OneWeek)
            break
        case 2 :
            projectsStats = service.filter(originalProjectsStats, type: .OneMonth)
            projectDifferenceAndPercent = service.getPreviousCount(originalProjectsStats, type: .OneMonth)
            break
        case 3 :
            projectsStats = service.filter(originalProjectsStats, type: .OneYear)
            projectDifferenceAndPercent = service.getPreviousCount(originalProjectsStats, type: .OneYear)
            break
        case 4 :
            projectsStats = service.filter(originalProjectsStats, type: .All)
            projectDifferenceAndPercent = service.getPreviousCount(originalProjectsStats, type: .All)
            
            break
        default :
            break
        }
        tableView.reloadSections(NSIndexSet(indexesInRange: NSRange(location: 0, length: tableView.numberOfSections)), withRowAnimation: .Fade)
    }
}