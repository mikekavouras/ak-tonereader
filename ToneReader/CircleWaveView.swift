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
            let centerX: Double = Double(frame.size.width) / 2.0
            let centerY: Double = Double(frame.size.height) / 2.0
            let baseRadius: Double = 100.0
            let scale: Double = 50.0
            let mirrorAmount = 180
            var mirrorPoints = [Double]()
            
            path.move(to: CGPoint(x: centerX + baseRadius, y: centerY))
            
            for i in (0..<pointCount) {
                /// Create a mirrorIndex, for example:
                /// If mirrorAmount is set to 50, the mirror index will be 0
                /// on point 974, and will be 49 by 1024
                ///
                /// NOTE: I'm trying to figure out whether it should be subtracting
                /// 1023 or 1024 in this mirrorIndex equation
                let mirrorIndex = ((Int(i) + mirrorAmount) - 1023) - 1
                var radius: Double
                
                /// I don't think just adding 1 is how to solve this, but
                guard let point = points?[Int(i)+1] else { continue }
                
                radius = baseRadius + (Double(point.y) * scale)
                
                /// Once we get to the last points, and the mirrorIndex is 0 or above,
                /// as explained above, we start averaging the radius with its original point
                /// and its mirror point, slowly increasing the percentage towards the mirror point
                /// until it reaches 100% mirrored by the last point
                if mirrorIndex >= 0 {
                    let percentage = ((100/Double(mirrorAmount)) * Double(mirrorIndex))/100
                    radius = (radius * (1 - percentage)) + (mirrorPoints[mirrorIndex] * percentage)
                }
                
                let degrees: Double = 360.0 * (Double(point.x)) / 1023.0
                let radians = degrees * .pi / 180.0
                let x = centerX + radius * cos(radians)
                let y = centerY + radius * sin(radians)
                    
                /// Add radius to the beginning of the mirrorPoints array
                /// if the index is below the mirror amount
                if i < mirrorAmount {
                    mirrorPoints.insert(radius, at: 0)
                }
                path.addLine(to: .init(x: x, y: y))
            }
            
            return Unmanaged.passRetained(path)
        }
        
        return super.createPath(withPoints: points, pointCount: pointCount, in: rect)
    }
}
