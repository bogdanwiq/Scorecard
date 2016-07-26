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