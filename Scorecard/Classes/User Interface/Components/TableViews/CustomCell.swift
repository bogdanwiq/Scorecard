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
//    let counter = UILabel()
//    let difference = UILabel()
//    let percent = UILabel()
    //var sign = UIImage()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style	, reuseIdentifier: reuseIdentifier)
        
        self.typeName.frame = CGRectMake(0, 0, 100, 40);
        self.typeName.backgroundColor = UIColor.brownColor()
        self.typeName.text = "bla bla bla bla bla"
        self.addSubview(self.typeName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //typeName.translatesAutoresizingMaskIntoConstraints = false
//        counter.translatesAutoresizingMaskIntoConstraints = false
//        difference.translatesAutoresizingMaskIntoConstraints = false
//        percent.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(typeName)
//        contentView.addSubview(counter)
//        contentView.addSubview(difference)
//        contentView.addSubview(percent)
        
//        let viewsDict = [
//            "typeName" : typeName,
//            "counter" : counter,
//            "difference" : difference,
//            "percent" : percent,
//            ]
//        
//        
//        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[difference]-|", options: [], metrics: nil, views: viewsDict))
//        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[typeName]-[message]-|", options: [], metrics: nil, views: viewsDict))
//        
//        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[message]-[difference]-|", options: [], metrics: nil, views: viewsDict))
    }
}