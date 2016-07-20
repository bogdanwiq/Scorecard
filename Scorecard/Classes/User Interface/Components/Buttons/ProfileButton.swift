//
//  ProfileButton.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/18/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class ProfileButton : UIBarButtonItem {
    
    override init() {
        super.init()
        let profileImage = UIImage(named: "Profile")!
        self.image = profileImage
        self.target = self
        self.action = #selector(slide)
        self.style = .Plain
    }
    
    func slide(){
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

