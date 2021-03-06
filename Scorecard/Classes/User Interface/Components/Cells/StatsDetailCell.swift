//
//  StatsDetailCell.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/27/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class StatsDetailCell : UITableViewCell {
    
    var identifier : UIImageView!
    var typeName : UILabel!
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
    
    private func initUI() {
        backgroundColor = Color.mainBackground
        
        identifier = UIImageView()
        identifier.contentMode = .ScaleAspectFit
        identifier.translatesAutoresizingMaskIntoConstraints = false
        addSubview(identifier)
        
        typeName = UILabel()
        typeName.textAlignment = NSTextAlignment.Left
        typeName.textColor = Color.textColor
        typeName.font = Font.helveticaNeue(.TypeName)
        typeName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(typeName)
        
        difference = UILabel()
        difference.textColor = Color.textColor
        difference.font = Font.helveticaNeue(.Difference)
        difference.translatesAutoresizingMaskIntoConstraints = false
        addSubview(difference)
        
        sign = UIImageView()
        sign.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sign)
    }
    
    private func setupConstraints() {
        
        var cellConstraints = [NSLayoutConstraint]()
        let views : [String: UIView] = ["identifier" : identifier,
                                       "typeName": typeName,
                                       "difference": difference,
                                       "sign": sign]
        
        let aspectRatio: CGFloat = 13.0 / 10.0
        cellConstraints.append(NSLayoutConstraint(item: identifier, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        cellConstraints.append(NSLayoutConstraint(item: sign, attribute: .Height, relatedBy: .Equal, toItem: sign, attribute: .Width, multiplier: aspectRatio, constant: 0.0))
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-[identifier]-5-[typeName]-(>=10)-[difference]-[sign(10)]-|", options: .AlignAllCenterY, metrics: nil, views: views)
        NSLayoutConstraint.activateConstraints(cellConstraints)
    }
}