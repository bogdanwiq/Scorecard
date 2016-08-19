//
//  Project.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/18/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import ObjectMapper

class Project : Mappable {
    
    var id : String!
    var name : String!
    
    init() {
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id         <- map["id"]
        name       <- map["name"]
    }
}