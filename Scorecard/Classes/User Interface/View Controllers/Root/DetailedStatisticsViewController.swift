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
    
    let statsDetail = StatsDetail()
    let detailedStatsTable = DetailedStatsTableView()
    let statisticsChart = StatisticsChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = SharedApplication.delegate as! AppDelegate
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
        
        statsDetail.translatesAutoresizingMaskIntoConstraints = false
        detailedStatsTable.translatesAutoresizingMaskIntoConstraints = false
        statisticsChart.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(statsDetail)
        view.addSubview(detailedStatsTable)
        view.addSubview(statisticsChart)
    }
    override func setupConstraints() {
        var allConstraints = [NSLayoutConstraint]()
        let dictionary = ["statsDetail": statsDetail, "detailedStatsTable": detailedStatsTable, "statisticsChart": statisticsChart]
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[statsDetail]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[detailedStatsTable]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[statisticsChart]|", options:  NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[statsDetail(80)]-0-[detailedStatsTable(150)]-10-[statisticsChart(>=30)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        view.addConstraints(allConstraints)
    }
}