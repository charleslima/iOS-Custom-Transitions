//
//  ZoomingPresentAnimator.swift
//  iOSCustomTransitions
//
//  Created by Lima, Charles de Jesus on 19/06/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

public class ZoomingPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var duration: TimeInterval
    private let originFrame: CGRect
    private var transitionStyle: ZoomingTransitionStyle
    private var originViewSnapshot: UIView?
    private var animationBackgroundColor: UIColor
    private var cornerRadius: CGFloat
    
    /**
     
     Instantiate a ZoomingPresentAnimator with the given parameters
     
     - Parameters:
        - duration: (Optional) The transition duration in seconds (default is 0.3)
        - originFrame: The origin frame for zoom-in animation
        - animationBackgroundColor: (Optional) Color to fill the background of animation, it will be visible in mixed style when the views becomes transparent. (default is white)
        - cornerRadius: (Optional) Corner radius to be applied whole animation view (default is 0.0)
        - transitionStyle: (Optional) The style for zoom animation. (default is mixed)
        - originViewSnapshot: (Optional) Snapshot of origin view. It will be visible in .mixed and .fromViewAlways styles.
     - returns:
        A new ZoomingPresentAnimator object
     */
    public init(duration: TimeInterval = 0.3, originFrame: CGRect, animationBackgroundColor: UIColor = .white, cornerRadius: CGFloat = 0.0, transitionStyle: ZoomingTransitionStyle = .mixed, originViewSnapshot: UIView? = nil) {
        self.duration = duration
        self.originFrame = originFrame
        self.animationBackgroundColor = animationBackgroundColor
        self.transitionStyle = transitionStyle
        self.originViewSnapshot = originViewSnapshot
        self.cornerRadius = cornerRadius
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
            let toVCSnapshot = toVC.view.snapshotView(afterScreenUpdates: true) else { return }
        
        
        let container = transitionContext.containerView
        let backgrounView = UIView(frame: originFrame)
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        backgrounView.backgroundColor = self.animationBackgroundColor
        backgrounView.layer.cornerRadius = cornerRadius
        toVCSnapshot.layer.cornerRadius = cornerRadius
        toVCSnapshot.frame = originFrame
        toVC.view.isHidden = true
        
        
        container.addSubview(backgrounView)
        container.addSubview(toVC.view)
        
        switch self.transitionStyle {
        case .toViewAlways:
            
            container.addSubview(toVCSnapshot)
            
            UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModeCubic, animations: {
                backgrounView.frame = finalFrame
                toVCSnapshot.frame = finalFrame
            }, completion: { isFinished in
                toVC.view.isHidden = false
                toVCSnapshot.removeFromSuperview()
                backgrounView.removeFromSuperview()
                transitionContext.completeTransition(isFinished)
            })
            break
        case .fromViewAlways:
            
            guard let originViewSnapshot = self.originViewSnapshot else {
                assertionFailure("originViewSnapshot cannot be nil for fromViewAlways transition style")
                return
            }
            originViewSnapshot.layer.cornerRadius = cornerRadius
            originViewSnapshot.frame = originFrame
            container.addSubview(originViewSnapshot)
            
            UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModeCubic, animations: {
                backgrounView.frame = finalFrame
                originViewSnapshot.frame = finalFrame
            }, completion: { isFinished in
                toVC.view.isHidden = false
                originViewSnapshot.removeFromSuperview()
                backgrounView.removeFromSuperview()
                transitionContext.completeTransition(isFinished)
            })
            break
        case .mixed:
            
            guard let originViewSnapshot = self.originViewSnapshot else {
                assertionFailure("originViewSnapshot cannot be nil for mixed transition style")
                return
            }
            originViewSnapshot.layer.cornerRadius = cornerRadius
            originViewSnapshot.frame = originFrame
            container.addSubview(originViewSnapshot)
            toVCSnapshot.alpha = 0.0
            container.addSubview(toVCSnapshot)
            
            UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModeCubic, animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                    originViewSnapshot.frame = finalFrame
                    backgrounView.frame = finalFrame
                    toVCSnapshot.frame = finalFrame
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                    originViewSnapshot.alpha = 0.0
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                    toVCSnapshot.alpha = 1.0
                }
                
            }, completion: { isFinished in
                toVC.view.isHidden = false
                toVCSnapshot.removeFromSuperview()
                originViewSnapshot.removeFromSuperview()
                backgrounView.removeFromSuperview()
                transitionContext.completeTransition(isFinished)
            })
            break
        }
        
    }
    
    
}
