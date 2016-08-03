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
    let reuseIdentifier : String = "DashboardCell"
    let service = DataService.sharedInstance
    var originalProjectsStats : [Project]!
    var projectsStats : [Project]!
    var projectDifferenceAndPercent : [String: [String: (Int, Double)]] = [:]
    
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
        timeFrame.delegate = self
        timeFrame.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeFrame)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        originalProjectsStats = service.setupStats()
        projectDifferenceAndPercent = service.getPreviousCount(originalProjectsStats, type: .All)
        projectsStats = []
        projectsStats.appendContentsOf(originalProjectsStats)
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
        navigationController?.pushViewController(DetailedStatisticViewController(metric: projectsStats[indexPath.section].metrics[indexPath.row], differenceAndPercent: projectDifferenceAndPercent[projectsStats[indexPath.section].id]![projectsStats[indexPath.section].metrics[indexPath.row].id]!, timeFrame: timeFrame.selectedIndex), animated: true)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = Color.timeFrameBackground
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = originalProjectsStats[section].name
        label.textColor = Color.timeFrameSelected
        label.font = UIFont.boldSystemFontOfSize(17.0)
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
            cell.difference.text = "\(array[projectsStats[indexPath.section].metrics[indexPath.row].id]!.0.prettyString())"
            cell.difference.textColor = Color.textColor
            cell.percent.textColor = Color.textColor
            cell.percent.text = String(format: "%.2f",array[projectsStats[indexPath.section].metrics[indexPath.row].id]!.1) + "%"
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
            tableView.reloadSections(NSIndexSet(indexesInRange: NSRange(location: 0, length: tableView.numberOfSections)), withRowAnimation: .Fade)
            break
        case 1 :
            projectsStats = service.filter(originalProjectsStats, type: .OneWeek)
            projectDifferenceAndPercent = service.getPreviousCount(originalProjectsStats, type: .OneWeek)
            tableView.reloadSections(NSIndexSet(indexesInRange: NSRange(location: 0, length: tableView.numberOfSections)), withRowAnimation: .Fade)
            break
        case 2 :
            projectsStats = service.filter(originalProjectsStats, type: .OneMonth)
            projectDifferenceAndPercent = service.getPreviousCount(originalProjectsStats, type: .OneMonth)
            tableView.reloadSections(NSIndexSet(indexesInRange: NSRange(location: 0, length: tableView.numberOfSections)), withRowAnimation: .Fade)
            break
        case 3 :
            projectsStats = service.filter(originalProjectsStats, type: .OneYear)
            projectDifferenceAndPercent = service.getPreviousCount(originalProjectsStats, type: .OneYear)
            tableView.reloadSections(NSIndexSet(indexesInRange: NSRange(location: 0, length: tableView.numberOfSections)), withRowAnimation: .Fade)
            break
        case 4 :
            projectsStats = service.filter(originalProjectsStats, type: .All)
            projectDifferenceAndPercent = service.getPreviousCount(originalProjectsStats, type: .All)
            tableView.reloadSections(NSIndexSet(indexesInRange: NSRange(location: 0, length: tableView.numberOfSections)), withRowAnimation: .Fade)
            break
        default :
            break
        }
    }
}