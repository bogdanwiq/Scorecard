//
//  StaticDetailedStatisticsTableView.swift
//  Scorecard
//
//  Created by Mac  on 7/27/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class StaticDetailedStatsTableView : UITableView, UITableViewDataSource {
    
    let reuseIdentifier: String = "StatsLabelsCell"
    var currentStats: [Stats] = []
    
    init() {
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        frame = UIScreen.mainScreen().bounds
        estimatedRowHeight = 30.0
        rowHeight = UITableViewAutomaticDimension
        registerClass(StatsLabelsCell.self, forCellReuseIdentifier: "StatsLabelsCell")
        separatorColor = UIColor.clearColor()
        scrollEnabled = false
        allowsSelection = false
        backgroundColor = Color.mainBackground
        
        dataSource = self
        
        currentStats.append(Stats(typeName: "Updates", counter: 0, difference: 0, percent: 0, sign: ""))
        currentStats.append(Stats(typeName: "Users", counter: 0, difference: 0, percent: 0, sign: ""))
        currentStats.append(Stats(typeName: "Downloads", counter: 0, difference: 0, percent: 0, sign: ""))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: StatsLabelsCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! StatsLabelsCell
        cell.identifier.image = UIImage(named: "Circle")
        cell.typeName.text = currentStats[indexPath.row].typeName
        return cell
    }
}