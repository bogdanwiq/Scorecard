//
//  DetailedStatsTableView.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/25/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class DetailedStatsTableView : UITableView, UITableViewDataSource {
    
    let reuseIdentifier : String = "StatsCell"
    let service = DataService.sharedInstance
    var currentStat : Stats!
    
    init() {
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        frame = UIScreen.mainScreen().bounds
        dataSource = self
        estimatedRowHeight = 30.0
        rowHeight = UITableViewAutomaticDimension
        registerClass(StatsCell.self, forCellReuseIdentifier: "StatsCell")
        separatorColor = UIColor.clearColor()
        scrollEnabled = false
        allowsSelection = false
        backgroundColor = Color.mainBackground
        currentStat = service.getCurrentStat()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : StatsCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! StatsCell
        cell.identifier.image = UIImage(named: "Circle")
        cell.typeName.text = "Unique " + currentStat.typeName
        cell.difference.text = String(currentStat.difference)
        cell.sign.image = currentStat.getImage()
        return cell
    }
}