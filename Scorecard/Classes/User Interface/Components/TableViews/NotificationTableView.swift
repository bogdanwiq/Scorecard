//
//  NotificationTableView.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/5/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class NotificationTableView : UITableView {
    
    init() {
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        registerClass(NotificationCell.self, forCellReuseIdentifier: "NotificationCell")
        allowsSelection = false
        scrollEnabled = true
        separatorColor = UIColor.clearColor()
        backgroundColor = Color.mainBackground
        rowHeight = 90
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}