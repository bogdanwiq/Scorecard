//
//  DetailedStatistics.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/21/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class DetailedStatisticViewController : BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    override func initUI(){
        //Set Background
        self.view.backgroundColor = UIColorFromHex(kBackgroundColor, alpha: 1)
        self.navigationController?.navigationBar.translucent = false
        // Navigation Bar - TITLE
        self.title = "Statistics"
        self.navigationController?.navigationBar.titleTextAttributes = kNavigationTitleColor
        self.navigationController?.navigationBar.barTintColor = UIColorFromHex(kBackgroundColor, alpha: 1)
        // End Statistics Title
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.None
        // Buttons left & right
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let statsDetail = StatsDetail()
        statsDetail.frame = CGRectMake(0, 0, statsDetail.frame.width, 80)
        self.view.addSubview(statsDetail)
    }
}