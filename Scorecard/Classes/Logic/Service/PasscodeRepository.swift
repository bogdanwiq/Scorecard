//
//  PasscodeRepository.swift
//  Scorecard
//
//  Created by Andrei Oltean on 8/5/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import UIKit
import PasscodeLock

class PasscodeRepository: PasscodeRepositoryType {
    
    private let passcodeKey: String
    
    var hasPasscode: Bool {
        if passcode != nil {
            return true
        }
        return false
    }
    var passcode: [String]? {
        return NSUserDefaults.standardUserDefaults().valueForKey(passcodeKey) as? [String] ?? nil
    }
    
    init(passcodeKey: String) {
        self.passcodeKey = passcodeKey
    }
    
    func savePasscode(passcode: [String]) {
        NSUserDefaults.standardUserDefaults().setObject(passcode, forKey: passcodeKey)
    }
    
    func deletePasscode() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(passcodeKey)
    }
}