//
//  CircleWaveView.swift
//  ToneReader
//
//  Created by Mike on 11/24/19.
//  Copyright © 2019 Mike. All rights reserved.
//

import UIKit
import AudioKitUI

class CircleWaveView: EZAudioPlot {
    override func createPath(withPoints points: UnsafeMutablePointer<CGPoint>!, pointCount: UInt32, in rect: EZRect) -> Unmanaged<CGPath>! {
        
        let path = CGMutablePath()
        if pointCount > 0 {
            let xScale = rect.size.width  / CGFloat(pointCount)
            let halfHeight = floor(rect.size.height / 2.0)
            var xf = CGAffineTransform.identity
            let translateY: CGFloat = halfHeight + rect.origin.y;
            xf = xf.translatedBy(x: 0.0, y: translateY)
            let yScaleFactor = halfHeight
            xf = xf.scaledBy(x: xScale, y: -1 * yScaleFactor)
            path.move(to: .init(x: 0, y: halfHeight))
            
            for i in (0..<pointCount) {
                let idx = Int(i)
                guard let point = points?[idx] else { continue }
                
                path.addLine(to: point, transform: xf)
            }
            return Unmanaged.passRetained(path)
        }
        
        return super.createPath(withPoints: points, pointCount: pointCount, in: rect)
    }
    
    private func drawCircle(_ points: [Int]) {
        let xOffset: Double = Double(frame.size.width / 2.0)
        let yOffset: Double = Double(frame.size.height / 2.0)
        let segmentCount = 360.0 / Double(points.count)
        UIColor.black.setStroke()
        let path = UIBezierPath()
        path.lineWidth = 1.0
        path.move(to: .init(x: xOffset + 50, y: yOffset))
        for i in (0..<points.count) {
            let radius: Double = Double(50 + points[i])
            let angle = segmentCount * Double(i)
            let angleRad = angle * .pi / 180
            let x = xOffset + radius * cos(angleRad)
            let y = yOffset + radius * sin(angleRad)
            path.addLine(to: .init(x: x, y: y))
            path.stroke()
        }
    }
}
