//
//  Metrics.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/25/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import ObjectMapper

class Metric : Mappable {
    
    enum IntervalType {
        case d
        case w
        case m
        case y
        case All
    }
    
    var id : String!
    var name : String!
    var total : Int!
    var value : Int!
    var percentage : Double?
    var interval : IntervalType!
    var submetrics : [Submetric]!
    
    init() {
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id         <- map["id"]
        name       <- map["name"]
        total      <- map["total"]
        value      <- map["growth.value"]
        percentage <- map["growth.percentage"]
        submetrics <- map["submetrics"]
    }
}