//
//  Metrics.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/25/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import ObjectMapper

class Metrics : Mappable {
    
    var id : Int?
    var name : String?
    var values : MetricValue?
    var submetrics : Metrics?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id         <- map["id"]
        name       <- map["name"]
        values     <- map["values"]
        submetrics <- map["submetrics"]
    }
    
}