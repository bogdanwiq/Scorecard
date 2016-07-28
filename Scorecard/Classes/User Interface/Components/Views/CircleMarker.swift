//
//  CircleMarker.swift
//  Scorecard
//
//  Created by Halcyon Mobile on 7/26/16.
//  Copyright © 2016 Halcyon Mobile. All rights reserved.
//

import Foundation
import Charts;

class CircleMarker: ChartMarker {
    
    var color: UIColor?
    var minimumSize = CGSize()
    private var _size: CGSize = CGSize()
    
    init(color: UIColor) {
        super.init()
        self.color = color
    }
    
    override var size: CGSize {
        return _size
    }
    
    override func draw(context context: CGContext, point: CGPoint) {
        
        let offset = self.offsetForDrawingAtPos(point)
        var rect = CGRect(origin: CGPoint(x: point.x + offset.x, y: point.y + offset.y), size: _size)
        
        rect.origin.x -= _size.width / 2.0
        rect.origin.y -= _size.height
        CGContextSaveGState(context)
        CGContextSetFillColorWithColor(context, color?.CGColor)
        CGContextBeginPath(context)
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextSetFillColorWithColor(context, color!.CGColor)
        CGContextSetLineWidth(context, 3.0)
        CGContextFillEllipseInRect (context, rect)
        CGContextStrokeEllipseInRect(context, rect)
        CGContextFillPath(context)
        UIGraphicsPushContext(context)
        UIGraphicsPopContext()
        CGContextRestoreGState(context)
    }
    
    override func refreshContent(entry entry: ChartDataEntry, highlight: ChartHighlight) {
        _size.width = max(minimumSize.width, _size.width)
        _size.height = max(minimumSize.height, _size.height)
    }
}