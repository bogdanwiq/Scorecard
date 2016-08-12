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
        
        delegate?.setupInformation()
    }
    
    private func setupConstraints() {
        
        var cellConstraints = [NSLayoutConstraint]()
        let metrics : [String: CGFloat] = ["padding": 20, "inner":10]
        let views : [String: UIView] = ["typeName": typeName,
                                        "counter" : counter,
                                        "difference": difference,
                                        "percent": percent,
                                        "sign" : sign]
        
        let aspectRatio: CGFloat = 30.0 / 18.0
        cellConstraints.append(NSLayoutConstraint(item: sign, attribute: .Height, relatedBy: .Equal, toItem: sign, attribute: .Width, multiplier: aspectRatio, constant: 0.0))
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-(padding)-[typeName]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[difference]-(inner)-[sign(13)]-(padding)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[typeName]-4-[counter]-|", options: .AlignAllLeft, metrics: nil, views: views)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[difference]-[percent]-|", options: .AlignAllRight, metrics: nil, views: views)
        cellConstraints.append(NSLayoutConstraint(item: sign, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        NSLayoutConstraint.activateConstraints(cellConstraints)
    }
}

protocol StatsDetailSetupInformationDelegate: class {
    func setupInformation()
}