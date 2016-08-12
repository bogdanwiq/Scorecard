//
//  AlertViewController.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/12/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import UIKit

class AlertViewController : BaseViewController {
    
    override func initUI() {
    view.backgroundColor = Color.alertBackground
    navigationController!.navigationBar.barTintColor = Color.alertBackground
    }
}