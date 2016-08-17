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
    var changeNet : Int!
    var changePercent : Double!
    var interval : IntervalType!
    var submetrics : [Submetric]!
    
    init() {
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id         <- map["metrics.id"]
        name       <- map["metrics.name"]
        var s = ""
        s <- map["metrics.changeNet"]
        changeNet = Int(s)
        s <- map["metrics.changePercent"]
        changePercent = Double(s)
        var strInterval: String!
        strInterval <- map["metrics.interval"]
        switch strInterval {
        case "1d":
            interval = IntervalType.d
            break
        case "1w":
            interval = IntervalType.w
            break
        case "1m":
            interval = IntervalType.m
            break
        case "1y":
            interval = IntervalType.y
            break
        case "All":
            interval = IntervalType.All
            break
        default:
            break
        }
        submetrics <- map["metrics.submetrics"]
    }
}