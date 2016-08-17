//
//  ValueAndPercent.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/16/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import ObjectMapper

class ValueAndPercent: Mappable {
    
    var percent: Double!
    var value : Int!
    
    init() {
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        var s = ""
        s <- map["value"]
        value = Int(s)
        s <- map["percent"]
        percent = Double(s)
    }
}