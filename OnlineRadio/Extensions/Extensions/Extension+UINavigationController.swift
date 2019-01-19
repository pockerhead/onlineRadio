//
//  Extension+UINavigationController.swift
//  DealApp
//
//  Created by Egor Sakhabaev on 17.05.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
import UIKit
extension UINavigationController {
    
//    public func pushViewController(_ viewController: UIViewController,
//                                   animated: Bool,
//                                   completion: (() -> Void)?) {
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        pushViewController(viewController, animated: animated)
//        CATransaction.commit()
//    }
    public func pushViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: (() -> Void)?)
    {
        pushViewController(viewController, animated: animated)
        
        guard animated, let coordinator = transitionCoordinator else {
            completion?()
            return
        }
        
        coordinator.animate(alongsideTransition: nil) { _ in completion?() }
    }

    public func removeViewController(_ vc: UIViewController){
        self.viewControllers = self.viewControllers.filter { $0 !== vc }
    }
    
    public func becomeTransparent() {
        self.navigationBar.isTranslucent = true
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.barTintColor = .clear
//        UIApplication.shared.statusBarView?.backgroundColor = .clear
    }
//
//    public func becomeOpaque() {
//        self.navigationBar.isTranslucent = false
//        self.navigationBar.setBackgroundImage(UIImage.init(color: .navigationBar), for: .default)
//        self.navigationBar.shadowImage = UIImage()
//        self.navigationBar.backgroundColor = .navigationBar
//        self.navigationBar.barTintColor = .navigationBar
//        self.navigationBar.layoutSubviews()
////        UIApplication.shared.statusBarView?.backgroundColor = .navigationBar
//    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
    var previousVC: UIViewController? {
        if self.viewControllers.count > 1 {
            return viewControllers[viewControllers.count - 2]
        }
        return nil
    }
    
}


