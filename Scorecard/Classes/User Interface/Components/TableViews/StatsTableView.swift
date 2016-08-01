//
//  StatsTableView.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class StatsTableView : UITableView {
    
    init() {
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        estimatedRowHeight = 80.0
        rowHeight = UITableViewAutomaticDimension
        registerClass(DashboardCell.self, forCellReuseIdentifier: "DashboardCell")
        separatorColor = UIColor.clearColor()
        backgroundColor = Color.mainBackground
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}