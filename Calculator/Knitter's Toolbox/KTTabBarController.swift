//
//  KTTabBarController.swift
//  Knitter's Toolbox
//
//  Created by Jonathan Herzog on 2/3/15.
//  Copyright (c) 2015 Amy Herzog Designs. All rights reserved.
//

import Foundation
import UIKit


class KTTabBarControllerAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var toLeft: Bool
    
    init(toLeft: Bool){
        self.toLeft = toLeft
    }
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        
        // set up from 2D transforms that we'll use in the animation
        let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
        let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
        
        var fromTransform = offScreenLeft
        var toTransform = offScreenRight
        
        if !toLeft {
            fromTransform = offScreenRight
            toTransform = offScreenLeft
            
        }
        // start the toView to the right of the screen
        toView.transform = toTransform
        
        // add the both views to our view controller
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // get the duration of the animation
        // DON'T just type '0.5s' -- the reason why won't make sense until the next post
        // but for now it's important to just follow this approach
        let duration = self.transitionDuration(transitionContext)
        
        
        // perform the animation!
        // for this example, just slid both fromView and toView to the left at the same time
        // meaning fromView is pushed off the screen and toView slides into view
        UIView.animateWithDuration(duration, animations: {
            
            fromView.transform = fromTransform
            toView.transform = CGAffineTransformIdentity
            
            }, completion: { finished in
                
                // tell our transitionContext object that we've finished animating
                transitionContext.completeTransition(true)
                toView.transform = CGAffineTransformIdentity
                fromView.transform = CGAffineTransformIdentity
                
        })
        
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.3
    }
    
    
}





class KTTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override init(nibName: String?, bundle: NSBundle?) {
        super.init(nibName: nibName, bundle: bundle)
        self.delegate = self
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
    }

    
    func tabBarController(tabBarController: UITabBarController,
        animationControllerForTransitionFromViewController fromVC: UIViewController,
        toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            var toIndex: Int = 0
            var fromIndex: Int = 0
            for (i, value) in enumerate(self.viewControllers!) {
                if fromVC == value as UIViewController {
                    fromIndex = i
                }
                
                if toVC == value as UIViewController {
                    toIndex = i
                }
            }
            
            
            if toIndex == fromIndex {
                return nil
            } else if toIndex < fromIndex {
                return KTTabBarControllerAnimation(toLeft: false)
            } else {
                return KTTabBarControllerAnimation(toLeft: true)
            }
            
    }
    

    
}