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
        
        let path = NSBundle.mainBundle().pathForResource("example", ofType: "json")
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
        switch type {
        case .OneDay :
            
            break
        case .OneWeek:
            
            break
        case .OneMonth:
            
            break
        case .OneYear:
            
            break
        case .All:
            
            break
        }
        return []
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