//
//  CustomCell.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class PreferenceSliderCell: UITableViewCell{
    
    let preferenceName = UILabel()
    let slider = UISwitch()
    let service = DataService.sharedInstance
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style	, reuseIdentifier: reuseIdentifier)
        preferenceName.frame = CGRectMake(10.0, 20.0, 100.0, 21.0);
        preferenceName.backgroundColor = Color.mainBackground
        preferenceName.textColor = Color.textColor
        preferenceName.text = "Placeholder"
        preferenceName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(preferenceName)
        slider.frame.origin.x = 263.0
        slider.frame.origin.y = 15.0
        slider.setOn(false, animated: false)
        slider.onTintColor = Color.profileSettings
        slider.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(slider)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didChangeState(sender: UISwitch) {
        service.setProfileSettings(preferenceName.text!, state: sender.on)
    }
    
    func setupConstraints() {
        var preferenceCellConstraints = [NSLayoutConstraint]()
        let dictionary = ["preferenceName": preferenceName, "slider": slider]
        
        preferenceCellConstraints.append(NSLayoutConstraint(item: preferenceName, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        preferenceCellConstraints.append(NSLayoutConstraint(item: slider, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        preferenceCellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[preferenceName]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        preferenceCellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[slider]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        
        addConstraints(preferenceCellConstraints)
    }

}