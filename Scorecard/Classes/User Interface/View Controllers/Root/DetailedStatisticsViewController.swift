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
    
    let reuseIdentifier : String = "StatsDetailCell"
    let dataService = DataService.sharedInstance
    var statsDetail : StatsDetail!
    var statsTableDetail : UITableView!
    var statisticsChart : StatisticsChart!
    var currentStats: [Stats] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.None
    }
    
    override func initUI() {
        view.backgroundColor = Color.mainBackground
        title = "Statistics"
        
        statsDetail = StatsDetail()
        statsDetail.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statsDetail)
        
        setupStatsTableDetail()
        statisticsChart = StatisticsChart()
        statisticsChart.delegate = self
        statisticsChart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statisticsChart)
        
        for _ in 0..<6 {
            currentStats.append(Stats(typeName: "Updates", counter: 15, difference: 20, percent: 20, sign: .ArrowUp))
            currentStats.append(Stats(typeName: "Users", counter: 135, difference: 220, percent: 201, sign: .ArrowDown))
            currentStats.append(Stats(typeName: "Downloads", counter: 175, difference: 120, percent: 120, sign: .None))
        }
    }
    
    private func setupStatsTableDetail(){
        statsTableDetail = UITableView()
        statsTableDetail.dataSource = self
        statsTableDetail.backgroundColor = Color.mainBackground
        statsTableDetail.registerClass(StatsDetailCell.self, forCellReuseIdentifier: "StatsDetailCell")
        statsTableDetail.separatorColor = UIColor.clearColor()
        statsTableDetail.translatesAutoresizingMaskIntoConstraints = false
        statsTableDetail.rowHeight = 30.0
        statsTableDetail.allowsSelection = false
        view.addSubview(statsTableDetail)
    }
    
    override func setupConstraints() {
        
        var allConstraints = [NSLayoutConstraint]()
        let dictionary = ["statsDetail": statsDetail, "statsTableDetail": statsTableDetail, "statisticsChart": statisticsChart]
        var tableHeight : Int = 0
        let screenResolutionFactor = Int(screenHeight/100)-1
        
        if currentStats.count < screenResolutionFactor {
            tableHeight =  Int(statsTableDetail.rowHeight) * currentStats.count
        } else {
            tableHeight  = screenResolutionFactor * Int(statsTableDetail.rowHeight)
        }
        
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[statsDetail]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[statsTableDetail]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[statisticsChart]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[statsDetail][statsTableDetail(\(tableHeight))][statisticsChart]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        view.addConstraints(allConstraints)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentStats.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : StatsDetailCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! StatsDetailCell
        let animation: CATransition = CATransition()
        
        animation.duration = 0.3
        animation.type = kCATransitionFade
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        cell.difference.layer.addAnimation(animation ,forKey :"layerFadeOut")
        
        cell.difference.text = String(currentStats[indexPath.row].difference)
        cell.sign.image = currentStats[indexPath.row].getImage()
        cell.identifier.image = UIImage(named: "Circle")
        cell.typeName.text = currentStats[indexPath.row].typeName
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
        statsTableDetail.reloadData()
    }
}