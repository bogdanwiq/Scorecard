//
//  LogoutButton.swift
//  Scorecard
//
//  Created by Mac  on 7/20/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation

class LogoutButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColorFromHex(kLogoutBackgroundColor)
        self.tintColor = UIColor.lightTextColor()
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        self.setTitle("Logout", forState: .Normal)
        self.titleLabel?.textAlignment = .Center
        self.addTarget(self, action: #selector(logout), forControlEvents: .TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func logout() {
        
    }
    
}