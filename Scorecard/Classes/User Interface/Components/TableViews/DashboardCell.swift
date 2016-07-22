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
    // CR: [Anuone | Medium] Set the type, but not create the object [Atti]
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
        backgroundColor = Color.mainBackground
        // TYPENAME UILABEL SETTINGS
        typeName.textAlignment = NSTextAlignment.Left
        typeName.textColor = Color.textColor
        typeName.font = UIFont(name:"HelveticaNeue", size: kTypeNameSize)
        typeName.translatesAutoresizingMaskIntoConstraints = false
        typeName.frame = CGRectMake(kXpointLeft, kYpointUp, kLabelWidth, kLabelHeight);
        
        // COUNTER UILABEL SETTINGS
        counter.textAlignment = NSTextAlignment.Left
        counter.textColor = Color.textColor
        counter.font = UIFont(name:"HelveticaNeue", size: kCounterSize)
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.frame = CGRectMake(kXpointLeft, kYpointDown, kLabelWidth, kLabelHeight);
        
        // DIFFERENCE UILABEL SETTINGS
        difference.textAlignment = NSTextAlignment.Right
        difference.textColor = Color.textColor
        difference.font = UIFont(name:"HelveticaNeue", size: kDifferenceSize)
        difference.translatesAutoresizingMaskIntoConstraints = false
        difference.frame = CGRectMake(kXpointRight, kYpointUpRight, kLabelWidth-70, kLabelHeight)
        
        // PERCENT UILABEL SETTINGS
        percent.textAlignment = NSTextAlignment.Right
        percent.textColor = Color.textColor
        percent.font = UIFont(name:"HelveticaNeue", size: kPercentSize)
        percent.translatesAutoresizingMaskIntoConstraints = false
        percent.frame = CGRectMake(kXpointRight, kYpointDownRight, kLabelWidth-70,kLabelHeight)
        
        // SIGN UIIMAGE SETTINGS
        sign.frame = CGRectMake(kXsign,kYsign, 30,30)
        
        // ADDSUBVIEW
        addSubview(typeName)
        addSubview(counter)
        addSubview(difference)
        addSubview(percent)
        addSubview(sign)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}