//
//  NotificationCell.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/5/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class NotificationCell : UITableViewCell {
    
    var flag : UIImageView!
    var title : UILabel!
    var notificationText : UILabel!
    var date : String!
    
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
        
        flag = UIImageView()
        flag.image = UIImage(named: "Flag")
        flag.contentMode = .ScaleAspectFit
        flag.translatesAutoresizingMaskIntoConstraints = false
        addSubview(flag)
        
        title = UILabel()
        title.text = "Congratulations"
        title.font = Font.helveticaNeueBold(.Normal)
        title.textAlignment = NSTextAlignment.Left
        title.textColor = Color.textColor
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        
        notificationText = UILabel()
        notificationText.lineBreakMode = NSLineBreakMode.ByWordWrapping
        notificationText.numberOfLines = 0
        notificationText.textColor = Color.textColor
        notificationText.textAlignment = NSTextAlignment.Left
        notificationText.font = Font.helveticaNeue(.Normal)
        notificationText.translatesAutoresizingMaskIntoConstraints = false
        addSubview(notificationText)
        
        let dateFormatter = DateFormatter(format: .All)
        date = dateFormatter.stringFromDate(NSDate())
    }
    
    private func setupConstraints() {
        
        var cellConstraints = [NSLayoutConstraint]()
        let metrics : [String: CGFloat] = ["size": 20]
        let views : [String: UIView] = ["flag" : flag,
                                        "title": title,
                                        "notificationText": notificationText]
    
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-[flag(size)]-[title]-|", options: [.AlignAllTop, .AlignAllBottom], metrics: metrics, views: views)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[title(size)][notificationText]-|", options: [.AlignAllLeft, .AlignAllRight] , metrics: metrics, views: views)
        NSLayoutConstraint.activateConstraints(cellConstraints)
    }
}