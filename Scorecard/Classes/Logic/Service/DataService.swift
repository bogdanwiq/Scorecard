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
}