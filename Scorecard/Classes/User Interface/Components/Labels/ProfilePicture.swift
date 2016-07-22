//
//  ProfilePicture.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation

class ProfilePicture : UIImageView {
    var profileImage : UIImage?
   
    override init(image: UIImage?) {
        super.init(image: image)
        // CR: [Bogdan | Low] Don't need to put self before property set an method call [Atti]
        self.profileImage = image!
        self.roundImage()
        
        self.frame = CGRectMake(0, 0, 130, 130)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func roundImage() {
        self.contentMode = UIViewContentMode.ScaleAspectFill
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 130.0 / 2.0
        self.clipsToBounds = true
    }
}