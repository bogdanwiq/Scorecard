//
//  Metrics.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/25/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import ObjectMapper

class MetricModel : Mappable {
    
    var id : String!
    var name : String!
    var total : Int!
    var timeframe : ValueAndPercent!
    
    init() {
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id         <- map["id"]
        name       <- map["name"]
        total      <- map["total"]
        timeframe  <- map["growth"]
    }
}