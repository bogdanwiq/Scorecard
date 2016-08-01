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
    
    var id : String!
    var name : String!
    var values : [MetricValue]!
    
    init() {
        
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id     <- map["id"]
        name   <- map["name"]
        values <- map["values"]
    }
    
}