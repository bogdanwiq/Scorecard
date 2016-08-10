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
        var endIndex = 0
        
        for i in 0..<json.length {
            if json.characterAtIndex(i) == "[".utf16.first! {
                startIndex = i
                break
            }
        }
        
        for i in (0..<json.length).reverse() {
            if json.characterAtIndex(i) == "]".utf16.first! {
                endIndex = i
                break
            }
        }
        return json.substringWithRange(NSMakeRange(startIndex, endIndex - startIndex + 1))
    }
    
    func setProfileSettings(userId: String, preferenceName: String, state: Bool) {
        
        var dict = NSUserDefaults.standardUserDefaults().objectForKey(userId) as! [String: Bool]?
        
        if dict == nil {
            dict = [:]
        }
        dict![preferenceName] = state
        NSUserDefaults.standardUserDefaults().setObject(dict, forKey: userId)
    }
    
    func getProfileSettings(userId: String, preferenceName: String) -> Bool {
        
        let dict = NSUserDefaults.standardUserDefaults().objectForKey(userId) as! [String: Bool]?
        
        if dict == nil {
            return false
        }
        else {
            return dict![preferenceName] ?? false
        }
    }
    
    func filter(projects: [Project], type: TimeFilter) -> [Project] {
        
        var filteredProjects: [Project] = []
        
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
                        switch type {
                        case .OneDay :
                            let intervalInHours = fabs(metricValue.date.timeIntervalSinceNow) / (60*60)
                            if intervalInHours <= 24 {
                                filteredSubmetric.values.append(metricValue)
                            }
                            break
                        case .OneWeek :
                            let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                            if intervalInDays <= 7 {
                                filteredSubmetric.values.append(metricValue)
                            }
                            break
                        case .OneMonth :
                            let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                            if intervalInDays <= 30 {
                                filteredSubmetric.values.append(metricValue)
                            }
                            break
                        case .OneYear :
                            let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                            if intervalInDays <= 365 {
                                filteredSubmetric.values.append(metricValue)
                            }
                            break
                        case .All :
                            filteredSubmetric.values.append(metricValue)
                            break
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
        return filteredProjects
    }
    
    func filterMetric(metric: Metric, type: TimeFilter) -> Metric {
        
        let filteredMetric = Metric()
        
        filteredMetric.name = metric.name
        filteredMetric.submetrics = []
        for submetric in metric.submetrics {
            let filteredSubmetric = Submetric()
            filteredSubmetric.id = submetric.id
            filteredSubmetric.name = submetric.name
            filteredSubmetric.values = []
            for metricValue in submetric.values {
                switch type {
                case .OneDay :
                    let intervalInHours = fabs(metricValue.date.timeIntervalSinceNow) / (60*60)
                    if intervalInHours <= 24 {
                        filteredSubmetric.values.append(metricValue)
                    }
                    break
                case .OneWeek :
                    let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                    if intervalInDays <= 7 {
                        filteredSubmetric.values.append(metricValue)
                    }
                    break
                case .OneMonth :
                    let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                    if intervalInDays <= 30 {
                        filteredSubmetric.values.append(metricValue)
                    }
                    break
                case .OneYear :
                    let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                    if intervalInDays <= 365 {
                        filteredSubmetric.values.append(metricValue)
                    }
                    break
                case .All :
                    filteredSubmetric.values.append(metricValue)
                    break
                }
            }
            if filteredSubmetric.values.count > 0 {
                filteredMetric.submetrics.append(filteredSubmetric)
            }
        }
        return filteredMetric
    }
    
    func getPreviousCount(projects: [Project], type: TimeFilter) -> [String: [String: (Int, Double)]] {
        
        var dictionary : [String: [String: (Int, Double)]] = [:]
        
        for project in projects {
            var sumSubmetrics: [String: (Int, Double)] = [:]
            for metric in project.metrics {
                var previousSum = 0.0
                var currentSum = 0.0
                for submetric in metric.submetrics {
                    for metricValue in submetric.values {
                        switch type {
                        case .OneDay :
                            let intervalInHours = fabs(metricValue.date.timeIntervalSinceNow) / (60*60)
                            if intervalInHours > 24 && intervalInHours <= 48 {
                                previousSum += Double(metricValue.value)
                            }
                            if intervalInHours <= 24 {
                                currentSum += Double(metricValue.value)
                            }
                            break
                        case .OneWeek :
                            let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                            if intervalInDays > 7 && intervalInDays <= 14 {
                                previousSum += Double(metricValue.value)
                            }
                            if intervalInDays <= 7 {
                                currentSum += Double(metricValue.value)
                            }
                            break
                        case .OneMonth :
                            let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                            if intervalInDays > 30 && intervalInDays <= 60 {
                                previousSum += Double(metricValue.value)
                            }
                            if intervalInDays <= 30 {
                                currentSum += Double(metricValue.value)
                            }
                            break
                        case .OneYear :
                            let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                            if intervalInDays > 365 && intervalInDays <= (2*365) {
                                previousSum += Double(metricValue.value)
                            }
                            if intervalInDays <= 365 {
                                currentSum += Double(metricValue.value)
                            }
                            break
                        case .All :
                            currentSum = 0.0
                            break
                        }
                    }
                }
                if previousSum <= 0.0 {
                    sumSubmetrics[metric.id] = (Int(currentSum), currentSum)
                } else {
                    sumSubmetrics[metric.id] = (Int(currentSum - previousSum), (currentSum - previousSum) * 100.0 / previousSum)
                }
                dictionary[project.id] = sumSubmetrics
            }
        }
        return dictionary
    }
    
    func getMetricPreviousCount(metric: Metric, type: TimeFilter) -> (Int, Double) {
        
        var differenceAndPercent : (Int, Double)
        var previousSum = 0.0
        var currentSum = 0.0
        
        for submetric in metric.submetrics {
            for metricValue in submetric.values {
                switch type {
                case .OneDay :
                    let intervalInHours = fabs(metricValue.date.timeIntervalSinceNow) / (60*60)
                    if intervalInHours > 24 && intervalInHours <= 48 {
                        previousSum += Double(metricValue.value)
                    }
                    if intervalInHours <= 24 {
                        currentSum += Double(metricValue.value)
                    }
                    break
                case .OneWeek :
                    let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                    if intervalInDays > 7 && intervalInDays <= 14 {
                        previousSum += Double(metricValue.value)
                    }
                    if intervalInDays <= 7 {
                        currentSum += Double(metricValue.value)
                    }
                    break
                case .OneMonth :
                    let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                    if intervalInDays > 30 && intervalInDays <= 60 {
                        previousSum += Double(metricValue.value)
                    }
                    if intervalInDays <= 30 {
                        currentSum += Double(metricValue.value)
                    }
                    break
                case .OneYear :
                    let intervalInDays = fabs(metricValue.date.timeIntervalSinceNow) / (24*60*60)
                    if intervalInDays > 365 && intervalInDays <= (2*365) {
                        previousSum += Double(metricValue.value)
                    }
                    if intervalInDays <= 365 {
                        currentSum += Double(metricValue.value)
                    }
                    break
                case .All :
                    currentSum = 0.0
                    break
                }
            }
        }
        if previousSum <= 0.0 {
            differenceAndPercent = (Int(currentSum), currentSum)
        } else {
            differenceAndPercent = (Int(currentSum - previousSum), (currentSum - previousSum) * 100.0 / previousSum)
        }
        return differenceAndPercent
    }
    
    func getSubmetricCount(metric: Metric) -> [Int] {
        
        var sum : [Int] = []
        
        for submetric in metric.submetrics {
            var currentSum = 0
            for metricValue in submetric.values {
                currentSum += metricValue.value
            }
            sum.append(currentSum)
        }
        return sum
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
        var date : String!
        
        for i in 0..<xAxis.count {
            chartValues.append(ChartDataEntry(value: Double(0), xIndex: i))
        }
        
        for metricValue in submetric {
            switch timeFrame {
            case 0:
                dateFormatter.dateFormat = "HH"
                date = dateFormatter.stringFromDate(metricValue.date) + ":00"
                break
            case 1:
                dateFormatter.dateFormat = "EEE"
                date = dateFormatter.stringFromDate(metricValue.date).uppercaseString
                break
            case 2:
                dateFormatter.dateFormat = "d"
                date = dateFormatter.stringFromDate(metricValue.date)
                break
            case 3:
                dateFormatter.dateFormat = "MMM"
                date = dateFormatter.stringFromDate(metricValue.date).uppercaseString
                break
            case 4:
                dateFormatter.dateFormat = "yyyy"
                date = dateFormatter.stringFromDate(metricValue.date)
                break
            default:
                break
            }
            chartValues[xAxis.indexOf(date)!].value += Double(metricValue.value)
        }
        return chartValues
    }
    
    func getYearsLimit(metric : Metric) -> [String] {
        
        var years : [String] = []
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
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
        } else {
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