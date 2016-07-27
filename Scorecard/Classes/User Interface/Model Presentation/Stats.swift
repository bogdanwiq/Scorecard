//
//  Stats.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation

class Stats {
    
    enum signImg: String{
        case ArrowUp
        case ArrowDown
        case None
    }
    
    var typeName : String
    var counter : Int
    var difference : Int
    var percent : Int
    var img : UIImage
    
    // CR: [Someone | High] The percent and sign can be set from counter and difference. Alos use int enum for sign (arrow direction). [Atti]
    init(typeName: String, counter: Int, difference: Int, percent :Int, sign : String){
        self.typeName = typeName
        self.counter = counter
        self.difference = difference
        self.percent = percent
        self.img = Stats.setSign(sign)
    }
    
    private class func setSign(sign: String) -> UIImage{
        var image : UIImage = UIImage()
        switch sign {
        case signImg.ArrowUp.rawValue :
            image = UIImage(named: "ArrowUp")!
        case signImg.ArrowDown.rawValue:
            image = UIImage(named: "ArrowDown")!
        case signImg.None.rawValue:
            image =  UIImage(named: "None")!
        default : break
        }
        return image
    }
    
    func getImage() -> UIImage{
        return img
    }
}