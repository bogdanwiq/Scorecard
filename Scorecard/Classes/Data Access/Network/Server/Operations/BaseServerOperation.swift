//
//  BaseServerOperation.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/18/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import HLMKit

class BaseServerOperation<T>: ServerOperation<T> {
    
    init() {
        super.init(baseUrl: "http://104.236.121.43:8000/api/")
    }
    
    override func serverOperationHeaders() -> [String : String]? {
        return ["Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJkYTYzZDM3YS00NTFlLTQ3YzAtYWNiZi1lOTcxODIyZTZlZmIiLCJleHAiOjM0OTExMTUxNDQ0Mzd9.ikVlFKvbgkJ3jqOuhDZVBWljcfieg3dIaAwpCtlCpfA"]
    }
}