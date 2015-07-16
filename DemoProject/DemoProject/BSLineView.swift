//
//  BSLineView.swift
//
//
//
//
//

import UIKit
import QuartzCore

    let defaultColor : UIColor = UIColor.blackColor()
    let defaultBackgroundColor : UIColor = UIColor.clearColor()
    let defaultWidth : CGFloat = 10.0

    let minDistance : CGFloat = 5.0
    let minDistanceSquared : CGFloat = 25.0

    var currentPoint: CGPoint = CGPoint()
    var previousPoint : CGPoint = CGPoint()
    var previousPreviousPoint : CGPoint = CGPoint()



class BSLineView: UIView {
    
    var path : CGMutablePathRef
    var lineColor : UIColor
    var lineWidth : CGFloat
    var empty : Bool

    
    func getMidPoint(p1 : CGPoint, p2 : CGPoint) -> CGPoint {
        return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
    }
    
    required init(coder aDecoder: NSCoder) {
        self.path = CGPathCreateMutable()
        self.lineWidth = defaultWidth
        self.lineColor = defaultColor
        self.empty = true
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        
        self.path = CGPathCreateMutable()
        self.lineWidth = defaultWidth
        self.lineColor = defaultColor
        self.empty = true
        super.init(frame: frame)
        self.backgroundColor = defaultBackgroundColor

    }
    
    override func drawRect(rect: CGRect) {
        self.backgroundColor?.set()
        UIRectFill(rect)
        
        let context : CGContextRef = UIGraphicsGetCurrentContext()
        CGContextAddPath(context, self.path)
        CGContextSetLineCap(context, kCGLineCapRound)
        CGContextSetLineWidth(context, self.lineWidth)
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor)
        CGContextSetAlpha(context, 0.7)
        CGContextStrokePath(context)
        
        self.empty = false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            previousPoint = touch.previousLocationInView(self)
            previousPreviousPoint = touch.previousLocationInView(self)
            currentPoint = touch.locationInView(self)
        }
        self.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
         if let touch = touches.first as UITouch! {
            let point : CGPoint = touch.locationInView(self)
            
            let dx : CGFloat = point.x - currentPoint.x
            let dy : CGFloat = point.y - currentPoint.y
            
            
            if ((dx * dx + dy * dy) < minDistanceSquared) {
                return
            }
            
            previousPreviousPoint = previousPoint
            previousPoint = touch.previousLocationInView(self)
            currentPoint = touch.locationInView(self)
            
            let mid1 : CGPoint = getMidPoint(previousPoint, p2: previousPreviousPoint)
            let mid2 : CGPoint = getMidPoint(currentPoint, p2: previousPoint)
            
            let subpath : CGMutablePathRef = CGPathCreateMutable()
            CGPathMoveToPoint(subpath, nil, mid1.x, mid1.y)
            CGPathAddQuadCurveToPoint(subpath, nil, previousPoint.x, previousPoint.y, mid2.x, mid2.y)

            
            let bounds : CGRect = CGPathGetBoundingBox(subpath)
            let drawBox : CGRect = CGRectInset(bounds, -2.0 * self.lineWidth, -2.0 * self.lineWidth)
                        
            CGPathAddPath(path, nil, subpath)
            self.setNeedsDisplayInRect(drawBox)
        }
    }
}

    