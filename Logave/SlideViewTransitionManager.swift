//
//  SlideViewTransitionController.swift
//  Logave
//
//  Created by Andrew Johnsson on 17.09.15.
//  Copyright © 2015 Logave. All rights reserved.
//


import UIKit

protocol slideViewTransitionManagerDelegate {
    func dismiss()
}

class SlideTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var isPresenting = false
    var snapshot:UIView?
    
    var duration = 0.5
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!

        let container = transitionContext.containerView()
        
        let moveRight: CGAffineTransform
        
        if (UIDevice.currentDevice().model == "iPhone") {
            moveRight = CGAffineTransformMakeTranslation(150, 0)
        }
        else{
            moveRight = CGAffineTransformMakeTranslation(300, 0)
        }
        
        let moveLeft = CGAffineTransformMakeTranslation(-50, 0)

        if isPresenting {
            toView.transform = moveLeft
            snapshot = fromView.snapshotViewAfterScreenUpdates(true)
            container!.addSubview(toView)
            container!.addSubview(snapshot!)
        }

        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            if self.isPresenting {
                self.snapshot?.transform = moveRight
                toView.transform = CGAffineTransformIdentity
            } else {
                self.snapshot?.transform = CGAffineTransformIdentity
                fromView.transform = moveLeft
                }
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
                if !self.isPresenting {
                    self.snapshot?.removeFromSuperview()
                }
        })
    }
    
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
    }
    
}