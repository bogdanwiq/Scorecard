//
//  GeneralConstants.swift
//  Scorecard
//
//  Created by Botond Magyarosi on 12/07/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import UIKit

extension UIImage {
    
    private static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

let SharedApplication = UIApplication.sharedApplication()
let NotificationCenter = NSNotificationCenter.defaultCenter()

let screenWidth = UIScreen.mainScreen().applicationFrame.size.width
let screenHeight = UIScreen.mainScreen().applicationFrame.size.height

let kTypeNameSize : CGFloat = 15.0
let kCounterSize : CGFloat = 22.0
let kDifferenceSize : CGFloat = 19.0
let kPercentSize : CGFloat = 18.0
let kLabelWidth : CGFloat = 140.0
let kLabelHeight : CGFloat = 22.0
let kAxisFontSize : CGFloat = 13.0



