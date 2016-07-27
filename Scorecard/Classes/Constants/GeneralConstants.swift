//
//  GeneralConstants.swift
//  Scorecard
//
//  Created by Botond Magyarosi on 12/07/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import UIKit

let SharedApplication = UIApplication.sharedApplication()
let NotificationCenter = NSNotificationCenter.defaultCenter()

extension UIColor {
    
    convenience init(hexNumber: UInt32) {
        let colorComponents = UIColor.ColorHex(hexNumber)
        self.init(red: colorComponents.0, green: colorComponents.1, blue: colorComponents.2, alpha: colorComponents.3)
    }
    
    private static func ColorHex(hex: UInt32, alpha: Double = 1.0) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        let red   = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue  = CGFloat((hex & 0xFF))/256.0
        return (red, green, blue, CGFloat(alpha))
    }
}

struct Color {
    
    static let mainBackground             = Color.blackPearl
    static let navigationBackground       = Color.blackPearl
    static let chartTextColor             = Color.blackPearl
    static let timeFrameBackground        = Color.blueOxford
    static let textColor                  = Color.white
    static let navigationTitle            = Color.white
    static let chartBackground            = Color.white
    static let logoutButtonBackground     = Color.redOrange
    static let profileSettings            = Color.blueDodger
    static let statsFall                  = Color.orangeBright
    static let statsRise                  = Color.lima
    static let timeFrameSelected          = Color.casper
    static let downloadsDataSetBackground = Color.blueHavelock
    static let usersDataSetBackground     = Color.lima
    static let updatesDataSetBackground   = Color.lemonRipe
    
    private static let blackPearl   = UIColor(hexNumber: 0x031322)
    private static let blueOxford   = UIColor(hexNumber: 0x344454)
    private static let white        = UIColor(hexNumber: 0xFFFFFF)
    private static let redOrange    = UIColor(hexNumber: 0xFF3939)
    private static let blueDodger   = UIColor(hexNumber: 0x3783FF)
    private static let orangeBright = UIColor(hexNumber: 0xFF6647)
    private static let lima         = UIColor(hexNumber: 0x7FD121)
    private static let casper       = UIColor(hexNumber: 0xB6CBD9)
    private static let lemonRipe    = UIColor(hexNumber: 0xF7E51E)
    private static let blueHavelock = UIColor(hexNumber: 0x4A90E0)
}

let screenWidth = UIScreen.mainScreen().applicationFrame.size.width
// TABLECELL SIZE
let kTypeNameSize : CGFloat = 15.0
let kCounterSize : CGFloat = 22.0
let kDifferenceSize : CGFloat = 19.0
let kPercentSize : CGFloat = 18.0
let kLabelWidth : CGFloat = 140.0
let kLabelHeight : CGFloat = 22.0




