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
        addSubview(identifier)
        addSubview(typeName)
        addSubview(difference)
        addSubview(sign)
    }
    
    private func setupConstraints() {
        var cellConstraints = [NSLayoutConstraint]()
        let dictionary = ["identifier" : identifier,
                          "typeName": typeName,
                          "difference": difference,
                          "sign" : sign]
        // CR: [Both | High] Make some reserch in NSLayoutFormatOptions usage or ask me, will make your life more earsier [Atti]
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-[identifier]-10-[typeName]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints.append(NSLayoutConstraint(item: identifier, attribute: .Width, relatedBy: .Equal, toItem: identifier, attribute: .Height, multiplier: 1.0, constant: 0.0))
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[difference]-10-[sign]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=8)-[identifier(25)]-(>=8)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=8)-[typeName(25)]-(>=8)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=8)-[difference(25)]-(>=8)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=8)-[sign(25)]-(>=8)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        addConstraints(cellConstraints)
    }
}