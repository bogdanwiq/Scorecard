//
//  LoginButtons.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/4/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

enum LoginButton {
    case Google
    case Facebook
    
    func getButton() -> UIButton {
        
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        switch self {
        case .Google:
            button.setTitle("Connect with Google", forState: .Normal)
            button.setTitleColor(Color.mainBackground, forState: .Normal)
            button.backgroundColor = Color.textColor
            button.imageEdgeInsets.right = 50
            button.alpha = 1.0
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
            button.setImage(UIImage(named:"GoogleLogo"), forState: UIControlState.Normal)
            break
        case .Facebook:
            button.setTitle("Login with Facebook", forState: UIControlState.Normal)
            button.setTitleColor(Color.textColor, forState: .Normal)
            button.backgroundColor = Color.facebookBackground
            button.imageEdgeInsets.right = 50
            button.alpha = 1.0
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
            button.setImage(UIImage(named:"FacebookLogo"), forState: UIControlState.Normal)
            break
        }
        return button
    }
}