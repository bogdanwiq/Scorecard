//
//  DataService.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/22/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import ObjectMapper

class DataService {
    
    static let sharedInstance = DataService()

    func setupStats() -> [Stats] {
        
        let path = NSBundle.mainBundle().pathForResource("example", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        let unformattedString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        let jsonDict = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
        let array = jsonDict?.valueForKey("project")! as! NSArray
        var string = "[\n"
        for i in 0..<(array.count - 1) {
            string += "\(array[i]),\n"
        }
        string += "\(array[array.count - 1])\n]"
        let nsstring = NSString(string: string)
        
        let projects: Array<Project>? = Mapper<Project>().mapArray(nsstring)
        
        var stats : [Stats] = []
        
        for project in projects! {
            for metric in project.metrics! {
                let stat = Stats(typeName: metric.name!, counter: countEntries(metric.submetrics!), difference: 0, percent: 0, sign: .None)
                stats.append(stat)
            }
        }
        
        return stats
    }
    
    func getCurrentStat() -> Stats {
        let stat1 = Stats(typeName: "DOWNLOAD", counter: 123131, difference: 2222, percent: 22, sign: .ArrowUp)
        return stat1
    }
    
    func setProfileSettings(preferenceName: String, state: Bool) {
        NSUserDefaults.standardUserDefaults().setBool(state, forKey: preferenceName)
    }
    
    func getProfileSettings(preferenceName: String) -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(preferenceName)
    }
    
    func countEntries(submetrics: [Submetric]) -> Int {
        var counter = 0
        for submetric in submetrics {
            counter += submetric.values!.count
        }
        return counter
    }
}