//
//  ShadowImageView.swift
//  OnlineRadio
//
//  Created by Артём Балашов on 19/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowImageView: UIImageView {

    @IBInspectable override var shadowRadius: CGFloat {
        didSet {
            initShadow()
        }
    }
    
    override var frame: CGRect {
        didSet {
            shadowView.frame = frame
        }
    }
    
    private var shadowViewAnchors: [NSLayoutConstraint] = []
    
    override var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: newValue).cgPath
            layer.cornerRadius = newValue
        }
    }
    
    private let shadowView = UIView()
    
    init(frame: CGRect, shadowRadius: CGFloat) {
        super.init(frame: frame)
        self.shadowRadius = shadowRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initShadow() {
        shadowView.clipsToBounds = false
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: self.cornerRadius).cgPath
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        superview?.insertSubview(shadowView, belowSubview: self)
        shadowViewAnchors = shadowView.anchorWithReturnAnchors(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    override func removeFromSuperview() {
        shadowViewAnchors.forEach {$0.isActive = false}
        shadowView.removeFromSuperview()
        super.removeFromSuperview()
    }
    
}
