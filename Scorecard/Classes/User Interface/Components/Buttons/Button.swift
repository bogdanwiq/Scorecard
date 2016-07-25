//
//  Button.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/22/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

enum Button {
    case Profile
    case Notification
    case Back
    
    func getButton() -> UIButton{
        let button = UIButton(frame: CGRectMake(0,0,30,30))
        switch self {
        case .Profile:
            button.setImage(UIImage(named: "Profile"), forState: .Normal)
            break
        case .Notification:
            button.setImage(UIImage(named: "Notification"), forState: .Normal)
            break
        case .Back:
            button.setImage(UIImage(named: "Back"), forState: .Normal)
        }
        return button
    }
}