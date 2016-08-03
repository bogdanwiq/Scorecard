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
import ChameleonFramework

class DetailedStatisticViewController : BaseViewController {
    
    let reuseIdentifier : String = "StatsDetailCell"
    let dataService = DataService.sharedInstance
    var statsDetail : StatsDetail!
    var statsTableDetail : UITableView!
    var statisticsChart : StatisticsChart!
    var currentMetric : Metric!
    var differenceAndPercent : (Int, Double)!
    var submetricArray : [Int] = []
    var evolutionArray : [EvolutionSign] = []
    var timeFrame : Int!
    var colors : [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.None
    }
    
    init(metric: Metric, differenceAndPercent: (Int, Double), timeFrame : Int){
        super.init()
        self.currentMetric = metric
        self.differenceAndPercent = differenceAndPercent
        self.timeFrame = timeFrame
        getPreviousSubmetricCount()
        // populate evolution sign array
        for _ in 0..<currentMetric.submetrics.count {
            evolutionArray.append(.None)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initUI() {
        view.backgroundColor = Color.mainBackground
        title = "Statistics"
        
        statsDetail = StatsDetail()
        statsDetail.delegate = self
        statsDetail.translatesAutoresizingMaskIntoConstraints = false
        setupInformation()
        view.addSubview(statsDetail)
        
        
        setupStatsTableDetail()
        statisticsChart = StatisticsChart()
        statisticsChart.delegate = self
        statisticsChart.translatesAutoresizingMaskIntoConstraints = false
        setChartData()
        view.addSubview(statisticsChart)
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
        
        if currentMetric.submetrics.count < screenResolutionFactor {
            tableHeight =  Int(statsTableDetail.rowHeight) * currentMetric.submetrics.count
        } else {
            tableHeight  = screenResolutionFactor * Int(statsTableDetail.rowHeight)
        }
        
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[statsDetail]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[statsTableDetail]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[statisticsChart]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[statsDetail][statsTableDetail(\(tableHeight))][statisticsChart]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        view.addConstraints(allConstraints)
    }
    
    func getPreviousSubmetricCount() {
        switch timeFrame {
        case 0 :
            submetricArray = dataService.getPreviousSubmetricCount(currentMetric, type: .OneDay)
            break
        case 1 :
            submetricArray = dataService.getPreviousSubmetricCount(currentMetric, type: .OneWeek)
            break
        case 2 :
            submetricArray = dataService.getPreviousSubmetricCount(currentMetric, type: .OneMonth)
            break
        case 3:
            submetricArray = dataService.getPreviousSubmetricCount(currentMetric, type: .OneYear)
            break
        case 4:
            submetricArray = dataService.getPreviousSubmetricCount(currentMetric, type: .All)
            break
        default :
            break
        }
    }
}

// MARK - UITableViewDataSource

extension DetailedStatisticViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMetric.submetrics.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : StatsDetailCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! StatsDetailCell
        
        let animation: CATransition = CATransition()
        
        animation.duration = 0.3
        animation.type = kCATransitionFade
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        cell.difference.layer.addAnimation(animation ,forKey :"layerFadeOut")
        cell.identifier.image = UIImage(named: "Circle")
        cell.identifier.image = cell.identifier.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        cell.identifier.tintColor = colors[indexPath.row]
        cell.typeName.text = currentMetric.submetrics[indexPath.row].name
        cell.difference.text = submetricArray[indexPath.row].prettyString()
        cell.sign.image = evolutionArray[indexPath.row].getSign()
        
        return cell
    }
}

// MARK - ChartViewDelegate

extension DetailedStatisticViewController: ChartViewDelegate {
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        
        let selectedIndex = entry.xIndex
        var i = 0
        var highlights: [ChartHighlight] = []
        
