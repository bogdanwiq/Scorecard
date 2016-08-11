//
//  FontConstants.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/10/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation

func helveticaNeueFont(fontSize: CGFloat) -> UIFont {
    return UIFont(name: "HelveticaNeue", size: fontSize)!
}

enum FontSize: CGFloat {
    case TypeName = 15.0
    case Counter = 22.0
    case Difference = 19.0
    case Percent = 18.0
    case Normal = 16.0
    case Axis = 13.0
    case Metric = 17.0
}

struct Font {
    
    private static let kHelveticaNeue = "HelveticaNeue"
    private static let kHelveticaNeueBold = "HelveticaNeue-Bold"
    
    static func helveticaNeue(size: FontSize) -> UIFont {
        return UIFont(name: kHelveticaNeue, size: size.rawValue)!
    }
    
    static func system(size: FontSize) -> UIFont {
        return UIFont.systemFontOfSize(size.rawValue)
    }
    
    static func systemBold(size: FontSize) -> UIFont {
        return UIFont.boldSystemFontOfSize(size.rawValue)
    }
    
    static func helveticaNeueBold(size: FontSize) -> UIFont {
        return UIFont(name: kHelveticaNeueBold, size: size.rawValue)!
    }
}