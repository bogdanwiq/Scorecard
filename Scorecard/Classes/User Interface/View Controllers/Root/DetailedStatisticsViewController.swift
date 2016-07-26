//
//  DetailedStatistics.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/21/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit
import Charts

class DetailedStatisticViewController : BaseViewController, UITableViewDataSource, ChartViewDelegate {
    
    let reuseIdentifier : String = "StatsCell"
    let statsDetail = StatsDetail()
    let detailedStatsTable = DetailedStatsTableView()
    let statisticsChart = StatisticsChart()
    let dataService = DataService.sharedInstance
    var currentStats: [Stats] = []
    
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
        
        detailedStatsTable.dataSource = self
        statisticsChart.delegate = self
        
        for _ in 0..<3 {
            currentStats.append(Stats(typeName: "", counter: 15, difference: 20, percent: 20, sign: "ArrowUp"))
        }
    
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
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[statsDetail(80)]-0-[detailedStatsTable(130)][statisticsChart(>=30)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        view.addConstraints(allConstraints)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : StatsCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! StatsCell
        cell.identifier.image = UIImage(named: "Circle")
        cell.typeName.text = currentStats[indexPath.row].typeName
        cell.difference.text = String(currentStats[indexPath.row].difference)
        cell.sign.image = currentStats[indexPath.row].getImage()
        return cell
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        let selectedIndex = entry.xIndex
        var i = 0
        var highlights: [ChartHighlight] = []
        for dataSet in (chartView.data?.dataSets)! {
            let marker = CircleMarker(color: (chartView.data?.dataSets[i].colors[0])!)
            marker.minimumSize = CGSizeMake(10.0 , 10.0)
            marker.offset = CGPointMake(0.0, 5.0)
            chartView.marker = marker
            let highlight = ChartHighlight(xIndex: selectedIndex, dataSetIndex: i)
            highlights.append(highlight)
            currentStats[i].typeName = dataSet.label!
            currentStats[i].difference = Int(dataSet.entryForIndex(selectedIndex)!.value)
            i += 1
        }
        chartView.highlightValues(highlights)
        detailedStatsTable.reloadData()
    }
    
}