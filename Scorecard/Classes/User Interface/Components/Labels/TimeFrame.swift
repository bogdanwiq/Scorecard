//
//  TimeFrame.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/21/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class TimeFrame : UIControl {
    
    private var labels = [UILabel]()
    private var items : [String] = ["1d", "1w", "1m", "1y", "All"]{
        didSet{
            setupLabels()
        }
    }
    var subView : UIView = UIView()
    var selectedIndex : Int = 4{
        didSet{
            displaySelected()
        }
    }
    init(){
        super.init(frame: CGRectZero)
        self.frame = UIScreen.mainScreen().bounds
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        self.backgroundColor = UIColorFromHex(kSegmentedControlBackgroundColor)
        setupLabels()
    }
    private func setupLabels(){
        
        for index in 0...items.count - 1{
            let uilabel = UILabel(frame: CGRectZero)
            uilabel.text = items[index]
            uilabel.textAlignment = .Center
            uilabel.font = UIFont.systemFontOfSize(16.0)
            uilabel.textColor = UIColorFromHex(kTimeFrameSelected)
            self.addSubview(uilabel)
            labels.append(uilabel)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        var selectFrame = self.bounds
        let newWidth = CGRectGetWidth(selectFrame) / CGFloat(items.count)
        selectFrame.size.width = newWidth
        subView.frame = selectFrame
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        for index in 0...labels.count - 1 {
            let label = labels[index]
            let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRectMake(xPosition, 0, labelWidth, labelHeight)
        }
        displaySelected()
    }
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        var calculatedIndex : Int?
        for(index,item) in labels.enumerate(){
            if item.frame.contains(location){
                calculatedIndex = index
            }
        }
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActionsForControlEvents(.ValueChanged)
        }
        return false
    }
    func displaySelected(){
        // Animation //
        let animation: CATransition = CATransition()
        animation.duration = 0.3
        animation.type = kCATransitionFade
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        for index in 0..<labels.count {
            labels[index].layer.addAnimation(animation,forKey :"layerFadeOut")
            labels[index].layer.backgroundColor = UIColorFromHex(kSegmentedControlBackgroundColor).CGColor
            labels[index].textColor = UIColorFromHex(kTimeFrameSelected)
            labels[index].font = UIFont.systemFontOfSize(16.0)
        }
        labels[selectedIndex].layer.addAnimation(animation, forKey :"layerFadeIn")
        labels[selectedIndex].layer.backgroundColor = UIColorFromHex(kTimeFrameSelected).CGColor
        labels[selectedIndex].layer.cornerRadius = frame.height / 2
        labels[selectedIndex].textColor = UIColorFromHex(kSegmentedControlBackgroundColor)
        labels[selectedIndex].font = UIFont.boldSystemFontOfSize(17.0)
        
        
    }
}