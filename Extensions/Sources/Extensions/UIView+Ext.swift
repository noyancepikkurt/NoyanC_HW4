//
//  UIView+Ext.swift
//  
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

extension UIViewController {
    public func setGradientBackground() {
        let topColor = UIColor(red: 0.2, green: 0.0, blue: 0.4, alpha: 1.0)
        let bottomColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
