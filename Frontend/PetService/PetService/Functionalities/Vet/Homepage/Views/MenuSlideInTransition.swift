//
//  SlideInTransition.swift
//  PetService
//
//  Created by Dusan Milic on 03/12/2019.
//  Copyright © 2019 Dusan Milic. All rights reserved.
//

import UIKit

class MenuSlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = false
    let dimmingView: UIView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else{
                return
        }
        
        let containerView = transitionContext.containerView
        
        let menuWidth = toViewController.view.bounds.width * 0.8
        let menuHeight = toViewController.view.bounds.height
        
        if isPresenting{
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            containerView.addSubview(toViewController.view)
            
            toViewController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: menuHeight)
        }
        
        //menu slide in animation
        let transform = {
            self.dimmingView.alpha = 0.5
            toViewController.view.transform = CGAffineTransform(translationX: menuWidth, y: 0)
        }
        
        //menu slide out
        let identity = {
            self.dimmingView.alpha = 0
            fromViewController.view.transform = .identity
        }
        
        //animate transition
        let duration = transitionDuration(using: transitionContext)
        let isCanceled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!isCanceled)
        }
    }
    

}
