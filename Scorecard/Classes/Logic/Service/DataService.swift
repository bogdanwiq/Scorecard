//
//  DataService.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/22/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import ObjectMapper

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
                    print("Project: \(project.name), metric: \(metric.name), previous=\(previousSum), current=\(currentSum)")
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
                    print("Project: \(project.name), metric: \(metric.name), previous=\(previousSum), current=\(currentSum)")
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
                    print("Project: \(project.name), metric: \(metric.name), previous=\(previousSum), current=\(currentSum)")
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
                    print("Project: \(project.name), metric: \(metric.name), previous=\(previousSum), current=\(currentSum)")
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
    
    func sumMetricValues(metric: Metric) -> String {
        var count = 0
        for submetric in metric.submetrics {
            for value in submetric.values {
                count += value.value
            }
        }
        return count.prettyString()
    }
    
    func sumSubmetricValues(submetric: Submetric) -> String {
        var count = 0
        for value in submetric.values {
            count += value.value
        }
        return count.prettyString()
    }
}

extension Int {
    
    func prettyString() -> String {
        var copy = self
        var i = 0
        var result = ""
        while copy != 0 {
            result = String(copy % 10) + result
            copy /= 10
            i += 1
            if i % 3 == 0 && copy != 0 {
                result = "." + result
            }
        }
        return result
    }
}