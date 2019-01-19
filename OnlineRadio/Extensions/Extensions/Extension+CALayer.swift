//
//  Extension+CALayer.swift
//  DealApp
//
//  Created by Egor Sakhabaev on 07.05.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
import UIKit
extension CALayer {
    func addGradienBorder(colors:[UIColor], width:CGFloat = 1) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  CGRect(origin: .zero, size: self.bounds.size)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0)
        gradientLayer.colors = colors.map({$0.cgColor})

        let shape = CAShapeLayer()
        shape.lineWidth = width
        shape.path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: width/2, dy: width/2), cornerRadius: self.cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradientLayer.mask = shape
        self.insertSublayer(gradientLayer, at: 0)
        


    }
    
}
extension CALayer {
    @discardableResult
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) -> CALayer {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: thickness, width: self.bounds.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - thickness, width: self.bounds.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.size.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.size.width - thickness, y: 0, width: thickness, height: self.frame.size.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
        return border
    }
    
}

