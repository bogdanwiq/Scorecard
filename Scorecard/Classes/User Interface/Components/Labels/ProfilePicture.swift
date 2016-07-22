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
        profileImage = image!
        roundImage()
        
        frame = CGRectMake(0, 0, 130, 130)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func roundImage() {
        contentMode = UIViewContentMode.ScaleAspectFill
        layer.borderWidth = 1.0
        layer.masksToBounds = false
        layer.cornerRadius = 130.0 / 2.0
        clipsToBounds = true
    }
}