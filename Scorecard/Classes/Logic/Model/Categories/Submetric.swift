//
//  Submetric.swift
//  Scorecard
//
//  Created by Mac  on 7/29/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import ObjectMapper

class Submetric : Mappable {
    
    var total : Int!
    var name : String!
    var values : [MetricValue]!
    
    init() {
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        total     <- map["total"]
        name   <- map["name"]
        values <- map["values"]
    }
}