//
//  Stats.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation

class Stats {
    
    var typeName : String
    var counter : Int
    var difference : Int
    var percent : Int
    var img : UIImage
  
    init(typeName: String, counter: Int, difference: Int, percent :Int, sign : EvolutionSign){
        self.typeName = typeName
        self.counter = counter
        self.difference = difference
        self.percent = percent
        self.img = sign.getSign()
    }
       
    func getImage() -> UIImage{
        return img
    }
}