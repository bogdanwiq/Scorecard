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
    
    var date: String?
    var value : Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        date              <- map["date"]
        value            <- map["value"]
    }
}