        for dataSet in (chartView.data?.dataSets)! {
            let marker = CircleMarker(color: (chartView.data?.dataSets[i].colors[0])!)
            marker.minimumSize = CGSizeMake(7.0 , 7.0)
            marker.offset = CGPointMake(0.0, 1.0)
            chartView.marker = marker
            
            let highlight = ChartHighlight(xIndex: selectedIndex, dataSetIndex: i)
            highlights.append(highlight)
            
            if selectedIndex != 0 {
                if (dataSet.entryForXIndex(selectedIndex)?.value)! > (dataSet.entryForXIndex(selectedIndex - 1)?.value)! {
                    evolutionArray[i] = .ArrowUp
                }
                else if (dataSet.entryForXIndex(selectedIndex)?.value)! < (dataSet.entryForXIndex(selectedIndex - 1)?.value)! {
                    evolutionArray[i] = .ArrowDown
                }
                else {
                    evolutionArray[i] = .None
                }
            }
            else {
                evolutionArray[i] = .None
            }
            
            currentMetric.submetrics[i].name = dataSet.label!
            submetricArray[i] = Int((dataSet.entryForXIndex(selectedIndex)?.value)!)
            
            i += 1
        }
        chartView.highlightValues(highlights)
        statsTableDetail.reloadData()
    }
    
    func setChartData() {
        var xAxis : [String] = []
        var colorArray = ColorSchemeOf(.Analogous, color: getRandomColor(), isFlatScheme: true)
        // extend color array to have as many values as the submetrics in the current metric
        while colorArray.count < currentMetric.submetrics.count {
            colorArray += ColorSchemeOf(.Analogous, color: colorArray[colorArray.count - 1], isFlatScheme: true)
        }
        
        switch timeFrame {
        case 0 :
            xAxis = ["01:00", "02:00", "03:00","04:00","05:00","06:00","07:00","08:00",
                     "09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00",
                     "17:00","18:00","19:00","20:00","21:00","22:00","23:00","0:00"]
            let chartData = LineChartData(xVals: xAxis)
            for i in 0..<currentMetric.submetrics.count {
                let submetricName = currentMetric.submetrics[i].name
                let chartEntries = dataService.getDiagramFor(currentMetric.submetrics[i].values, timeFrame: timeFrame, xAxis: xAxis)
                let chartDataSet = LineChartDataSet(yVals: chartEntries, label: submetricName)
                chartDataSet.mode = .CubicBezier
                chartDataSet.drawValuesEnabled = false
                chartDataSet.drawCirclesEnabled = false
                chartDataSet.setColor(colorArray[i], alpha: 0.5)
                chartDataSet.fillColor = colorArray[i]
                chartDataSet.fillAlpha = 0.5
                chartDataSet.drawFilledEnabled = true
                chartDataSet.highlightLineWidth = 0.0
                chartData.addDataSet(chartDataSet)
                colors.append(colorArray[i])
            }
            statisticsChart.data = chartData
            break
        case 1 :
            xAxis = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
            let chartData = LineChartData(xVals: xAxis)
            for i in 0..<currentMetric.submetrics.count {
                let submetricName = currentMetric.submetrics[i].name
                let chartEntries = dataService.getDiagramFor(currentMetric.submetrics[i].values, timeFrame: timeFrame, xAxis: xAxis)
                let chartDataSet = LineChartDataSet(yVals: chartEntries, label: submetricName)
                chartDataSet.mode = .CubicBezier
                chartDataSet.drawValuesEnabled = false
                chartDataSet.drawCirclesEnabled = false
                chartDataSet.setColor(colorArray[i], alpha: 0.5)
                chartDataSet.fillColor = colorArray[i]
                chartDataSet.fillAlpha = 0.5
                chartDataSet.drawFilledEnabled = true
                chartDataSet.highlightLineWidth = 0.0
                chartData.addDataSet(chartDataSet)
                colors.append(colorArray[i])
            }
            statisticsChart.data = chartData
            break
        case 2 :
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM"
            let currentMonth = dateFormatter.stringFromDate(NSDate()).uppercaseString
            switch currentMonth {
            case "JAN", "MAR", "MAY", "JUL", "AUG", "OCT", "DEC": //31
                xAxis = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12",
                         "13", "14", "15", "16", "17", "18", "19", "20", "21", "22",
                         "23", "24", "25", "26", "27", "28", "29", "30", "31"]
                let chartData = LineChartData(xVals: xAxis)
                for i in 0..<currentMetric.submetrics.count {
                    let submetricName = currentMetric.submetrics[i].name
                    let chartEntries = dataService.getDiagramFor(currentMetric.submetrics[i].values, timeFrame: timeFrame, xAxis: xAxis)
                    let chartDataSet = LineChartDataSet(yVals: chartEntries, label: submetricName)
                    chartDataSet.mode = .CubicBezier
                    chartDataSet.drawValuesEnabled = false
                    chartDataSet.drawCirclesEnabled = false
                    chartDataSet.setColor(colorArray[i], alpha: 0.5)
                    chartDataSet.fillColor = colorArray[i]
                    chartDataSet.fillAlpha = 0.5
                    chartDataSet.drawFilledEnabled = true
                    chartDataSet.highlightLineWidth = 0.0
                    chartData.addDataSet(chartDataSet)
                    colors.append(colorArray[i])
                }
                statisticsChart.data = chartData
                break
            case "FEB": // 28
                xAxis = ["1", "2", "3", "4", "5", "6", "7", "8",
                         "9", "10", "11", "12", "13", "14", "15",
                         "16", "17", "18", "19", "20", "21", "22",
                         "23", "24", "25", "26", "27", "28"]
                let chartData = LineChartData(xVals: xAxis)
                for i in 0..<currentMetric.submetrics.count {
                    let submetricName = currentMetric.submetrics[i].name
                    let chartEntries = dataService.getDiagramFor(currentMetric.submetrics[i].values, timeFrame: timeFrame, xAxis: xAxis)
                    let chartDataSet = LineChartDataSet(yVals: chartEntries, label: submetricName)
                    chartDataSet.mode = .CubicBezier
                    chartDataSet.drawValuesEnabled = false
                    chartDataSet.drawCirclesEnabled = false
                    chartDataSet.setColor(colorArray[i], alpha: 0.5)
                    chartDataSet.fillColor = colorArray[i]
                    chartDataSet.fillAlpha = 0.5
                    chartDataSet.drawFilledEnabled = true
                    chartDataSet.highlightLineWidth = 0.0
                    chartData.addDataSet(chartDataSet)
                    colors.append(colorArray[i])
                }
                statisticsChart.data = chartData
                break
            case "APR", "JUN", "SEP", "NOV": //30
                xAxis = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
                         "12", "13", "14", "15", "16", "17", "18", "19", "20",
                         "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
                let chartData = LineChartData(xVals: xAxis)
                for i in 0..<currentMetric.submetrics.count {
                    let submetricName = currentMetric.submetrics[i].name
                    let chartEntries = dataService.getDiagramFor(currentMetric.submetrics[i].values, timeFrame: timeFrame, xAxis: xAxis)
                    let chartDataSet = LineChartDataSet(yVals: chartEntries, label: submetricName)
                    chartDataSet.mode = .CubicBezier
                    chartDataSet.drawValuesEnabled = false
                    chartDataSet.drawCirclesEnabled = false
                    chartDataSet.setColor(colorArray[i], alpha: 0.5)
                    chartDataSet.fillColor = colorArray[i]
                    chartDataSet.fillAlpha = 0.5
                    chartDataSet.drawFilledEnabled = true
                    chartDataSet.highlightLineWidth = 0.0
                    chartData.addDataSet(chartDataSet)
                    colors.append(colorArray[i])
                }
                statisticsChart.data = chartData
                break
            default:
                break
            }
            break
        case 3:
            xAxis = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
            let chartData = LineChartData(xVals: xAxis)
            for i in 0..<currentMetric.submetrics.count {
                let submetricName = currentMetric.submetrics[i].name
                let chartEntries = dataService.getDiagramFor(currentMetric.submetrics[i].values, timeFrame: timeFrame, xAxis: xAxis)
                let chartDataSet = LineChartDataSet(yVals: chartEntries, label: submetricName)
                chartDataSet.mode = .CubicBezier
                chartDataSet.drawValuesEnabled = false
                chartDataSet.drawCirclesEnabled = false
                chartDataSet.setColor(colorArray[i], alpha: 0.5)
                chartDataSet.fillColor = colorArray[i]
                chartDataSet.fillAlpha = 0.5
                chartDataSet.drawFilledEnabled = true
                chartDataSet.highlightLineWidth = 0.0
                chartData.addDataSet(chartDataSet)
                colors.append(colorArray[i])
            }
            statisticsChart.data = chartData
            break
        case 4:
            xAxis = dataService.getYearsLimit(currentMetric)
            let chartData = LineChartData(xVals: xAxis)
            for i in 0..<currentMetric.submetrics.count {
                let submetricName = currentMetric.submetrics[i].name
                let chartEntries = dataService.getDiagramFor(currentMetric.submetrics[i].values, timeFrame: timeFrame, xAxis: xAxis)
                let chartDataSet = LineChartDataSet(yVals: chartEntries, label: submetricName)
                chartDataSet.mode = .CubicBezier
                chartDataSet.drawValuesEnabled = false
                chartDataSet.drawCirclesEnabled = false
                chartDataSet.setColor(colorArray[i], alpha: 0.5)
                chartDataSet.fillColor = colorArray[i]
                chartDataSet.fillAlpha = 0.5
                chartDataSet.drawFilledEnabled = true
                chartDataSet.highlightLineWidth = 0.0
                chartData.addDataSet(chartDataSet)
                colors.append(colorArray[i])
            }
            statisticsChart.data = chartData
            break
        default :
            break
        }
    }
    
    func getRandomColor() -> UIColor {
        
        var color = RandomFlatColorWithShade(.Light)
        while [FlatBlack(), FlatBlackDark(), FlatGray(), FlatGrayDark(), FlatWhite(), FlatWhiteDark()].contains(color) {
            color = RandomFlatColorWithShade(.Light)
        }
        return color
    }
}

