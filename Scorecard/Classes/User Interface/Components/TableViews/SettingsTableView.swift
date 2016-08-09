//
//  StatsTableView.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableView : UITableView {

    init() {
        super.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        registerClass(PreferenceSliderCell.self, forCellReuseIdentifier: "PreferenceSliderCell")
        allowsSelection = false
        scrollEnabled = false
        separatorColor = UIColor.clearColor()
        backgroundColor = Color.mainBackground
        rowHeight = 38
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}