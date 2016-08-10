//
//  User.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/25/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var id : Int?
    var name : String?
    var image : String?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        name  <- map["name"]
        image <- map["image"]
    }
    
    func getImage() -> UIImage {
        var img : UIImage
        img = UIImage(named: image!)!
        return img
    }
}