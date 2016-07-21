//
//  StatsTableView.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableView : UITableView, UITableViewDataSource, UITableViewDelegate{
    
    var arrayOfSettings = ["Notifications", "Alerts"]

    init() {
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.frame = UIScreen.mainScreen().bounds
        self.delegate = self
        self.dataSource = self
        self.registerClass(PreferenceSliderCell.self, forCellReuseIdentifier: "PreferenceSliderCell")
        self.allowsSelection = false
        self.scrollEnabled = false
        self.backgroundColor = UIColorFromHex(kBackgroundColor)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayOfSettings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "PreferenceSliderCell"
        let cell : PreferenceSliderCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PreferenceSliderCell
        cell.preferenceName.text = arrayOfSettings[indexPath.row]
        cell.slider.setOn(NSUserDefaults.standardUserDefaults().boolForKey(arrayOfSettings[indexPath.row]) ?? false, animated: false)
        cell.slider.addTarget(cell, action: #selector(cell.didChangeState(_:)), forControlEvents: .ValueChanged)
        cell.backgroundColor = UIColorFromHex(kBackgroundColor)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 63
    }
    
}