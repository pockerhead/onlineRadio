//
//  Extension+UIImage.swift
//  DealApp
//
//  Created by Egor Sakhabaev on 09.05.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    
    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func fitImage(size: CGSize) -> UIImage? {
        let widthRatio = size.width / self.size.width
        let heightRatio = size.height / self.size.height
        let ratio = min(widthRatio, heightRatio)
        
        let imageWidth = self.size.width * ratio
        let imageHeight = self.size.height * ratio
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:imageWidth, height:imageHeight), false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}

extension UIImage {
    
    func isEqualToImage(image: UIImage) -> Bool {
        let data1: Data = self.pngData()!
        let data2: Data = image.pngData()!
        return data1 == data2
    }
    
}

extension UIImage {
    class func imageWithLabel(label: UILabel) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

extension UIImage {
    
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        if let pixelData = self.cgImage?.dataProvider?.data {
            let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
            
            let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
            
            let r = CGFloat(data[pixelInfo+0]) / CGFloat(255.0)
            let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
            let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
            let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
            
            return UIColor(red: b, green: g, blue: r, alpha: a)
        } else {
            //IF something is wrong I returned WHITE, but change as needed
            return UIColor.white
        }
    }
    
    func getPixelBrightness(pos: CGPoint) -> CGFloat {
        
        if let pixelData = self.cgImage?.dataProvider?.data {
            let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
            
            let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
            
            let r = CGFloat(data[pixelInfo+0]) / CGFloat(255.0)
            let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
            let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
//            let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
            
            return ((r * 299) + (g * 587) + (b * 114)) / 1000
        } else {
            //IF something is wrong I returned WHITE, but change as needed
            return 0.5
        }
    }
}
