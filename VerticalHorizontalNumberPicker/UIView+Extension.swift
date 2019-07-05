//
//  UIView+Extension.swift
//  VerticalHorizontalNumberPicker
//
//  Created by Fariba Heidari on 4/14/1398 AP.
//  Copyright © 1398 AP Fariba Heidari. All rights reserved.
//

import Foundation
import UIKit


//Inspired from https://github.com/yashthaker7/NumberPicker
extension UIView {
    
    public enum GradientType {
        case vertical
        case horizontal
        case cross
    }
    
    public func applyGradient(colors: [UIColor], type: GradientType) {
        var endPoint: CGPoint!
        switch (type) {
        case .horizontal:
            endPoint = CGPoint(x: 1, y: 0)
        case .vertical:
            endPoint = CGPoint(x: 0, y: 1)
        case .cross:
            endPoint = CGPoint(x: 1, y: 1)
        }
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map{ $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = endPoint
        //self.layer.addSublayer(gradientLayer)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
