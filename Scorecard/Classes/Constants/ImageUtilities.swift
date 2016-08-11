//
//  ImageConstants.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/10/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation

extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        
        let size = self.size
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        var newSize: CGSize
        
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}