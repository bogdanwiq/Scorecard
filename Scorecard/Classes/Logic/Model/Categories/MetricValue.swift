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
    var value : Int!
    
    init() {
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        var strDate: String!
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        strDate <- map["date"]
        date = dateFormatter.dateFromString(strDate)
        value   <- map["value"]
    }
}