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
    
    weak var delegate : TimeFrameDelegate?
    
    private var labels = [UILabel]()
    private var items : [String] = ["1d", "1w", "1m", "1y", "All"]{
        didSet{
            setupLabels()
        }
    }
    var selectedIndex : Int = 4 {
        didSet{
            displaySelected()
        }
    }
    
    init() {
        super.init(frame: CGRectZero)
        backgroundColor = Color.timeFrameBackground
        setupLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabels() {
        for index in 0...items.count - 1{
            let uilabel = UILabel(frame: CGRectZero)
            uilabel.text = items[index]
            uilabel.textAlignment = .Center
            uilabel.font = Font.system(.Normal)
            uilabel.textColor = Color.timeFrameSelected
            uilabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(uilabel)
            labels.append(uilabel)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        displaySelected()
        setupConstraints()
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
    
    private func displaySelected() {
        
        let animation: CATransition = CATransition()
        
        animation.duration = 0.3
        animation.type = kCATransitionFade
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        for index in 0..<labels.count {
            labels[index].layer.addAnimation(animation,forKey :"layerFadeOut")
            labels[index].layer.backgroundColor = Color.timeFrameBackground.CGColor
            labels[index].textColor = Color.timeFrameSelected
            labels[index].font = Font.system(.Normal)
        }
        labels[selectedIndex].layer.addAnimation(animation, forKey :"layerFadeIn")
        labels[selectedIndex].layer.backgroundColor = Color.timeFrameSelected.CGColor
        labels[selectedIndex].layer.cornerRadius = frame.height / 2
        labels[selectedIndex].textColor = Color.timeFrameBackground
        labels[selectedIndex].font = Font.systemBold(.Normal)
        delegate?.timeFrameSelectedValue(selectedIndex)
    }
    
    private func setupConstraints() {
        
        var constraints = [NSLayoutConstraint]()
        var views: [String: UIView] = [:]
        var horizontalConstraints = "[l\(labels[0].text!)]"
        
        for label in labels {
            views["l" + label.text!] = label
        }
        
        for i in 1..<labels.count {
            horizontalConstraints += "[l\(labels[i].text!)(==l\(labels[i-1].text!))]"
        }
        
        constraints.append(NSLayoutConstraint(item: labels[0], attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1.0, constant: 0.0))
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|\(horizontalConstraints)|", options: [.AlignAllTop, .AlignAllBottom], metrics: nil, views: views)
        NSLayoutConstraint.activateConstraints(constraints)
    }
}

protocol TimeFrameDelegate: class {
    func timeFrameSelectedValue(selectedIndex: Int)
}