//
//  StatisticsChart.swift
//  Scorecard
//
//  Created by Mac  on 7/25/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit
import Charts
import ChameleonFramework

class StatisticsChart: LineChartView, ChartViewDelegate {
    
    var dataService = DataService.sharedInstance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawLabelsEnabled = false
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawLabelsEnabled = false
        rightAxis.drawGridLinesEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.labelPosition = .TopInside
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.labelFont = UIFont(name: "HelveticaNeue", size: kAxisFontSize)!
        xAxis.labelTextColor = Color.chartTextColor
        drawGridBackgroundEnabled = false
        drawBordersEnabled = false
        legend.enabled = false
        descriptionText = ""
        animate(xAxisDuration: 0.0, yAxisDuration: 1.0, easingOption: .EaseInSine)
        setViewPortOffsets(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0)
        backgroundColor = Color.chartBackground
        
        setChartData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getRandomColor() -> UIColor {
        
        var color = RandomFlatColorWithShade(.Light)
        while [FlatBlack(), FlatBlackDark(), FlatGray(), FlatGrayDark(), FlatWhite(), FlatWhiteDark()].contains(color) {
            color = RandomFlatColorWithShade(.Light)
        }
        return color
    }
    
    func setChartData() {
        
        let months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
        let downloads = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let users = [12.0, 15.0, 6.0, 5.0, 2.0, 60.0, 44.0, 52.0, 30.0, 47.0, 14.0, 4.0]
        let updates = [53.0, 28.0, 22.0, 13.0, 12.0, 6.0, 17.0, 63.0, 48.0, 56.0, 20.0, 12.0]
        var downloadsEntries: [ChartDataEntry] = []
        var usersEntries: [ChartDataEntry] = []
        var updatesEntries: [ChartDataEntry] = []
        var colorArray = ColorSchemeOf(.Analogous, color: getRandomColor(), isFlatScheme: true)
        
        for i in 0..<months.count {
            let dataEntry = ChartDataEntry(value: updates[i], xIndex: i)
            updatesEntries.append(dataEntry)
        }
        
        let updatesDataSet = LineChartDataSet(yVals: updatesEntries, label: "Updates")
        updatesDataSet.mode = .CubicBezier
        updatesDataSet.drawValuesEnabled = false
        updatesDataSet.drawCirclesEnabled = false
        updatesDataSet.setColor(colorArray[1], alpha: 0.5)
        updatesDataSet.fillColor = colorArray[1]
        updatesDataSet.fillAlpha = 0.5
        updatesDataSet.drawFilledEnabled = true
        updatesDataSet.highlightLineWidth = 0.0
        
        for i in 0..<months.count {
            let dataEntry = ChartDataEntry(value: users[i], xIndex: i)
            usersEntries.append(dataEntry)
        }
        
        let usersDataSet = LineChartDataSet(yVals: usersEntries, label: "Users")
        usersDataSet.mode = .CubicBezier
        usersDataSet.drawValuesEnabled = false
        usersDataSet.drawCirclesEnabled = false
        usersDataSet.setColor(colorArray[2], alpha: 0.5)
        usersDataSet.fillColor = colorArray[2]
        usersDataSet.fillAlpha = 0.5
        usersDataSet.drawFilledEnabled = true
        usersDataSet.highlightEnabled = false
        
        for i in 0..<months.count {
            let dataEntry = ChartDataEntry(value: downloads[i], xIndex: i)
            downloadsEntries.append(dataEntry)
        }
        
        let downloadsDataSet = LineChartDataSet(yVals: downloadsEntries, label: "Downloads")
        downloadsDataSet.mode = .CubicBezier
        downloadsDataSet.drawValuesEnabled = false
        downloadsDataSet.drawCirclesEnabled = false
        downloadsDataSet.setColor(colorArray[3], alpha: 0.5)
        downloadsDataSet.fillColor = colorArray[3]
        downloadsDataSet.fillAlpha = 0.5
        downloadsDataSet.drawFilledEnabled = true
        downloadsDataSet.highlightEnabled = false
        
        let chartData = LineChartData(xVals: months, dataSet: updatesDataSet)
        chartData.addDataSet(usersDataSet)
        chartData.addDataSet(downloadsDataSet)
        data = chartData
    }
}