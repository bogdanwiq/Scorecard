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
    let service = DataService()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style	, reuseIdentifier: reuseIdentifier)
        
        preferenceName.frame = CGRectMake(10.0, 20.0, 100.0, 21.0);
        preferenceName.backgroundColor = Color.mainBackground
        preferenceName.textColor = Color.textColor
        preferenceName.text = "Placeholder"
        contentView.addSubview(preferenceName)
        
        slider.frame.origin.x = 263.0
        slider.frame.origin.y = 15.0
        slider.setOn(false, animated: false)
        slider.onTintColor = Color.profileSettings
        contentView.addSubview(slider)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didChangeState(sender: UISwitch) {
        service.setProfileSettings(preferenceName.text!, state: sender.on)
    }

}