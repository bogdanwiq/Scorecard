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
    
    
    
    init(){
        super.init(frame: CGRectZero)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI(){
        frame = UIScreen.mainScreen().bounds
        backgroundColor = Color.mainBackground
        setInformation()
    }
    
    private func setInformation(){
        
    }
}