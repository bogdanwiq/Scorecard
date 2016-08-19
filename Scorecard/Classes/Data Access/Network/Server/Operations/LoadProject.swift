//
//  LoadMetricsOperation.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/18/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import HLMKit
import ObjectMapper

class LoadProject: BaseServerOperation<[Project]> {
    
    override func errorWithError(error: NSError) -> Error {
        print(error)
        return Error(message: error.localizedDescription, code: .Unknown)
    }
    
    override func serverOperationUrlSuffix() -> String? {
        return "projects"
    }
    
    override func resultForData(data: AnyObject) -> [Project] {
        
        var results: [Project] = []
        
        for entry in data as! [[String : AnyObject]] {
            results.append(Mapper<Project>().map(entry)!)
        }
        
        return results
    }
    
}
