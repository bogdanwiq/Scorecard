//
//  StatsTableView.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class StatsTableView : UITableView, UITableViewDataSource {
    
    let reuseIdentifier : String = "DashboardCell"
    let service = DataService.sharedInstance
    var projectsStats : [Project]!
    
    init() {
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        dataSource = self
        estimatedRowHeight = 80.0
        rowHeight = UITableViewAutomaticDimension
        registerClass(DashboardCell.self, forCellReuseIdentifier: "DashboardCell")
        separatorColor = UIColor.clearColor()
        backgroundColor = Color.mainBackground
        projectsStats = service.setupStats()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return projectsStats[section].name
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsStats[section].metrics.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return projectsStats.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : DashboardCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DashboardCell
        
        cell.typeName.text = projectsStats[indexPath.section].metrics[indexPath.row].name
        cell.counter.text = service.sumMetricValues(projectsStats[indexPath.section].metrics[indexPath.row])
        
//        if stats[indexPath.row].getImage() == UIImage(named: "ArrowUp") {
//            cell.difference.textColor = Color.statsRise
//            cell.difference.text = "+" + String(stats[indexPath.row].difference)
//        }
//        else if stats[indexPath.row].getImage() == UIImage(named: "ArrowDown") {
//            cell.difference.textColor = Color.statsFall
//            cell.difference.text = "-" + String(stats[indexPath.row].difference)
//        }
//        else if stats[indexPath.row].getImage() == UIImage(named: "None") {
//            cell.difference.textColor = Color.statsRise
//            cell.difference.text = String(stats[indexPath.row].difference)
//        }
//        cell.percent.text = String(stats[indexPath.row].percent) + "%"
//        cell.sign.image = stats[indexPath.row].getImage()
        
        cell.difference.text = "+123812"
        cell.percent.text = "27%"
        cell.sign.image = EvolutionSign.None.getSign()
        
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