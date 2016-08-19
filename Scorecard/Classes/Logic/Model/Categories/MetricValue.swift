//
//  MetricValue.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/25/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import ObjectMapper

class MetricValue: Mappable {
    
    var date: NSDate!
    var value : Int?
    
    init() {
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        var strDate: Double!
        strDate <- map["time"]
        date = NSDate(timeIntervalSince1970: strDate / 1000.0)
        value   <- map["value"]
    }
}