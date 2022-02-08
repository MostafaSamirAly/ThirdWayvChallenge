//
//  PresentingAnimator.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 08/02/2022.
//

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.6
    var presenting = true
    var originFrame = CGRect.zero
    
    var dismissCompletion: (() -> Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let view: UIView =  {
            if presenting {
                if let toView = transitionContext.view(forKey: .to) {
                    return toView
                }else {
                    return UIView()
                }
            }else {
                if let fromView = transitionContext.view(forKey: .from) {
                    return fromView
                }else {
                    return UIView()
                }
            }
        }()
        
        let initialFrame = presenting ? originFrame : view.frame
        let finalFrame = presenting ? view.frame : originFrame
        
        let xScaleFactor = presenting ?
        initialFrame.width / finalFrame.width :
        finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
        initialFrame.height / finalFrame.height :
        finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            view.transform = scaleTransform
            view.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            view.clipsToBounds = true
            containerView.addSubview(view)
            containerView.bringSubviewToFront(view)
        }
        view.layer.masksToBounds = true
        
        UIView.animate(
            withDuration: duration,
            delay:0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.2,
            animations: {
                view.transform = self.presenting ? .identity : scaleTransform
                view.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            }, completion: { _ in
                if !self.presenting {
                    self.dismissCompletion?()
                }
                transitionContext.completeTransition(true)
            })
    }
}
