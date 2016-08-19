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

class LoadMetricsOperation: BaseServerOperation<[MetricModel]> {
    
    var id : String!
    var timeFrame : String!
    
    init(id : String, timeFrame: String) {
        self.id = id
        self.timeFrame = timeFrame
    }
    
    override func errorWithError(error: NSError) -> Error {
        print(error)
        return Error(message: error.localizedDescription, code: .Unknown)
    }
    
    override func serverOperationUrlSuffix() -> String? {
        let string = "projects/\(id)/metrics/summary"
        return string
    }
    
    override func serverOperationParameters() -> [String : AnyObject]? {
        return ["period": timeFrame]
    }
    
    override func resultForData(data: AnyObject) -> [MetricModel] {
        
        var results: [MetricModel] = []
        
        for entry in data as! [[String : AnyObject]] {
            results.append(Mapper<MetricModel>().map(entry)!)
        }
        
        return results
    }
}
