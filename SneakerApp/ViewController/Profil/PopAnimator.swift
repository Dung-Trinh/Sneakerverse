//
//  PopAnimator.swift
//  SneakerApp
//
//  Created by Frank Pham on 20.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

@objc
protocol ZoomingViewController{
    func zoomingImageView(for transition: PopAnimator) -> UIImageView?
    func zoomingBackgroundView(for transition: PopAnimator) -> UIView?
    
    
}

enum TransitionState{
    case initial
    case final
}

class PopAnimator: NSObject{
    
    let transitionDuration = 0.8
    var operation: UINavigationController.Operation = .none
    private let zoomScale = CGFloat(15)
    private let backgroundScale = CGFloat(0.7)
    
    typealias ZoomingViews = (otherView: UIView, imageView: UIView)
    
    func configureViews(for state: TransitionState, containerView: UIView, backgroundViewController: UIViewController, viewsInBackground: ZoomingViews, viewsInForeground: ZoomingViews, snapshotViews: ZoomingViews){
        switch state {
        case .initial:
            backgroundViewController.view.transform = CGAffineTransform.identity
            backgroundViewController.view.alpha = 1
            
            snapshotViews.imageView.frame = containerView.convert(viewsInBackground.imageView.frame, from: viewsInBackground.imageView.superview)
        
            
        case .final:
            backgroundViewController.view.transform = CGAffineTransform(scaleX: backgroundScale, y: backgroundScale)
            backgroundViewController.view.alpha = 0
            
            snapshotViews.imageView.frame = containerView.convert(viewsInForeground.imageView.frame, from: viewsInForeground.imageView.superview)
        }
    }
    

}

extension PopAnimator : UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        var backgroundViewController = fromViewController
        var foregroundViewController = toViewController
        
        if operation == .pop{
            backgroundViewController = toViewController
            foregroundViewController = fromViewController
        }
        
        let maybeBackgroundImageView = (backgroundViewController as? ZoomingViewController)?.zoomingImageView(for: self)
        let maybeForegroundImageView = (foregroundViewController as? ZoomingViewController)?.zoomingImageView(for: self)
        
        assert(maybeBackgroundImageView != nil,"Keine Imageview im backgroundVC")
        assert(maybeForegroundImageView != nil,"Keine Imageview im backgroundVC")
        
        let backgroundImageView = maybeBackgroundImageView!
        let foregroundImageView = maybeForegroundImageView!
        
        let imageViewSnapshot = UIImageView(image: backgroundImageView.image)
        imageViewSnapshot.contentMode = .scaleAspectFill
        imageViewSnapshot.layer.masksToBounds = true
        
        backgroundImageView.isHidden = true
        foregroundImageView.isHidden = true
        let foregroundViewBackgroundColor = foregroundViewController.view.backgroundColor
        foregroundViewController.view.backgroundColor = UIColor.clear
        containerView.backgroundColor = UIColor.white
        
        containerView.addSubview(backgroundViewController.view)
        containerView.addSubview(foregroundViewController.view)
        containerView.addSubview(imageViewSnapshot)
        
        var preTransitionState = TransitionState.initial
        var postTransitionState = TransitionState.final
        
        if operation == .pop{
            preTransitionState = .final
            postTransitionState = .initial
        }
        
        configureViews(for: preTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundImageView,backgroundImageView), viewsInForeground: (foregroundImageView,foregroundImageView), snapshotViews: (imageViewSnapshot,imageViewSnapshot))
        
        foregroundViewController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations:{
            
            self.configureViews(for: postTransitionState, containerView: containerView, backgroundViewController: backgroundViewController, viewsInBackground: (backgroundImageView,backgroundImageView), viewsInForeground: (foregroundImageView,foregroundImageView), snapshotViews: (imageViewSnapshot,imageViewSnapshot))}) { (finished) in backgroundViewController.view.transform = CGAffineTransform.identity
                imageViewSnapshot.removeFromSuperview()
                backgroundImageView.isHidden = false
                foregroundImageView.isHidden = false
                foregroundViewController.view.backgroundColor = foregroundViewBackgroundColor
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
        }

        
    }
}

extension PopAnimator : UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is ZoomingViewController && toVC is ZoomingViewController{
            self.operation = operation
            return self
        } else{
            return nil
        }
    }
}
