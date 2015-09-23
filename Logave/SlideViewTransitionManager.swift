//
//  SlideViewTransitionController.swift
//  Logave
//
//  Created by Andrew Johnsson on 17.09.15.
//  Copyright © 2015 Logave. All rights reserved.
//


import UIKit

@objc protocol slideViewTransitionManagerDelegate {
    func dismiss()
}

class SlideTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var duration = 0.5
    var isPresenting = false
    
    var snapshot:UIView?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // Get reference to our fromView, toView and the container view
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // Set up the transform for sliding
        let container = transitionContext.containerView()
        let moveRight = CGAffineTransformMakeTranslation(150, 0)
        let moveLeft = CGAffineTransformMakeTranslation(-50, 0)
        
        // Add both views to the container view
        if isPresenting {
            toView.transform = moveLeft
            snapshot = fromView.snapshotViewAfterScreenUpdates(true)
            container!.addSubview(toView)
            container!.addSubview(snapshot!)
        }
        
        // Perform the animation
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
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
        
        isPresenting = false
        return self
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
    }
    
}