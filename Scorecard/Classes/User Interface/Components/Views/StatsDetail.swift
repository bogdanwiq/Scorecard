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
    
    var typeName : UILabel!
    var counter : UILabel!
    var difference : UILabel!
    var percent : UILabel!
    var sign : UIImageView!
    var currentStat : Stats!
    let service = DataService.sharedInstance
    
    init(){
        super.init(frame: CGRectZero)
        currentStat = service.getCurrentStat()
        initUI()
        setupInformation()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI(){
        frame = UIScreen.mainScreen().bounds
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
    
    private func setupInformation(){
        typeName.text = currentStat.typeName
        counter.text = String(currentStat.counter)
        if currentStat.getImage() == UIImage(named: "ArrowUp") {
            difference.textColor = Color.statsRise
            difference.text = "+" + String(currentStat.difference)
        }
        else if currentStat.getImage() == UIImage(named: "ArrowDown") {
            difference.textColor = Color.statsFall
            difference.text = "-" + String(currentStat.difference)
        }
        else if currentStat.getImage() == UIImage(named: "None") {
            difference.textColor = Color.statsRise
            difference.text = String(currentStat.difference)
        }
        percent.text = String(currentStat.percent) + "%"
        sign.image = currentStat.getImage()
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
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[counter]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:[percent]-10-[sign]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[typeName]-4-[counter]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[difference]-[percent]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=20)-[sign(30)]-(>=20)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dictionary)
        addConstraints(cellConstraints)
    }
}