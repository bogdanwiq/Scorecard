//
//  CustomCell.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class PreferenceSliderCell: UITableViewCell {
    
    weak var delegate: PreferenceSliderCellDelegate?
    
    let preferenceName = UILabel()
    let slider = UISwitch()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style	, reuseIdentifier: reuseIdentifier)
        
        preferenceName.backgroundColor = Color.mainBackground
        preferenceName.textColor = Color.textColor
        preferenceName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(preferenceName)
        
        slider.setOn(false, animated: false)
        slider.onTintColor = Color.profileSettings
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(didChangeState(_:)), forControlEvents: .ValueChanged)
        contentView.addSubview(slider)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        var constraints = [NSLayoutConstraint]()
        let dictionary = ["preferenceName": preferenceName, "slider": slider]
        
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[preferenceName]-|", options: .AlignAllCenterY, metrics: nil, views: dictionary)
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[preferenceName]-(>=10)-[slider]-20-|", options: .AlignAllCenterY, metrics: nil, views: dictionary)
        addConstraints(constraints)
    }
    
    // MARK: - User interactions
    
    func didChangeState(sender: UISwitch) {
        delegate?.preferenceSliderCellDidChangeValue(self, newState: sender.on)
    }
}

protocol PreferenceSliderCellDelegate: class {
    func preferenceSliderCellDidChangeValue(cell: PreferenceSliderCell, newState: Bool)
}