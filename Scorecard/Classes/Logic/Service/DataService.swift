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
    
    func setupStats() -> [MetricModel] {
        let path = NSBundle.mainBundle().pathForResource("metrics", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let string = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        let metrics = Mapper<MetricModel>().mapArray(clipJSON(string))
        
        return metrics!
    }
    
    func getSubmetric(metricId : String, timeFrame : Int) -> Metric {
        let path = NSBundle.mainBundle().pathForResource("submetrics", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let string = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        let metric = Mapper<Metric>().map(string)
        
        return metric!
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
    
    func getSubmetricSum(submetric : Submetric) -> String {
        var count = 0
        for values in submetric.values {
            count += values.value
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
            chartValues[xAxis.indexOf(date)!].value += Double(metricValue.value)
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