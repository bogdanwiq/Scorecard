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
    
    func getButton() -> UIButton {
        
        let button = UIButton(frame: CGRectMake(0,0,30,30))
        var image : UIImage = UIImage()
        
        switch self {
        case .Profile:
            image = UIImage(named: "Profile")!.resizeImage(CGSize(width: 20, height: 20))
            break
        case .Notification:
            image = UIImage(named: "Notification")!.resizeImage(CGSize(width: 20, height: 20))
            break
        case .Back:
            image = UIImage(named: "Back")!
            break
        }
        button.contentMode = .ScaleAspectFit
        button.setImage(image, forState: .Normal)
        return button
    }
}