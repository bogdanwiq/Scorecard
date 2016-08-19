//
//  LoadSubmetricsOperation.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 8/18/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import HLMKit
import ObjectMapper

class LoadSubmetricsOperation: BaseServerOperation<Metric> {
    
    var projectId : String!
    var metricId : String!
    var timeFrame : String!
    
    init(projectId : String, metricId: String, timeFrame: String) {
        self.projectId = projectId
        self.metricId = metricId
        self.timeFrame = timeFrame
    }
    
    override func errorWithError(error: NSError) -> Error {
        print(error)
        return Error(message: error.localizedDescription, code: .Unknown)
    }
    
    override func serverOperationUrlSuffix() -> String? {
        let string = "projects/\(projectId)/metrics/\(metricId)/values"
        return string
    }
    
    override func serverOperationParameters() -> [String : AnyObject]? {
        return ["period": timeFrame]
    }
    
    override func resultForData(data: AnyObject) -> Metric {
        return Mapper<Metric>().map(data)!
    }
}