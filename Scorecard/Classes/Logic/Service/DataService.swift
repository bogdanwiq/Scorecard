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
import Alamofire
import HMKit

enum TimeFilter {
    case OneDay
    case OneWeek
    case OneMonth
    case OneYear
    case All
}

class DataService {
    
    static let sharedInstance = DataService()
    
    func setupStats(timeFrame: String, completionHandler: (metrics: [MetricModel]) -> Void) {
        
        let projectOperations = LoadProject()
        projectOperations.run({ (projectResponse) in
            let metricsOperations = LoadMetricsOperation(id: projectResponse[0].id, timeFrame: timeFrame)
            
            metricsOperations.run({ (metricResponse) in
                completionHandler(metrics: metricResponse)
            }) { (error) in
                print(error)
                completionHandler(metrics: [])
            }
        }) { (error) in
            print(error)
            completionHandler(metrics: [])
        }
    }
    
    func getSubmetric(timeFrame: String, metricId: String, completionHandler: (metric: Metric) -> Void) {
        
        let projectOperations = LoadProject()
        projectOperations.run({ (projectResponse) in
            let submetricsOperations = LoadSubmetricsOperation(projectId: projectResponse[0].id, metricId: metricId, timeFrame: timeFrame)
            
            submetricsOperations.run({ (submetricResponse) in
                completionHandler(metric: submetricResponse)
            }) { (error) in
                print(error)
                completionHandler(metric: Metric())
            }
        }) { (error) in
            print(error)
            completionHandler(metric: Metric())
        }
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
    
    func getSubmetricCount(metric: Metric) -> [Int] {
        
        var sum : [Int] = []
        
        for submetric in metric.submetrics {
            sum.append(submetric.total)
        }
        return sum
    }
    
    func getSubmetricSum(submetric : Submetric) -> String {
        var count = 0
        for values in submetric.values {
            count += (values.value ?? 0)
        }
        return count.prettyString()
    }
    
    func getDiagramFor(submetric: [MetricValue], timeFrame: Int, xAxis: [String]) -> [ChartDataEntry] {
        
        var chartValues : [ChartDataEntry] = []
        var date : String!
        var components : NSDateComponents
        let calendar = NSCalendar.currentCalendar()
        
        for i in 0..<xAxis.count {
            chartValues.append(ChartDataEntry(value: Double(0), xIndex: i))
        }
        
        for metricValue in submetric {
            switch timeFrame {
            case 0:
                components = calendar.components(.Hour, fromDate: metricValue.date)
                date = components.hour.toDate(.Hour)
                break
            case 1:
                components = calendar.components(.Weekday, fromDate: metricValue.date)
                date = components.weekday.toDate(.Weekday)
                break
            case 2:
                components = calendar.components(.Day, fromDate: metricValue.date)
                date = components.day.toDate(.Day)
                break
            case 3:
                components = calendar.components(.Month, fromDate: metricValue.date)
                date = components.month.toDate(.Month)
                break
            case 4:
                components = calendar.components(.Year, fromDate: metricValue.date)
                date = components.year.toDate(.Year)
                break
            default:
                break
            }
            chartValues[xAxis.indexOf(date)!].value += Double(metricValue.value ?? 0)
        }
        return chartValues
    }
    
    func getYearsLimit(metric : Metric) -> [String] {
        
        var years : [String] = []
        let calendar = NSCalendar.currentCalendar()
        
        for submetric in metric.submetrics {
            for subvalues in submetric.values {
                let components = calendar.components(.Year, fromDate: subvalues.date)
                let date = components.year.toDate(.Year)
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
    
    func toDate(format: DateFormat) -> String {
        switch format {
        case .Hour:
            if self < 10 {
                return "0\(self):00"
            } else {
                return "\(self):00"
            }
        case .Day:
            return "\(self)"
        case .Weekday:
            switch self {
            case 1:
                return "SUN"
            case 2:
                return "MON"
            case 3:
                return "TUE"
            case 4:
                return "WED"
            case 5:
                return "THU"
            case 6:
                return "FRI"
            case 7:
                return "SAT"
            default:
                return ""
            }
        case .Month:
            switch self {
            case 1:
                return "JAN"
            case 2:
                return "FEB"
            case 3:
                return "MAR"
            case 4:
                return "APR"
            case 5:
                return "MAY"
            case 6:
                return "JUN"
            case 7:
                return "JUL"
            case 8:
                return "AUG"
            case 9:
                return "SEP"
            case 10:
                return "OCT"
            case 11:
                return "NOV"
            case 12:
                return "DEC"
            default:
                return ""
            }
        case .Year:
            return "\(self)"
        default:
            return ""
        }
    }
}