// MARK - StatsDetailDelegate

extension DetailedStatisticViewController: StatsDetailSetupInformationDelegate {
    func setupInformation(){
        
        statsDetail.typeName.text = currentMetric.name
        statsDetail.counter.text = dataService.sumMetricValues(currentMetric)
        if differenceAndPercent.0 < 0 {
            statsDetail.difference.text = "\(differenceAndPercent.0.prettyString())"
            statsDetail.difference.textColor = Color.statsFall
            statsDetail.percent.textColor = Color.statsFall
            statsDetail.percent.text = String(format: "%.2f",differenceAndPercent.1) + "%"
            statsDetail.sign.image = EvolutionSign.ArrowDown.getSign()
        }
        else if differenceAndPercent.0 == 0 {
            statsDetail.difference.text = "\(differenceAndPercent.0.prettyString())"
            statsDetail.difference.textColor = Color.textColor
            statsDetail.percent.textColor = Color.textColor
            statsDetail.percent.text = String(format: "%.2f",differenceAndPercent.1) + "%"
            statsDetail.sign.image = EvolutionSign.None.getSign()
        }
        else if differenceAndPercent.0 > 0 {
            statsDetail.difference.text = "+\(differenceAndPercent.0.prettyString())"
            statsDetail.difference.textColor = Color.statsRise
            statsDetail.percent.textColor = Color.statsRise
            statsDetail.percent.text = String(format: "+%.2f",differenceAndPercent.1) + "%"
            statsDetail.sign.image = EvolutionSign.ArrowUp.getSign()
        }
    }
}