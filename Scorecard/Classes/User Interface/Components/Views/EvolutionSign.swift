//
//  EvolutionSign.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/28/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

enum EvolutionSign {
    case dArrowUp
    case dArrowDown
    case dNone
    case ArrowUp
    case ArrowDown
    case None
    
    func getSign() -> UIImage {
        
        var image : UIImage = UIImage()
        
        switch self {
        case .dArrowUp :
            image = UIImage(named: "dArrowUp")!
            break
        case .dArrowDown :
            image = UIImage(named: "dArrowDown")!
            break
        case .dNone:
            image =  UIImage(named: "dNone")!
            break
        case .ArrowUp :
            image = UIImage(named: "ArrowUp")!
            break
        case .ArrowDown:
            image = UIImage(named: "ArrowDown")!
            break
        case .None:
            image =  UIImage(named: "None")!
            break
        }
        return image
    }
}