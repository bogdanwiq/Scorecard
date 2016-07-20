//
//  SegmentedControl.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/20/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

extension UISegmentedControl{
    func changeTitleFont(fontName:String?, fontSize:CGFloat?){
        let attributedSegmentFont = NSDictionary(object: UIFont(name: fontName!, size: fontSize!)!, forKey: NSFontAttributeName)
        setTitleTextAttributes(attributedSegmentFont as [NSObject : AnyObject], forState: .Normal)
    }
}

extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(backgroundColor!), forState: .Normal, barMetrics: .Default)
        setBackgroundImage(imageForSelected(), forState: .Selected, barMetrics: .Default)
        setDividerImage(imageWithColor(UIColor.clearColor()), forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)
    }
    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }
    
    private func imageForSelected() -> UIImage {
        let image : UIImage! = UIImage(named: "Selector")
        return image
    }
}
class SegmentedControl : UISegmentedControl {
    
    let timeFrame = ["1d", "1w", "1m","1y", "All"]
    
    init() {
        super.init(frame: CGRectZero)
        self.frame = UIScreen.mainScreen().bounds
        for count in 0..<timeFrame.count {
            self.insertSegmentWithTitle(timeFrame[count], atIndex: count, animated: true)
        }
        self.selectedSegmentIndex = 0
        initUI()
    }
    
    func initUI(){
        
        self.backgroundColor = UIColorFromHex(kSegmentedControlBackgroundColor)
        self.changeTitleFont("Helvetica", fontSize: 14)
        self.tintColor = UIColorFromHex(kTextColor)
        self.removeBorders()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}