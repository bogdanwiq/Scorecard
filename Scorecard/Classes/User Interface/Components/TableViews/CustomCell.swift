//
//  CustomCell.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/19/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell{
    
    let typeName = UILabel()
    let counter = UILabel()
    let difference = UILabel()
    let percent = UILabel()
    var sign = UIImageView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style	, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    private func initUI(){
        self.backgroundColor = UIColorFromHex(kBackgroundColor)
        // TYPENAME UILABEL SETTINGS
        self.typeName.textAlignment = NSTextAlignment.Left
        self.typeName.textColor = UIColorFromHex(kTextColor)
        self.typeName.font = UIFont(name:"HelveticaNeue", size: kTypeNameSize)
        self.typeName.translatesAutoresizingMaskIntoConstraints = false
        self.typeName.frame = CGRectMake(kXpointLeft, kYpointUp, kLabelWidth, kLabelHeight);
        
        // COUNTER UILABEL SETTINGS
        self.counter.textAlignment = NSTextAlignment.Left
        self.counter.textColor = UIColorFromHex(kTextColor)
        self.counter.font = UIFont(name:"HelveticaNeue", size: kCounterSize)
        self.counter.translatesAutoresizingMaskIntoConstraints = false
        self.counter.frame = CGRectMake(kXpointLeft, kYpointDown, kLabelWidth, kLabelHeight);
        
        // DIFFERENCE UILABEL SETTINGS
        self.difference.textAlignment = NSTextAlignment.Right
        self.difference.textColor = UIColorFromHex(kTextColor)
        self.difference.font = UIFont(name:"HelveticaNeue", size: kDifferenceSize)
        self.difference.translatesAutoresizingMaskIntoConstraints = false
        self.difference.frame = CGRectMake(kXpointRight, kYpointUpRight, kLabelWidth-70, kLabelHeight)
        
        // PERCENT UILABEL SETTINGS
        self.percent.textAlignment = NSTextAlignment.Right
        self.percent.textColor = UIColorFromHex(kTextColor)
        self.percent.font = UIFont(name:"HelveticaNeue", size: kPercentSize)
        self.percent.translatesAutoresizingMaskIntoConstraints = false
        self.percent.frame = CGRectMake(kXpointRight, kYpointDownRight, kLabelWidth-70,kLabelHeight)
        
        // SIGN UIIMAGE SETTINGS
        self.sign.frame = CGRectMake(kXsign,kYsign, 30,30)
        
        // ADDSUBVIEW
        self.addSubview(self.typeName)
        self.addSubview(self.counter)
        self.addSubview(self.difference)
        self.addSubview(self.percent)
        self.addSubview(self.sign)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}