//
//  StatsCell.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/25/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class StatsLabelsCell : UITableViewCell {
    
    var identifier : UIImageView!
    var typeName : UILabel!
    
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
        
        // SIGN UIIMAGE SETTINGS
        identifier = UIImageView()
        identifier.translatesAutoresizingMaskIntoConstraints = false
        
        // TYPENAME UILABEL SETTINGS
        typeName = UILabel()
        typeName.textAlignment = NSTextAlignment.Left
        typeName.textColor = Color.textColor
        typeName.font = UIFont(name:"HelveticaNeue", size: kTypeNameSize)
        typeName.translatesAutoresizingMaskIntoConstraints = false
        
        // ADDSUBVIEW
        addSubview(identifier)
        addSubview(typeName)
    }
    
    private func setupConstraints() {
        var cellConstraints = [NSLayoutConstraint]()
        let dictionary = ["identifier" : identifier,
                          "typeName": typeName]
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-[identifier]-10-[typeName]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints.append(NSLayoutConstraint(item: identifier, attribute: .Width, relatedBy: .Equal, toItem: identifier, attribute: .Height, multiplier: 1.0, constant: 0.0))
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=8)-[identifier(25)]-(>=8)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=8)-[typeName(25)]-(>=8)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        addConstraints(cellConstraints)
    }
}