//
//  DataService.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/22/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import ObjectMapper
import Charts

enum TimeFilter {
    case OneDay
    case OneWeek
    case OneMonth
    case OneYear
    case All
}


class DataService {
    
    static let sharedInstance = DataService()
    
    func setupStats() -> [Project] {
        
        let path = NSBundle.mainBundle().pathForResource("example2", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let string = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        
        let projects: Array<Project>? = Mapper<Project>().mapArray(clipJSON(string))
        
        return projects!
    }
    
    private func clipJSON(json: NSString) -> String {
        var startIndex = 0
        for i in 0..<json.length {
            if json.characterAtIndex(i) == "[".utf16.first! {
                startIndex = i
                break
            }
        }
        var endIndex = 0
        for i in (0..<json.length).reverse() {
            if json.characterAtIndex(i) == "]".utf16.first! {
                endIndex = i
                break
            }
        }
        
        return json.substringWithRange(NSMakeRange(startIndex, endIndex - startIndex + 1))
    }
    
    func setProfileSettings(preferenceName: String, state: Bool) {
        NSUserDefaults.standardUserDefaults().setBool(state, forKey: preferenceName)
    }
    
    func getProfileSettings(preferenceName: String) -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(preferenceName)
    }
    
    func filter(projects: [Project], type: TimeFilter) -> [Project] {
        
        var filteredProjects: [Project] = []
        
        switch type {
        case .OneDay :
            for project in projects {
                let filteredProject = Project()
                filteredProject.id = project.id
                filteredProject.name = project.name
                filteredProject.metrics = []
                for metric in project.metrics {
                    let filteredMetric = Metric()
                    filteredMetric.id = metric.id
                    filteredMetric.name = metric.name
                    filteredMetric.submetrics = []
                    for submetric in metric.submetrics {
                        let filteredSubmetric = Submetric()
                        filteredSubmetric.id = submetric.id
                        filteredSubmetric.name = submetric.name
                        filteredSubmetric.values = []
                        for metricValue in submetric.values {
                            let intervalInHours = fabs(metricValue.date.timeIntervalSinceNow) / (60*60)
                            if intervalInHours <= 24 {
                                filteredSubmetric.values.append(metricValue)
                            }
                        }
                        if filteredSubmetric.values.count > 0 {
                            filteredMetric.submetrics.append(filteredSubmetric)
                        }
                    }
                    if filteredMetric.submetrics.count > 0 {
                        filteredProject.metrics.append(filteredMetric)
                    }
                }
                if filteredProject.metrics.count > 0 {
                    filteredProjects.append(filteredProject)
                }
            }
            break
        case .OneWeek:
            for project in projects {
                let filteredProject = Project()
                filteredProject.id = project.id
                filteredProject.name = project.name
                filteredProject.metrics = []
                for metric in project.metrics {
                    let filteredMetric = Metric()
                    filteredMetric.id = metric.id
                    filteredMetric.name = metric.name
                    filteredMetric.submetrics = []
                    for submetric in metric.submetrics {
                        let filteredSubmetric = Submetric()
                        filteredSubmetric.id = submetric.id
                        filteredSubmetric.name = submetric.name
                        filteredSubmetric.values = []
                        for metricValue in submetric.values {
                            let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                            if intervalInDays <= 7 {
                                filteredSubmetric.values.append(metricValue)
                            }
                        }
                        if filteredSubmetric.values.count > 0 {
                            filteredMetric.submetrics.append(filteredSubmetric)
                        }
                    }
                    if filteredMetric.submetrics.count > 0 {
                        filteredProject.metrics.append(filteredMetric)
                    }
                }
                if filteredProject.metrics.count > 0 {
                    filteredProjects.append(filteredProject)
                }
            }
            break
        case .OneMonth:
            for project in projects {
                let filteredProject = Project()
                filteredProject.id = project.id
                filteredProject.name = project.name
                filteredProject.metrics = []
                for metric in project.metrics {
                    let filteredMetric = Metric()
                    filteredMetric.id = metric.id
                    filteredMetric.name = metric.name
                    filteredMetric.submetrics = []
                    for submetric in metric.submetrics {
                        let filteredSubmetric = Submetric()
                        filteredSubmetric.id = submetric.id
                        filteredSubmetric.name = submetric.name
                        filteredSubmetric.values = []
                        for metricValue in submetric.values {
                            let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                            if intervalInDays <= 30 {
                                filteredSubmetric.values.append(metricValue)
                            }
                        }
                        if filteredSubmetric.values.count > 0 {
                            filteredMetric.submetrics.append(filteredSubmetric)
                        }
                    }
                    if filteredMetric.submetrics.count > 0 {
                        filteredProject.metrics.append(filteredMetric)
                    }
                }
                if filteredProject.metrics.count > 0 {
                    filteredProjects.append(filteredProject)
                }
            }
            break
        case .OneYear:
            for project in projects {
                let filteredProject = Project()
                filteredProject.id = project.id
                filteredProject.name = project.name
                filteredProject.interval = project.interval
                filteredProject.metrics = []
                for metric in project.metrics {
                    let filteredMetric = Metric()
                    filteredMetric.id = metric.id
                    filteredMetric.name = metric.name
                    filteredMetric.submetrics = []
                    for submetric in metric.submetrics {
                        let filteredSubmetric = Submetric()
                        filteredSubmetric.id = submetric.id
                        filteredSubmetric.name = submetric.name
                        filteredSubmetric.values = []
                        for metricValue in submetric.values {
                            let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                            if intervalInDays <= 365 {
                                filteredSubmetric.values.append(metricValue)
                            }
                        }
                        if filteredSubmetric.values.count > 0 {
                            filteredMetric.submetrics.append(filteredSubmetric)
                        }
                    }
                    if filteredMetric.submetrics.count > 0 {
                        filteredProject.metrics.append(filteredMetric)
                    }
                }
                if filteredProject.metrics.count > 0 {
                    filteredProjects.append(filteredProject)
                }
            }
            break
        case .All:
            filteredProjects = projects
            break
        }
        return filteredProjects
    }
    
