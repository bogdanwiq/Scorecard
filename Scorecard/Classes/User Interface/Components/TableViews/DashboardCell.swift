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
    
    private func initUI() {
        backgroundColor = Color.mainBackground
        
        typeName = UILabel()
        typeName.textAlignment = NSTextAlignment.Left
        typeName.textColor = Color.textColor
        typeName.font = Font.helveticaNeue(.TypeName)
        typeName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(typeName)
        
        counter = UILabel()
        counter.textAlignment = NSTextAlignment.Left
        counter.textColor = Color.textColor
        counter.font = Font.helveticaNeue(.Counter)
        counter.translatesAutoresizingMaskIntoConstraints = false
        addSubview(counter)
        
        difference = UILabel()
        difference.textAlignment = NSTextAlignment.Right
        difference.textColor = Color.textColor
        difference.font = Font.helveticaNeue(.Difference)
        difference.translatesAutoresizingMaskIntoConstraints = false
        addSubview(difference)
        
        percent = UILabel()
        percent.textAlignment = NSTextAlignment.Right
        percent.textColor = Color.textColor
        percent.font = Font.helveticaNeue(.Percent)
        percent.translatesAutoresizingMaskIntoConstraints = false
        addSubview(percent)
        
        sign = UIImageView()
        sign.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sign)
    }
    
    private func setupConstraints() {
        
        var cellConstraints = [NSLayoutConstraint]()
        let metrics : [String: CGFloat] = ["padding": 10]
        let views : [String: UIView] = ["typeName": typeName,
                                        "counter" : counter,
                                        "difference": difference,
                                        "percent": percent,
                                        "sign" : sign]
        
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-[typeName]-(>=padding)-[difference]-[sign]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-[counter]-(>=padding)-[percent]-[sign]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(padding)-[typeName]-(>=2)-[counter]-(padding)-|", options: .AlignAllLeft, metrics: metrics, views: views)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[difference]-(>=padding)-[percent]-|", options: .AlignAllRight, metrics: metrics, views: views)
        cellConstraints.append(NSLayoutConstraint(item: sign, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        NSLayoutConstraint.activateConstraints(cellConstraints)
    }
}