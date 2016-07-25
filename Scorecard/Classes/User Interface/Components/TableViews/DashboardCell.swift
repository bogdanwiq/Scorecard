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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI(){
        backgroundColor = Color.mainBackground
        // TYPENAME UILABEL SETTINGS
        typeName = UILabel()
        typeName.textAlignment = NSTextAlignment.Left
        typeName.textColor = Color.textColor
        typeName.font = UIFont(name:"HelveticaNeue", size: kTypeNameSize)
        typeName.translatesAutoresizingMaskIntoConstraints = false
        // COUNTER UILABEL SETTINGS
        counter = UILabel()
        counter.textAlignment = NSTextAlignment.Left
        counter.textColor = Color.textColor
        counter.font = UIFont(name:"HelveticaNeue", size: kCounterSize)
        counter.translatesAutoresizingMaskIntoConstraints = false
        // DIFFERENCE UILABEL SETTINGS
        difference = UILabel()
        difference.textAlignment = NSTextAlignment.Right
        difference.textColor = Color.textColor
        difference.font = UIFont(name:"HelveticaNeue", size: kDifferenceSize)
        difference.translatesAutoresizingMaskIntoConstraints = false
        // PERCENT UILABEL SETTINGS
        percent = UILabel()
        percent.textAlignment = NSTextAlignment.Right
        percent.textColor = Color.textColor
        percent.font = UIFont(name:"HelveticaNeue", size: kPercentSize)
        percent.translatesAutoresizingMaskIntoConstraints = false
        // SIGN UIIMAGE SETTINGS
        sign = UIImageView()
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
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[typeName]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[difference]-[sign]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[counter]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[percent]-[sign]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[typeName(25)]-7-[counter(25)]-15-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[difference]-[percent]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=22)-[sign(30)]-(>=22)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        addConstraints(cellConstraints)
    }
}