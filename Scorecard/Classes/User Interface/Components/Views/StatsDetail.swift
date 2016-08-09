//
//  StatsDetail.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/21/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class StatsDetail : UIView {
    
    weak var delegate : StatsDetailSetupInformationDelegate?
    
    let service = DataService.sharedInstance
    var typeName : UILabel!
    var counter : UILabel!
    var difference : UILabel!
    var percent : UILabel!
    var sign : UIImageView!
    
    init() {
        super.init(frame: CGRectZero)
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
        typeName.font = UIFont(name:"HelveticaNeue", size: kTypeNameSize)
        typeName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(typeName)
        
        counter = UILabel()
        counter.textAlignment = NSTextAlignment.Left
        counter.textColor = Color.textColor
        counter.font = UIFont(name:"HelveticaNeue", size: kCounterSize)
        counter.translatesAutoresizingMaskIntoConstraints = false
        addSubview(counter)
        
        difference = UILabel()
        difference.textAlignment = NSTextAlignment.Right
        difference.textColor = Color.textColor
        difference.font = UIFont(name:"HelveticaNeue", size: kDifferenceSize)
        difference.translatesAutoresizingMaskIntoConstraints = false
        addSubview(difference)
        
        percent = UILabel()
        percent.textAlignment = NSTextAlignment.Right
        percent.textColor = Color.textColor
        percent.font = UIFont(name:"HelveticaNeue", size: kPercentSize)
        percent.translatesAutoresizingMaskIntoConstraints = false
        addSubview(percent)
        
        sign = UIImageView()
        sign.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sign)
        
        delegate?.setupInformation()
    }
    
    private func setupConstraints() {
        
        var cellConstraints = [NSLayoutConstraint]()
        let dictionary = ["typeName": typeName,
                          "counter" : counter,
                          "difference": difference,
                          "percent": percent,
                          "sign" : sign,
                          ]
        
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[typeName]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[difference]-10-[sign]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[typeName]-4-[counter]-|", options: .AlignAllLeft, metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[difference]-[percent]-|", options: .AlignAllRight, metrics: nil, views: dictionary)
        cellConstraints.append(NSLayoutConstraint(item: sign, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        addConstraints(cellConstraints)
    }
}

protocol StatsDetailSetupInformationDelegate: class {
    func setupInformation()
}