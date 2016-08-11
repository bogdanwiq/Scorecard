//
//  DateFormatter.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/10/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation

enum DateFormat : String{
    
    case All = "d MMM yyyy HH:mm"
    case Month = "MMM"
    case Year = "yyyy"
    case Hour = "HH"
    case Weekday = "EEE"
    case Day = "d"
}

class DateFormatter : NSDateFormatter {
    
    init(format: DateFormat) {
        super.init()
        dateFormat = format.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}