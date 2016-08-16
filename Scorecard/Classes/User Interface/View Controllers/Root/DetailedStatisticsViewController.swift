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
    var submetricArray : [Int] = []
    var timeFrame : Int!
    var colors : [UIColor] = []
    var allColors : [UIColor] = []
    var statsTableDetail : UITableView!
    var differenceAndPercent : (Int, Double)!
    var currentMetric : Metric!
    var originalMetric : Metric!
    var statsDetail : StatsDetail!
    let timeFrameView = TimeFrame()
    var statisticsChart : StatisticsChart!
    var evolutionArray : [EvolutionSign] = []
    var allHighlights: [ChartHighlight] = []
    var highlights: [Int: ChartHighlight] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        let backButton = Button.Back.getButton()
        backButton.addTarget(self, action: #selector(goBack), forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.None
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    init(originalMetric: Metric, metric: Metric, differenceAndPercent: (Int, Double), timeFrame : Int) {
        super.init()
        self.originalMetric = originalMetric
        self.currentMetric = metric
        self.differenceAndPercent = differenceAndPercent
        self.timeFrame = timeFrame
        submetricArray = dataService.getSubmetricCount(currentMetric)
        for _ in 0..<currentMetric.submetrics.count {
            evolutionArray.append(.dNone)
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
        
        timeFrameView.selectedIndex = timeFrame
        timeFrameView.delegate = self
        timeFrameView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeFrameView)
        
        statisticsChart = StatisticsChart()
        statisticsChart.delegate = self
        statisticsChart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statisticsChart)
        setChartData()
        
        statsTableDetail = UITableView()
        statsTableDetail.dataSource = self
        statsTableDetail.delegate = self
        statsTableDetail.backgroundColor = Color.mainBackground
        statsTableDetail.registerClass(StatsDetailCell.self, forCellReuseIdentifier: "StatsDetailCell")
        statsTableDetail.separatorColor = UIColor.clearColor()
        statsTableDetail.translatesAutoresizingMaskIntoConstraints = false
        statsTableDetail.rowHeight = 30.0
        statsTableDetail.allowsSelection = true
        view.addSubview(statsTableDetail)
    }
    
    func goBack() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func setupConstraints() {
        
        var allConstraints = [NSLayoutConstraint]()
        let views : [String: UIView] = ["statsDetail": statsDetail, "timeFrameView": timeFrameView, "statsTableDetail": statsTableDetail, "statisticsChart": statisticsChart]
        var tableHeight : Int = 0
        let screenResolutionFactor = Int(screenHeight/100)-1
        
        if currentMetric.submetrics.count < screenResolutionFactor {
            tableHeight = Int(statsTableDetail.rowHeight) * currentMetric.submetrics.count
        } else {
            tableHeight = screenResolutionFactor * Int(statsTableDetail.rowHeight)
        }
        tableHeight += 8
        
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[timeFrameView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        allConstraints.append(NSLayoutConstraint(item: statsTableDetail, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: CGFloat(tableHeight)))
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[timeFrameView(30)][statsDetail][statsTableDetail][statisticsChart]|", options: [.AlignAllLeft, .AlignAllRight], metrics: nil, views: views)
        view.addConstraints(allConstraints)
    }
}

// MARK - UITableViewDelegate

extension DetailedStatisticViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let boolean = (statisticsChart.data?.dataSets[indexPath.row].isVisible)!
        statisticsChart.data?.dataSets[indexPath.row].visible = !boolean
        let cell : StatsDetailCell = tableView.cellForRowAtIndexPath(indexPath) as! StatsDetailCell
        cell.backgroundColor = Color.mainBackground
        let customView = UIView()
        
        if statisticsChart.data?.dataSets[indexPath.row].visible == true {
            colors[indexPath.row] = allColors[indexPath.row]
            if allHighlights != [] {
                highlights[indexPath.row] = allHighlights[indexPath.row]
            }
        }
        else {
            colors[indexPath.row] = UIColor.darkGrayColor()
            highlights.removeValueForKey(indexPath.row)
        }
        
        cell.identifier.tintColor = colors[indexPath.row]
        customView.backgroundColor = colors[indexPath.row]
        cell.selectedBackgroundView = customView
        statisticsChart.highlightValues(Array<ChartHighlight>(highlights.values))
        statisticsChart.data?.dataSets[indexPath.row].notifyDataSetChanged()
        statisticsChart.setNeedsDisplay()
        statsTableDetail.deselectRowAtIndexPath(indexPath, animated: true)
        statsTableDetail.reloadData()
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
        cell.sign.layer.addAnimation(animation, forKey :"layerFadeOut")
        cell.identifier.image = UIImage(named: "Circle")
        cell.identifier.image = cell.identifier.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        cell.identifier.tintColor = colors[indexPath.row]
        cell.typeName.text = currentMetric.submetrics[indexPath.row].name
        if statisticsChart.data?.dataSets[indexPath.row].visible == true {
            cell.difference.text = submetricArray[indexPath.row].prettyString()
            cell.sign.image = evolutionArray[indexPath.row].getSign()
        }
        else {
            cell.difference.text = ""
            cell.sign.image = EvolutionSign.dNone.getSign()
        }
        return cell
    }
}

