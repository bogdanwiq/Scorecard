//
//  ProfilePicture.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation

// CR: [Someone | Low] This is not a label, move in views group [Atti]
class ProfilePicture : UIImageView {
    var profileImage : UIImage?
   
    override init(image: UIImage?) {
        super.init(image: image)
        profileImage = image!
        frame = CGRectMake(0, 0, 130, 130)
        
        roundImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func roundImage() {
        contentMode = UIViewContentMode.ScaleAspectFill
        layer.borderWidth = 1.0
        layer.masksToBounds = false
        layer.cornerRadius = bounds.size.height / 2.0
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2.0
    }
}