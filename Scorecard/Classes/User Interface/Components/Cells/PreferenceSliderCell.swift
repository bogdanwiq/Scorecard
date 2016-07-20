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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style	, reuseIdentifier: reuseIdentifier)
        
        self.preferenceName.frame = CGRectMake(10.0, 20.0, 100.0, 21.0);
        self.preferenceName.backgroundColor = UIColorFromHex(kBackgroundColor)
        self.preferenceName.textColor = UIColor.whiteColor()
        self.preferenceName.text = "Placeholder"
        self.contentView.addSubview(self.preferenceName)
        
        self.slider.frame.origin.x = 263.0
        self.slider.frame.origin.y = 15.0
        self.slider.setOn(false, animated: false)
        self.slider.onTintColor = UIColorFromHex(kSettingOnColor)
        self.contentView.addSubview(self.slider)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}