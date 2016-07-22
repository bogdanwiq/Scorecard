//
//  StatsTableView.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class StatsTableView : UITableView, UITableViewDataSource{
    
    let reuseIdentifier : String = "DashboardCell"
    let service = DataService()
    var stats : [Stats]!
    init() {
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        frame = UIScreen.mainScreen().bounds
        dataSource = self
        rowHeight = 80
        registerClass(DashboardCell.self, forCellReuseIdentifier: "DashboardCell")
        separatorColor = UIColor.clearColor()
        stats = service.setupStats()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return stats.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        backgroundColor = Color.mainBackground
        let cell : DashboardCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DashboardCell
        
        // SET UILABELS.TEXT
        cell.typeName.text = stats[indexPath.row].typeName
        cell.counter.text = String(stats[indexPath.row].counter)
        if stats[indexPath.row].getImage() == UIImage(named: "ArrowUp"){
            cell.difference.textColor = Color.statsRise
            cell.difference.text = "+" + String(stats[indexPath.row].difference)
        }else if stats[indexPath.row].getImage() == UIImage(named: "ArrowDown"){
            cell.difference.textColor = Color.statsFall
            cell.difference.text = "-" + String(stats[indexPath.row].difference)
        }
        else if stats[indexPath.row].getImage() == UIImage(named: "None"){
            cell.difference.textColor = Color.statsRise
            cell.difference.text = String(stats[indexPath.row].difference)
        }
        cell.percent.text = String(stats[indexPath.row].percent) + "%"
        cell.sign.image = stats[indexPath.row].getImage()
        
        // CELL BACKGROUND COLOR
        var hue : CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness : CGFloat = 0.0
        var alpha : CGFloat = 0.0
        Color.mainBackground.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        cell.backgroundColor = UIColor(hue: hue, saturation: saturation-(0.06*CGFloat(indexPath.row)), brightness: brightness+(0.03*CGFloat(indexPath.row)), alpha: alpha)
        return cell
    }
    
}