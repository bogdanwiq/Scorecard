//
//  StatsTableView.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableView : UITableView, UITableViewDataSource {
    
    var settings = ["Notifications", "Alerts"]
    let service = DataService.sharedInstance

    init() {
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        frame = UIScreen.mainScreen().bounds
        dataSource = self
        registerClass(PreferenceSliderCell.self, forCellReuseIdentifier: "PreferenceSliderCell")
        allowsSelection = false
        scrollEnabled = false
        backgroundColor = Color.mainBackground
        rowHeight = 63
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return settings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "PreferenceSliderCell"
        let cell : PreferenceSliderCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PreferenceSliderCell
        cell.preferenceName.text = settings[indexPath.row]
        cell.slider.setOn(service.getProfileSettings(settings[indexPath.row]) ?? false, animated: false)
        cell.slider.addTarget(cell, action: #selector(cell.didChangeState(_:)), forControlEvents: .ValueChanged)
        cell.backgroundColor = Color.mainBackground
        
        return cell
    }
    
}