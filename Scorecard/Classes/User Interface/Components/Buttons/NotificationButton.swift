//
//  NotificationButton.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/18/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class NotificationButton : UIBarButtonItem {
    override init() {
        super.init()
        let profileImage = UIImage(named: "Notification")!
        self.image = profileImage
        self.target = self
        self.action = #selector(slide)
        self.style = .Plain
        
    }
    func slide(){
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}