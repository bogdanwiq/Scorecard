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
        slider.addTarget(self, action: #selector(didChangeState(_:)), forControlEvents: .AllTouchEvents)
        contentView.addSubview(slider)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        var constraints = [NSLayoutConstraint]()
        let metrics : [String: CGFloat] = ["padding": 15]
        let views : [String: UIView] = ["preferenceName": preferenceName, "slider": slider]
        
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[preferenceName]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-(padding)-[preferenceName]-(>=10)-[slider]-(padding)-|", options: .AlignAllCenterY, metrics: metrics, views: views)
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    // MARK: - User interactions
    
    func didChangeState(sender: UISwitch) {
        delegate?.preferenceSliderCellDidChangeValue(self, newState: sender.on)
    }
}

protocol PreferenceSliderCellDelegate: class {
    func preferenceSliderCellDidChangeValue(cell: PreferenceSliderCell, newState: Bool)
}