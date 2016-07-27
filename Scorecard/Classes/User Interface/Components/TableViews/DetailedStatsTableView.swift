//
//  DetailedStatsTableView.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/25/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class DetailedStatsTableView : UITableView {
    // CR: [Someone | Medium] Just for this basic setups you don't need to create a separate file. Move this in viewcontroller where is created. [Atti]
    // CR: [Both | High] A GENERAL NOTE: subclass a tableview or anything just if contains a conplicate logic, has many subviews or it is used in multiple places [Atti]
    init() {
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        frame = UIScreen.mainScreen().bounds
        estimatedRowHeight = 30.0
        rowHeight = UITableViewAutomaticDimension
        registerClass(StatsCell.self, forCellReuseIdentifier: "StatsCell")
        separatorColor = UIColor.clearColor()
        scrollEnabled = false
        allowsSelection = false
        backgroundColor = Color.mainBackground
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}