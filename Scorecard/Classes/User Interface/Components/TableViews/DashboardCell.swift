//
//  CustomCell.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class DashboardCell: UITableViewCell {
    
    var typeName : UILabel!
    var counter : UILabel!
    var difference : UILabel!
    var percent : UILabel!
    var sign : UIImageView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style	, reuseIdentifier: reuseIdentifier)
        initUI()
        setupConstraints()
    }
    
    private func initUI(){
        backgroundColor = Color.mainBackground
        // TYPENAME UILABEL SETTINGS
        typeName = UILabel()
        typeName.textAlignment = NSTextAlignment.Left
        typeName.textColor = Color.textColor
        typeName.font = UIFont(name:"HelveticaNeue", size: kTypeNameSize)
        typeName.translatesAutoresizingMaskIntoConstraints = false
        typeName.frame = CGRectMake(kXpointLeft, kYpointUp, kLabelWidth, kLabelHeight);
        
        // COUNTER UILABEL SETTINGS
        counter = UILabel()
        counter.textAlignment = NSTextAlignment.Left
        counter.textColor = Color.textColor
        counter.font = UIFont(name:"HelveticaNeue", size: kCounterSize)
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.frame = CGRectMake(kXpointLeft, kYpointDown, kLabelWidth, kLabelHeight);
        
        // DIFFERENCE UILABEL SETTINGS
        difference = UILabel()
        difference.textAlignment = NSTextAlignment.Right
        difference.textColor = Color.textColor
        difference.font = UIFont(name:"HelveticaNeue", size: kDifferenceSize)
        difference.translatesAutoresizingMaskIntoConstraints = false
        difference.frame = CGRectMake(kXpointRight, kYpointUpRight, kLabelWidth-70, kLabelHeight)
        
        // PERCENT UILABEL SETTINGS
        percent = UILabel()
        percent.textAlignment = NSTextAlignment.Right
        percent.textColor = Color.textColor
        percent.font = UIFont(name:"HelveticaNeue", size: kPercentSize)
        percent.translatesAutoresizingMaskIntoConstraints = false
        percent.frame = CGRectMake(kXpointRight, kYpointDownRight, kLabelWidth-70,kLabelHeight)
        
        // SIGN UIIMAGE SETTINGS
        sign = UIImageView()
        sign.frame = CGRectMake(kXsign,kYsign, 30,30)
        
        typeName.translatesAutoresizingMaskIntoConstraints = false
        counter.translatesAutoresizingMaskIntoConstraints = false
        difference.translatesAutoresizingMaskIntoConstraints = false
        percent.translatesAutoresizingMaskIntoConstraints = false
        sign.translatesAutoresizingMaskIntoConstraints = false
        
        // ADDSUBVIEW
        addSubview(typeName)
        addSubview(counter)
        addSubview(difference)
        addSubview(percent)
        addSubview(sign)
    }
    
    private func setupConstraints() {
        var cellConstraints = [NSLayoutConstraint]()
        let dictionary = ["typeName": typeName,
                          "counter" : counter,
                          "difference": difference,
                          "percent": percent,
                          "sign" : sign]
  
        
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-[typeName]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[difference]-[sign]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-[counter]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[percent]-[sign]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[typeName]-[counter]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[difference]-[percent]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[sign]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        
        addConstraints(cellConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}