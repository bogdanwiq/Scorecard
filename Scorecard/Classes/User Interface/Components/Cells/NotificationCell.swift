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
        title.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        title.textAlignment = NSTextAlignment.Left
        title.textColor = Color.textColor
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        
        notificationText = UILabel()
        notificationText.lineBreakMode = NSLineBreakMode.ByWordWrapping
        notificationText.numberOfLines = 0
        notificationText.textColor = Color.textColor
        notificationText.textAlignment = NSTextAlignment.Left
        notificationText.font = UIFont(name:"HelveticaNeue", size: 16.0)
        notificationText.translatesAutoresizingMaskIntoConstraints = false
        addSubview(notificationText)
        
        // CR: [Bogdan | Low] Create date formats manager to handle handle dates.[Atti]
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy HH:mm"
        date = dateFormatter.stringFromDate(NSDate())
    }
    
    private func setupConstraints() {
        
        var cellConstraints = [NSLayoutConstraint]()
        let dictionary = ["flag" : flag,
                          "title": title,
                          "notificationText": notificationText]
        
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-[flag(20)]-[title]-|", options: [.AlignAllTop, .AlignAllBottom], metrics: nil, views: dictionary)
        cellConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[title(20)][notificationText]-|", options: [.AlignAllLeft, .AlignAllRight] , metrics: nil, views: dictionary)
        addConstraints(cellConstraints)
    }
}