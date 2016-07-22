//
//  DataService.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/22/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation

class DataService {
    
    static let sharedInstance = DataService()

    func setupStats() -> [Stats] {
        var stats : [Stats] = [Stats]()
        
        let stat1 = Stats(typeName: "DOWNLOAD", counter: 123131, difference: 2222, percent: 22, sign: "ArrowUp")
        let stat2 = Stats(typeName: "UPDATE", counter: 1231, difference: 22, percent: 10, sign: "ArrowDown")
        let stat3 = Stats(typeName: "USERS", counter: 123131, difference: 2222, percent: 22, sign: "ArrowUp")
        let stat4 = Stats(typeName: "DOWNLOADERS", counter: 1231, difference: 22, percent: 10, sign: "None")
        let stat5 = Stats(typeName: "ITERS", counter: 123131, difference: 2222, percent: 22, sign: "ArrowUp")
        let stat6 = Stats(typeName: "Update", counter: 1231, difference: 22, percent: 10, sign: "ArrowDown")
        let stat7 = Stats(typeName: "DOWNLOADERS", counter: 1231, difference: 22, percent: 10, sign: "None")
        let stat8 = Stats(typeName: "ITERS", counter: 123131, difference: 2222, percent: 22, sign: "ArrowUp")
        let stat9 = Stats(typeName: "Update", counter: 1231, difference: 22, percent: 10, sign: "ArrowDown")
        
        stats.append(stat1)
        stats.append(stat2)
        stats.append(stat3)
        stats.append(stat4)
        stats.append(stat5)
        stats.append(stat6)
        stats.append(stat7)
        stats.append(stat8)
        stats.append(stat9)
        
        return stats
    }
    
    func setProfileSettings(preferenceName: String, state: Bool) {
        NSUserDefaults.standardUserDefaults().setBool(state, forKey: preferenceName)
    }
    
    func getProfileSettings(preferenceName: String) -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(preferenceName)
    }
}