    func getPreviousCount(projects: [Project], type: TimeFilter) -> [String: [String: (Int, Double)]] {
        var dictionary : [String: [String: (Int, Double)]] = [:]
        switch type {
        case .OneDay :
            for project in projects {
                var sumSubmetrics: [String: (Int, Double)] = [:]
                for metric in project.metrics {
                    var previousSum = 0.0
                    var currentSum = 0.0
                    for submetric in metric.submetrics {
                        for metricValue in submetric.values {
                            let intervalInHours = fabs(metricValue.date.timeIntervalSinceNow) / (60*60)
                            if intervalInHours > 24 && intervalInHours <= 48 {
                                previousSum += Double(metricValue.value)
                            }
                            if intervalInHours <= 24 {
                                currentSum += Double(metricValue.value)
                            }
                        }
                    }
                    if previousSum <= 0.0 {
                        sumSubmetrics[metric.id] = (Int(currentSum), currentSum)
                    }
                    else {
                        sumSubmetrics[metric.id] = (Int(currentSum - previousSum), (currentSum - previousSum) * 100.0 / previousSum)
                    }
                }
                dictionary[project.id] = sumSubmetrics
            }
            break
        case .OneWeek:
            for project in projects {
                var sumSubmetrics: [String: (Int, Double)] = [:]
                for metric in project.metrics {
                    var previousSum = 0.0
                    var currentSum = 0.0
                    for submetric in metric.submetrics {
                        for metricValue in submetric.values {
                            let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                            if intervalInDays > 7 && intervalInDays <= 14 {
                                previousSum += Double(metricValue.value)
                            }
                            if intervalInDays <= 7 {
                                currentSum += Double(metricValue.value)
                            }
                        }
                    }
                    if previousSum <= 0.0 {
                        sumSubmetrics[metric.id] = (Int(currentSum), currentSum)
                    }
                    else {
                        sumSubmetrics[metric.id] = (Int(currentSum - previousSum), (currentSum - previousSum) * 100.0 / previousSum)
                    }
                }
                dictionary[project.id] = sumSubmetrics
            }
            break
        case .OneMonth:
            for project in projects {
                var sumSubmetrics: [String: (Int, Double)] = [:]
                for metric in project.metrics {
                    var previousSum = 0.0
                    var currentSum = 0.0
                    for submetric in metric.submetrics {
                        for metricValue in submetric.values {
                            let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                            if intervalInDays > 30 && intervalInDays <= 60 {
                                previousSum += Double(metricValue.value)
                            }
                            if intervalInDays <= 30 {
                                currentSum += Double(metricValue.value)
                            }
                        }
                    }
                    if previousSum <= 0.0 {
                        sumSubmetrics[metric.id] = (Int(currentSum), currentSum)
                    }
                    else {
                        sumSubmetrics[metric.id] = (Int(currentSum - previousSum), (currentSum - previousSum) * 100.0 / previousSum)
                    }
                }
                dictionary[project.id] = sumSubmetrics
            }
            break
        case .OneYear:
            for project in projects {
                var sumSubmetrics: [String: (Int, Double)] = [:]
                for metric in project.metrics {
                    var previousSum = 0.0
                    var currentSum = 0.0
                    for submetric in metric.submetrics {
                        for metricValue in submetric.values {
                            let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                            if intervalInDays > 365 && intervalInDays <= (2*365) {
                                previousSum += Double(metricValue.value)
                            }
                            if intervalInDays <= 365 {
                                currentSum += Double(metricValue.value)
                            }
                        }
                    }
                    if previousSum <= 0.0 {
                        sumSubmetrics[metric.id] = (Int(currentSum), currentSum)
                    }
                    else {
                        sumSubmetrics[metric.id] = (Int(currentSum - previousSum), (currentSum - previousSum) * 100.0 / previousSum)
                    }
                }
                dictionary[project.id] = sumSubmetrics
            }
            break
        case .All:
            for project in projects {
                var sumSubmetrics: [String: (Int, Double)] = [:]
                for metric in project.metrics {
                    sumSubmetrics[metric.id] = (0, 0.0)
                }
                dictionary[project.id] = sumSubmetrics
            }
            break
        }
        return dictionary
    }
    
