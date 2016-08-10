//
//  GeneralConstants.swift
//  Scorecard
//
//  Created by Botond Magyarosi on 12/07/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import UIKit

// CR: [Andrei | High] Move this uiimage extension in separate file. [Atti]
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