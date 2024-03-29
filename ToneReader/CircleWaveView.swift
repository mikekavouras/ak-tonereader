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
            
            path.move(to: CGPoint(x: centerX + baseRadius, y: centerY))
            
            for i in (0..<pointCount) {
                guard let point = points?[Int(i)] else { continue }
                
                let radius: Double = baseRadius + (Double(point.y) * scale)
                let degrees: Double = 360.0 * (Double(point.x)) / 1023.0
                let radians = degrees * .pi / 180.0
                let x = centerX + radius * cos(radians)
                let y = centerY + radius * sin(radians)
                path.addLine(to: .init(x: x, y: y))
            }
            
            return Unmanaged.passRetained(path)
        }
        
        return super.createPath(withPoints: points, pointCount: pointCount, in: rect)
    }
}