    func getPreviousSubmetricCount(metric: Metric, type: TimeFilter) -> [Int] {
        var difference : [Int] = []
        switch type {
        case .OneDay :
            for submetric in metric.submetrics {
                var previousSum = 0
                var currentSum = 0
                for metricValue in submetric.values {
                    let intervalInHours = fabs(metricValue.date.timeIntervalSinceNow) / (60*60)
                    if intervalInHours > 24 && intervalInHours <= 48 {
                        previousSum += metricValue.value
                    }
                    if intervalInHours <= 24 {
                        currentSum += metricValue.value
                    }
                }
                difference.append(currentSum - previousSum)
            }
            break
        case .OneWeek:
            for submetric in metric.submetrics {
                var previousSum = 0
                var currentSum = 0
                for metricValue in submetric.values {
                    let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                    if intervalInDays > 7 && intervalInDays <= 14 {
                        previousSum += metricValue.value
                    }
                    if intervalInDays <= 7 {
                        currentSum += metricValue.value
                    }
                }
                difference.append(currentSum - previousSum)
            }
            break
        case .OneMonth:
            for submetric in metric.submetrics {
                var previousSum = 0
                var currentSum = 0
                for metricValue in submetric.values {
                    let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                    if intervalInDays > 30 && intervalInDays <= 60 {
                        previousSum += metricValue.value
                    }
                    if intervalInDays <= 30 {
                        currentSum += metricValue.value
                    }
                }
                difference.append(currentSum - previousSum)
            }
            break
        case .OneYear:
            for submetric in metric.submetrics {
                var previousSum = 0
                var currentSum = 0
                for metricValue in submetric.values {
                    let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                    if intervalInDays > 365 && intervalInDays <= (2*365) {
                        previousSum += metricValue.value
                    }
                    if intervalInDays <= 365 {
                        currentSum += metricValue.value
                    }
                }
                difference.append(currentSum - previousSum)
            }
            break
        case .All:
            for submetric in metric.submetrics {
                var sumValues: Int = 0
                for values in submetric.values {
                    sumValues += values.value
                }
                difference.append(sumValues)
            }
            break
        }
        return difference
    }
    
    func sumMetricValues(metric: Metric) -> String {
        var count = 0
        for submetric in metric.submetrics {
            for value in submetric.values {
                count += value.value
            }
        }
        return count.prettyString()
    }
    
    func getDiagramFor(submetric: [MetricValue], timeFrame: Int, xAxis: [String]) -> [ChartDataEntry] {
        
        var chartValues : [ChartDataEntry] = []
        let dateFormatter = NSDateFormatter()
        for i in 0..<xAxis.count {
            chartValues.append(ChartDataEntry(value: Double(0), xIndex: i))
        }
        switch timeFrame {
        case 0:
            dateFormatter.dateFormat = "HH"
            for metricValue in submetric {
                let date = dateFormatter.stringFromDate(metricValue.date) + ":00"
                chartValues[xAxis.indexOf(date)!].value += Double(metricValue.value)
            }
            break
        case 1:
            dateFormatter.dateFormat = "EEE"
            for metricValue in submetric {
                let date = dateFormatter.stringFromDate(metricValue.date).uppercaseString
                chartValues[xAxis.indexOf(date)!].value += Double(metricValue.value)
            }
            break
        case 2:
            dateFormatter.dateFormat = "d"
            for metricValue in submetric {
                let date = dateFormatter.stringFromDate(metricValue.date)
                chartValues[xAxis.indexOf(date)!].value += Double(metricValue.value)
            }
            break
        case 3:
            dateFormatter.dateFormat = "MMM"
            for metricValue in submetric {
                let date = dateFormatter.stringFromDate(metricValue.date).uppercaseString
                chartValues[xAxis.indexOf(date)!].value += Double(metricValue.value)
            }
            break
        case 4:
            dateFormatter.dateFormat = "yyyy"
            for metricValue in submetric {
                let date = dateFormatter.stringFromDate(metricValue.date)
                chartValues[xAxis.indexOf(date)!].value += Double(metricValue.value)
            }
            break
        default :
            break
        }
        return chartValues
    }
    func getYearsLimit(metric : Metric) -> [String]{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        var years : [String] = []
        
        for submetric in metric.submetrics {
            for subvalues in submetric.values {
                let date = dateFormatter.stringFromDate(subvalues.date)
                years.append(date)
            }
        }
        years = Array(Set(years))
        years.sortInPlace()
        return years
    }
}

extension Int {
    
    func prettyString() -> String {
        var copy = abs(self)
        var i = 0
        var result = ""
        if copy == 0 {
            return "0"
        }
        else {
            while copy != 0 {
                result = String(copy % 10) + result
                copy /= 10
                i += 1
                if i % 3 == 0 && copy != 0 {
                    result = "." + result
                }
            }
        }
        return self >= 0 ? result : "-" + result
    }
}