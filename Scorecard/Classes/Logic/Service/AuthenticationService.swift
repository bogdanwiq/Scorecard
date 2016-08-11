//
//  AuthenticationService.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/11/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class AuthenticationService {
    static let sharedInstance = AuthenticationService()
    
    func facebookLogin(completionHandler: (fullName: String, imageURL: String) -> Void) {
        if FBSDKAccessToken.currentAccessToken() != nil {
            let request1 = FBSDKGraphRequest.init(graphPath: "me/picture", parameters: ["type": "large", "redirect": "false"], HTTPMethod: "GET")
            request1.startWithCompletionHandler({ (connection, result, error) in
                if error != nil {
                    print(error.localizedDescription)
                    return
                }
                let imageURL = result.valueForKey("data")!.valueForKey("url")! as! String
                let request2 = FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "name"], HTTPMethod: "GET")
                request2.startWithCompletionHandler({ (connection, result, error) in
                    if error != nil {
                        print(error.localizedDescription)
                        return
                    }
                    let fullName = result.valueForKey("name")! as! String
                    completionHandler(fullName: fullName, imageURL: imageURL)
                })
            })
        }
    }
}