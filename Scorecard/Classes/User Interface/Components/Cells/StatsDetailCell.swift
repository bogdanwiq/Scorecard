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
    
    private func initUI(){
        backgroundColor = Color.mainBackground
        
        identifier = UIImageView()
        identifier.contentMode = .ScaleAspectFit
        identifier.translatesAutoresizingMaskIntoConstraints = false
        addSubview(identifier)
        
        typeName = UILabel()
        typeName.textAlignment = NSTextAlignment.Left
        typeName.textColor = Color.textColor
        typeName.font = UIFont(name:"HelveticaNeue", size: kTypeNameSize)
        typeName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(typeName)
        
        difference = UILabel()
        difference.textColor = Color.textColor
        difference.font = UIFont(name:"HelveticaNeue", size: kDifferenceSize)
        difference.translatesAutoresizingMaskIntoConstraints = false
        addSubview(difference)
        
        sign = UIImageView()
        sign.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sign)
    }
    
    private func setupConstraints() {
        
        var cellConstraints = [NSLayoutConstraint]()
        let dictionary = ["identifier" : identifier,
                          "typeName": typeName,
                          "difference": difference,
                          "sign": sign]
        
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-[identifier]-5-[typeName]-(>=10)-[difference]-[sign]-|", options: .AlignAllCenterY, metrics: nil, views: dictionary)
        addConstraints(cellConstraints)
    }
}