// MARK - ChartViewDelegate

extension DetailedStatisticViewController: ChartViewDelegate {
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        
        let selectedIndex = entry.xIndex
        var i = 0
        
        allHighlights = []
        highlights = [:]
        
        for dataSet in (chartView.data?.dataSets)! {
            let marker = CircleMarker(color: (chartView.data?.dataSets[i].colors[0])!)
            
            marker.minimumSize = CGSizeMake(7.0 , 7.0)
            marker.offset = CGPointMake(0.0, 1.0)
            chartView.marker = marker
            let highlight = ChartHighlight(xIndex: selectedIndex, dataSetIndex: i)
            allHighlights.append(highlight)
            if dataSet.isVisible {
                let highlight = ChartHighlight(xIndex: selectedIndex, dataSetIndex: i)
                highlights[i] = highlight
            }
            submetricArray[i] = Int((dataSet.entryForXIndex(selectedIndex)?.value)!)
            if selectedIndex != 0 {
                if (dataSet.entryForXIndex(selectedIndex)?.value)! > (dataSet.entryForXIndex(selectedIndex - 1)?.value)! {
                    evolutionArray[i] = .dArrowUp
                } else if (dataSet.entryForXIndex(selectedIndex)?.value)! < (dataSet.entryForXIndex(selectedIndex - 1)?.value)! {
                    evolutionArray[i] = .dArrowDown
                } else {
                    evolutionArray[i] = .dNone
                }
            } else {
                evolutionArray[i] = .dNone
            }
            currentMetric.submetrics[i].name = dataSet.label!
            i += 1
        }
        chartView.highlightValues(Array<ChartHighlight>(highlights.values))
        statsTableDetail.reloadData()
    }
    
    func setChartData() {
        var xAxis : [String] = []
        var colorArray = ColorSchemeOf(.Analogous, color: getRandomColor(), isFlatScheme: true)
        var chartDataSet: LineChartDataSet
        
        // empty color arrays
        colors = []
        allColors = []
        
        while colorArray.count < currentMetric.submetrics.count {
            colorArray += ColorSchemeOf(.Analogous, color: colorArray[colorArray.count - 1], isFlatScheme: true)
        }
        
        switch timeFrame {
        case 0 :
            xAxis = ["01:00", "02:00", "03:00","04:00","05:00","06:00","07:00","08:00",
                     "09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00",
                     "17:00","18:00","19:00","20:00","21:00","22:00","23:00","0:00"]
            break
        case 1 :
            xAxis = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
            break
        case 2 :
            let dateFormatter = DateFormatter(format: .Month)
            let currentMonth = dateFormatter.stringFromDate(NSDate()).uppercaseString
            switch currentMonth {
            case "JAN", "MAR", "MAY", "JUL", "AUG", "OCT", "DEC":
                xAxis = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12",
                         "13", "14", "15", "16", "17", "18", "19", "20", "21", "22",
                         "23", "24", "25", "26", "27", "28", "29", "30", "31"]
                break
            case "FEB":
                xAxis = ["1", "2", "3", "4", "5", "6", "7", "8",
                         "9", "10", "11", "12", "13", "14", "15",
                         "16", "17", "18", "19", "20", "21", "22",
                         "23", "24", "25", "26", "27", "28"]
                break
            case "APR", "JUN", "SEP", "NOV":
                xAxis = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
                         "12", "13", "14", "15", "16", "17", "18", "19", "20",
                         "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
                break
            default:
                return
            }
            break
        case 3:
            xAxis = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
            break
        case 4:
            xAxis = dataService.getYearsLimit(currentMetric)
            break
        default :
            return
        }
        let chartData = LineChartData(xVals: xAxis)
        for i in 0..<currentMetric.submetrics.count {
            let submetricName = currentMetric.submetrics[i].name
            let chartEntries = dataService.getDiagramFor(currentMetric.submetrics[i].values, timeFrame: timeFrame, xAxis: xAxis)
            chartDataSet = LineChartDataSet(yVals: chartEntries, label: submetricName)
            customizeChart(chartDataSet, color: colorArray[i])
            chartData.addDataSet(chartDataSet)
        }
        statisticsChart.data = chartData
    }
    
    private func customizeChart(chart: LineChartDataSet, color: UIColor) {
        chart.mode = .CubicBezier
        chart.drawValuesEnabled = false
        chart.drawCirclesEnabled = false
        chart.setColor(color, alpha: 0.5)
        chart.fillColor = color
        chart.fillAlpha = 0.5
        chart.drawFilledEnabled = true
        chart.highlightLineWidth = 0.0
        colors.append(color)
        allColors.append(color)
    }
    
    private func getRandomColor() -> UIColor {
        
        var color = RandomFlatColorWithShade(.Light)
        
        while [FlatBlack(), FlatBlackDark(), FlatGray(), FlatGrayDark(), FlatWhite(), FlatWhiteDark()].contains(color) {
            color = RandomFlatColorWithShade(.Light)
        }
        return color
    }
}

