//
//  Extension+Motion+UIViewController.swift
//  Olimp
//
//  Created by Artem Balashov on 19/09/2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
//import Motion
import UIKit
//import SideMenuSwift

struct CardViewPresentationData {
    
    var rect: CGRect?
    var radius: CGFloat?
    weak var view: UIView?
    var trueRect: CGRect
    
    init(view: UIView?, rect: CGRect?, radius: CGFloat?) {
        self.rect = rect
        self.radius = radius
        self.view = view
        trueRect = view!.frameToWindow(withoutTransform: true) ?? .zero
    }
}

extension UIViewController {
    
    func presentAsCard(_ card: CardViewController, with data: CardViewPresentationData, faded: Bool = true, animated: Bool, completion:(() -> Void)?) {
        guard let vc = card as? UIViewController else {
            fatalError("YOU CANNOT PRESENT BECAUSE \(card.self) != \(UIViewController.self)")
        }

        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = CardTransitionManager.shared
        CardTransitionManager.shared.configure(with: data)
        vc.modalPresentationCapturesStatusBarAppearance = true
        self.present(vc, animated: animated, completion: completion)
    }
}

extension UINavigationController {
    
    func pushAsCard(_ card: CardViewController, with data: CardViewPresentationData, faded: Bool = true, animated: Bool, completion:(() -> Void)?) {
        guard let vc = card as? UIViewController else {
            fatalError("YOU CANNOT PRESENT BECAUSE \(card.self) != \(UIViewController.self)")
        }

        guard let rect = data.rect, let windowFrame = UIApplication.shared.keyWindow?.frame else {
            self.pushViewController(vc, animated: true)
            return
        }
        self.pushViewController(vc, animated: true)
    }
}

protocol StatusBarHiddenViewController {}

@objc protocol CardViewController: class {
    @objc var cardDestinationView: UIView! { get }
}

extension UIViewController: CardViewController {
    @objc var cardDestinationView: UIView! {
        if self is UINavigationController {
            return (self as! UINavigationController).visibleViewController?.cardDestinationView
        }
        return nil
    }
}



class CardTransitionManager: NSObject {
    static let shared = CardTransitionManager()
    private var data: CardViewPresentationData!
    private let transitionDurationForPresent: TimeInterval = 0.8
    private let transitionDurationForDismiss: TimeInterval = 0.4

    private override init() {}
    
    func configure(with data: CardViewPresentationData) {
        self.data = data
    }
    
    public func clearData() {
        self.data = nil
    }
    
}

// Bind everything together
extension CardTransitionManager: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardPresentAnimator(data: data, duration: transitionDurationForPresent)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardDismissAnimator(data: data, duration: transitionDurationForDismiss)
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        // TODO: - check this
        return nil
    }
}

class CardPresentAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    private var data: CardViewPresentationData!
    private var animationDuration: TimeInterval!
    private let blurView: UIVisualEffectView = {
        let blurEffect: UIBlurEffect
        if #available(iOS 10.0, *) {
            blurEffect = UIBlurEffect(style: .prominent)
        } else {
            blurEffect = UIBlurEffect(style: .light)
        }
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    init(data: CardViewPresentationData, duration: TimeInterval) {
        self.data = data
        self.animationDuration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let ctx = transitionContext
        let to = ctx.viewController(forKey: .to)
        let toView = to!.view!
        let from: UIViewController!
        
        from = ctx.viewController(forKey: .from)
        let rect = data.rect!
        let sourceViewSnapshot = data.view!.snapshotView(afterScreenUpdates: true)!
        sourceViewSnapshot.cornerRadius = data.radius ?? data.view?.cornerRadius ?? 0
        let mask = UIView(frame: toView.frame)
        mask.clipsToBounds = true
        mask.backgroundColor = .black
        toView.mask = mask
        ctx.containerView.backgroundColor = .clear
        data.view?.layer.removeAllAnimations()
        data.view?.isHidden = true
        let window = UIApplication.shared.keyWindow!
        to!.cardDestinationView?.alpha = 0
        blurView.frame = ctx.containerView.frame
        blurView.alpha = 0
//        ctx.containerView.backgroundColor = toView.backgroundColor
        ctx.containerView.addSubview(blurView)
        let shadowView = UIView()
        ctx.containerView.addSubview(shadowView)
        ctx.containerView.addSubview(toView)
        ctx.containerView.addSubview(sourceViewSnapshot)
        sourceViewSnapshot.frame = data.rect!

        let otherSubviews: [UIView]
        let cardView = to!.cardDestinationView ?? UIView()
        
        if to is UINavigationController {
            otherSubviews = (to as! UINavigationController).topViewController?.view.subviews.filter {$0 !== cardView} ?? []
        } else {
            otherSubviews = toView.subviews.filter {$0 !== cardView}
        }
        if cardView.superview is UITableView {
            otherSubviews.removeAll(where: {$0 === cardView.superview ?? UIView()})
        }
        _ = otherSubviews.map {$0.alpha = 0}
        toView.frame = window.frame
        toView.frame.origin.y = rect.origin.y
        mask.frame = rect
        mask.frame.origin.y = 0
        mask.frame.size.height = rect.height
        mask.cornerRadius = data.radius!
        shadowView.cornerRadius = data.radius!
        shadowView.applyStandardShadow()
        shadowView.layer.shadowOpacity = 0.2
        shadowView.backgroundColor = .white
        shadowView.clipsToBounds = false
        shadowView.frame = rect
        mask.frame.size.height = rect.height
        mask.layer.masksToBounds = false
        from?.viewWillDisappear(true)
        to?.viewWillAppear(true)
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: ctx) / 2, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
                mask.frame.size.height = ctx.containerView.frame.height
                shadowView.frame.size.height = ctx.containerView.frame.height
                mask.cornerRadius = 0
                self.blurView.alpha = 1
                mask.frame.origin.x = ctx.containerView.frame.origin.x
                mask.frame.size.width = ctx.containerView.frame.width
                shadowView.frame.origin.x = ctx.containerView.frame.origin.x
                shadowView.frame.size.width = ctx.containerView.frame.width
                shadowView.cornerRadius = 0
                shadowView.frame.origin.y = 0
                sourceViewSnapshot.frame.origin.x = ctx.containerView.frame.origin.x
                sourceViewSnapshot.frame.size.width = ctx.containerView.frame.size.width
                sourceViewSnapshot.frame.origin.y = to?.cardDestinationView?.frame.origin.y ?? 0
                _ = otherSubviews.map {$0.alpha = 1}
            })
        }) { (finished) in
            
        }
       
        UIView.animate(withDuration: self.transitionDuration(using: ctx), delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.5, options: [], animations: {
            toView.frame.origin.y = 0
            mask.frame.origin.y = 0
            sourceViewSnapshot.alpha = 0
            to!.cardDestinationView?.alpha = 1
        }) { (finished) in
            to?.viewDidAppear(true)
            sourceViewSnapshot.removeFromSuperview()
            shadowView.removeFromSuperview()
            self.blurView.removeFromSuperview()
            from?.viewDidDisappear(true)
            ctx.completeTransition(!ctx.transitionWasCancelled)
            from.view.isHidden = true
            self.data.view?.isHidden = false
        }
        
    }
}



class CardDismissAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    private var data: CardViewPresentationData!
    private var animationDuration: TimeInterval!
    private let blurView: UIVisualEffectView = {
        let blurEffect: UIBlurEffect
        if #available(iOS 10.0, *) {
            blurEffect = UIBlurEffect(style: .prominent)
        } else {
            blurEffect = UIBlurEffect(style: .light)
        }
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    init(data: CardViewPresentationData, duration: TimeInterval) {
        self.data = data
        self.animationDuration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from)
            else {
                return
        }
        let ctx = transitionContext
        let toVC: UIViewController!
        
        toVC = ctx.viewController(forKey: .to)
        let containerView = ctx.containerView
        let fromView = fromVC.view!
        ctx.containerView.backgroundColor = fromView.backgroundColor
        fromView.clipsToBounds = true
        let maskView = UIView.init(frame: fromView.frame)
        maskView.backgroundColor = .black
        maskView.clipsToBounds = true
        containerView.mask = maskView
        var otherSubviews: [UIView]
        toVC.view.isHidden = false
        let cardView = fromVC.cardDestinationView ?? UIView()
        if let view = (fromVC as? UINavigationController)?.topViewController?.view {
            otherSubviews = view.subviews.filter {$0 !== cardView}
            otherSubviews.append((fromVC as! UINavigationController).navigationBar)
        } else {
            otherSubviews = fromView.subviews.filter {$0 !== cardView}
        }
        let cardViewFrame = cardView.superview?.convert(cardView.frame, to: nil)
        let cardViewSnapshot = data.view!.snapshotView(afterScreenUpdates: true)!
        let displayingCardView = cardView.snapshotView(afterScreenUpdates: true)!
        cardView.isHidden = true
        ctx.containerView.addSubview(blurView)
        blurView.frame = ctx.containerView.frame
        blurView.alpha = 1
        containerView.addSubview(fromView)
        containerView.addSubview(cardViewSnapshot)
        containerView.addSubview(displayingCardView)
        displayingCardView.frame = cardViewFrame ?? .zero
        cardViewSnapshot.frame = cardViewFrame ?? .zero
        cardViewSnapshot.cornerRadius = data.radius ?? 0
        cardView.clipsToBounds = true
        cardViewSnapshot.alpha = 0
        data.view?.alpha = 0
        maskView.layer.masksToBounds = false
        toVC.viewWillAppear(true)
        fromVC.viewWillDisappear(true)
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: ctx), delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
                maskView.cornerRadius = self.data.radius!
                maskView.frame = self.data.trueRect
                displayingCardView.frame = self.data.trueRect
                cardViewSnapshot.frame = self.data.trueRect
                fromView.frame.origin.y = self.data.trueRect.origin.y
                if cardView.superview?.isKind(of: UIScrollView.self) == true  {
                    _ = otherSubviews.filter {$0 !== cardView.superview ?? UIView()}.map {$0.alpha = 0}
                } else {
                    _ = otherSubviews.map {$0.alpha = 0}
                }
                 _ = otherSubviews.filter {$0.isKind(of: UIScrollView.self) == true}.map {$0.transform = CGAffineTransform.init(translationX: 0, y: -250)}
                ctx.containerView.layoutIfNeeded()

                displayingCardView.alpha = 0
                self.blurView.alpha = 0
            })
            UIView.addKeyframe(withRelativeStartTime: 4/5, relativeDuration: 1/5, animations: {
                ctx.containerView.alpha = 0
                UIView.performWithoutAnimation {
                    self.data.view?.alpha = 1
                    self.data = nil
                    CardTransitionManager.shared.clearData()
                }
            })
        }) { (finished) in
            displayingCardView.removeFromSuperview()
            fromView.removeFromSuperview()
            cardViewSnapshot.removeFromSuperview()
            self.blurView.removeFromSuperview()
            toVC.viewDidAppear(true)
            fromVC.viewDidDisappear(true)
            
            fromVC.transitioningDelegate = nil
            ctx.completeTransition(true)
        }
        
        UIView.animate(withDuration: self.transitionDuration(using: ctx), delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
            cardViewSnapshot.alpha = 1
        }) { (finished) in }
    }
    
    
}
