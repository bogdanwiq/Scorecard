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
   
    override init(image: UIImage?){
        super.init(image: image)
        self.profileImage = image!
        self.roundImage()
        
        self.frame = CGRectMake(100,100, 130, 130)
        //self.frame = CGRectMake(100,100,150,150)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func roundImage(){
        self.contentMode = UIViewContentMode.ScaleAspectFill
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 130/2
        self.clipsToBounds = true
    }
}