// MARK - StatsDetailDelegate

extension DetailedStatisticViewController: StatsDetailSetupInformationDelegate {
    
    func setupInformation() {
        statsDetail.typeName.text = currentMetric.name
        statsDetail.counter.text = dataService.sumMetricValues(currentMetric)
        if differenceAndPercent.1 != 0 {
            statsDetail.percent.text = String(format: "%.2f",differenceAndPercent.1) + "%"
        } else {
            statsDetail.percent.text = ""
        }
        if differenceAndPercent.0 < 0 {
            statsDetail.difference.text = "\(differenceAndPercent.0.prettyString())"
            statsDetail.difference.textColor = Color.statsFall
            statsDetail.percent.textColor = Color.statsFall
            statsDetail.sign.image = EvolutionSign.ArrowDown.getSign()
        }
        else if differenceAndPercent.0 == 0 {
            statsDetail.difference.text = ""
            statsDetail.difference.textColor = Color.textColor
            statsDetail.percent.textColor = Color.textColor
            statsDetail.sign.image = EvolutionSign.None.getSign()
        }
        else if differenceAndPercent.0 > 0 {
            statsDetail.difference.text = "+\(differenceAndPercent.0.prettyString())"
            statsDetail.difference.textColor = Color.statsRise
            statsDetail.percent.textColor = Color.statsRise
            statsDetail.sign.image = EvolutionSign.ArrowUp.getSign()
        }
    }
}

extension DetailedStatisticViewController: TimeFrameDelegate {
    
    func timeFrameSelectedValue(selectedIndex: Int) {
        let animation: CATransition = CATransition()
        
        animation.duration = 0.3
        animation.type = kCATransitionFade
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        view.layer.addAnimation(animation,forKey :"layerFadeOut")
            
        var tableHeight = 0
        var newTableHeight = 0
        let screenResolutionFactor = Int(screenHeight/100)-1
        
        if currentMetric.submetrics.count < screenResolutionFactor {
            tableHeight =  Int(statsTableDetail.rowHeight) * currentMetric.submetrics.count
        } else {
            tableHeight  = screenResolutionFactor * Int(statsTableDetail.rowHeight)
        }
        tableHeight += 8
        timeFrame = selectedIndex
        switch selectedIndex {
        case 0 :
            currentMetric = dataService.filterMetric(originalMetric, type: .OneDay)
            differenceAndPercent = dataService.getMetricPreviousCount(originalMetric, type: .OneDay)
            break
        case 1 :
            currentMetric = dataService.filterMetric(originalMetric, type: .OneWeek)
            differenceAndPercent = dataService.getMetricPreviousCount(originalMetric, type: .OneWeek)
            break
        case 2 :
            currentMetric = dataService.filterMetric(originalMetric, type: .OneMonth)
            differenceAndPercent = dataService.getMetricPreviousCount(originalMetric, type: .OneMonth)
            break
        case 3 :
            currentMetric = dataService.filterMetric(originalMetric, type: .OneYear)
            differenceAndPercent = dataService.getMetricPreviousCount(originalMetric, type: .OneYear)
            break
        case 4 :
            currentMetric = dataService.filterMetric(originalMetric, type: .All)
            differenceAndPercent = dataService.getMetricPreviousCount(originalMetric, type: .All)
            break
        default :
            break
        }
        submetricArray = dataService.getSubmetricCount(currentMetric)
        setChartData()
        setupInformation()
        statsTableDetail.reloadData()
        evolutionArray.removeAll()
        statisticsChart.highlightValues([])
        for _ in 0..<currentMetric.submetrics.count {
            evolutionArray.append(.dNone)
        }
        if currentMetric.submetrics.count < screenResolutionFactor {
            newTableHeight =  Int(statsTableDetail.rowHeight) * currentMetric.submetrics.count
        } else {
            newTableHeight = screenResolutionFactor * Int(statsTableDetail.rowHeight)
        }
        newTableHeight += 8
        for constraint in view.constraints {
            if constraint.constant == CGFloat(tableHeight) {
                constraint.constant = CGFloat(newTableHeight)
            }
        }
    }
}