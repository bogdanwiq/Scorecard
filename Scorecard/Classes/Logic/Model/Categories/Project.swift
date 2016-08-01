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
    
    var id : String!
    var name : String!
    var interval : intervalType!
    var metrics : [Metric]!
  //  var collaborators : [User]?
    
    init() {
        
    }
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        var strInterval: String!
        strInterval <- map["interval"]
        switch strInterval {
        case "d":
            interval = intervalType.d
            break
        case "w":
            interval = intervalType.w
            break
        default:
            break
        }
        metrics     <- map["metrics"]
    //    collaborators   <- map["collaborators"]
    }
}