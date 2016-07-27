//
//  StatsCell.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/25/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class StatsCell : UITableViewCell {
    
    var difference : UILabel!
    var sign : UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style	, reuseIdentifier: reuseIdentifier)
        initUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI(){
        backgroundColor = Color.mainBackground
        
        // DIFFERENCE UILABEL SETTINGS
        difference = UILabel()
        difference.textAlignment = NSTextAlignment.Right
        difference.textColor = Color.textColor
        difference.font = UIFont(name:"HelveticaNeue", size: kDifferenceSize)
        difference.translatesAutoresizingMaskIntoConstraints = false
        
        // SIGN UIIMAGE SETTINGS
        sign = UIImageView()
        sign.translatesAutoresizingMaskIntoConstraints = false
        
        // ADDSUBVIEW
        addSubview(difference)
        addSubview(sign)
    }
    
    private func setupConstraints() {
        var cellConstraints = [NSLayoutConstraint]()
        let dictionary = ["difference": difference,
                          "sign" : sign]
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[difference]-10-[sign]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=8)-[difference(25)]-(>=8)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=8)-[sign(25)]-(>=8)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        addConstraints(cellConstraints)
    }
}