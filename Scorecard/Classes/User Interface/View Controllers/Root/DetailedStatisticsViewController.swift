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
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.None
    }
    
    override func initUI(){
        //Set Background
        view.backgroundColor = Color.mainBackground
        navigationController?.navigationBar.translucent = false
        // Navigation Bar - TITLE
        title = "Statistics"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.navigationTitle]
        navigationController?.navigationBar.barTintColor = Color.navigationBackground
        // End Statistics Title
        
        // Buttons left & right
        navigationController?.navigationBar.tintColor = Color.navigationTitle
        
        let statsDetail = StatsDetail()
        statsDetail.frame = CGRectMake(0, 0, statsDetail.frame.width, 80)
        view.addSubview(statsDetail)
    }
}