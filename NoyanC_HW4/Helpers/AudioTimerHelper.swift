//
//  AudioTimerHelper.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

import UIKit

final class AudioTimerHelper {
    static func createProgressLayer(in view: UIView) -> CAShapeLayer {
        let progressLayer = CAShapeLayer()
        let center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        let radius = view.bounds.width / 2.0
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + (2 * CGFloat.pi)
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.red.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 3.0
        progressLayer.strokeStart = 0.0
        return progressLayer
    }
    
    static func startProgressAnimation(in view: UIView, duration: TimeInterval, delegate: CAAnimationDelegate? = nil) {
        let progressLayer = createProgressLayer(in: view)
        view.layer.addSublayer(progressLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = duration
        animation.delegate = delegate
        progressLayer.add(animation, forKey: "progressAnimation")
    }
    
    static func removeExistingProgressLayers(from view: UIView) {
        if let sublayers = view.layer.sublayers {
            for layer in sublayers {
                if layer is CAShapeLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
}

