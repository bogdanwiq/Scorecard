//
//  Project.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/25/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import ObjectMapper

class Project: Mappable {
    
    enum intervalType {
        case d
        case w
    }
    
    var id : Int?
    var name : String?
    var interval : intervalType?
    var metrics : [Metrics]?
    var collaborators : [User]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        interval        <- map["interval"]
        metrics         <- map["metrics"]
        collaborators   <- map["collaborators"]
    }
}