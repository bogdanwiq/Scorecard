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

class StatisticsChart: LineChartView, ChartViewDelegate {
    
    var dataService = DataService.sharedInstance
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.chartBackground
        setupChart()
    }
    
    private func setupChart() {
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}