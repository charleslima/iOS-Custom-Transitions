//
//  ZoomingDismissAnimator.swift
//  iOSCustomTransitions
//
//  Created by Lima, Charles de Jesus on 20/06/18.
//

import UIKit

public class ZoomingDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var duration: TimeInterval
    private let destinationFrame: CGRect
    private var transitionStyle: ZoomingTransitionStyle
    private var destinationViewSnapshot: UIView?
    private var animationBackgroundColor: UIColor
    private var cornerRadius: CGFloat
    
    /**
     
     Instantiate a ZoomingPresentAnimator with the given parameters
     
     - Parameters:
     - duration: (Optional) The transition duration in seconds (default is 0.3)
     - destinationFrame: The destination frame for zoom-out animation
     - animationBackgroundColor: (Optional) Color to fill the background of animation, it will be visible in mixed style when the views becomes transparent. (default is white)
     - cornerRadius: (Optional) Corner radius to be applied whole animation view (default is 0.0)
     - transitionStyle: (Optional) The style for zoom animation. (default is mixed)
     - destinationViewSnapshot: (Optional) Snapshot of destination view. It will be visible in .mixed and .toViewAlways styles. If it is not given the animation will use a snapshot of entire destinationView
     - returns:
     A new ZoomingPresentAnimator object
     */
    
    public init(duration: TimeInterval = 0.3, destinationFrame: CGRect, animationBackgroundColor: UIColor = .white, cornerRadius: CGFloat = 0.0, transitionStyle: ZoomingTransitionStyle = .mixed, destinationViewSnapshot: UIView? = nil) {
        self.duration = duration
        self.destinationFrame = destinationFrame
        self.animationBackgroundColor = animationBackgroundColor
        self.transitionStyle = transitionStyle
        self.destinationViewSnapshot = destinationViewSnapshot
        self.cornerRadius = cornerRadius
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let toVCViewSnapshot = toVC.view.snapshotView(afterScreenUpdates: true),
            let toVCSnapshot = destinationViewSnapshot != nil ? destinationViewSnapshot : toVC.view.snapshotView(afterScreenUpdates: true) else { return }
        
        guard fromVC.modalPresentationStyle == .overCurrentContext || toVC.modalPresentationStyle == .overFullScreen else {
            assertionFailure("ZoomingPresentAnimator is only available for viewControllers with following modalPresentationStyles : .overCurrentContext, .overFullScreen")
            return
        }
        
        let container = transitionContext.containerView
        let originFrame = transitionContext.initialFrame(for: fromVC)
        let finalFrame = destinationFrame
        let backgrounView = UIView(frame: originFrame)
        
        backgrounView.backgroundColor = self.animationBackgroundColor
        backgrounView.layer.cornerRadius = cornerRadius
        toVCSnapshot.layer.cornerRadius = cornerRadius
        toVCSnapshot.frame = originFrame
        
        
        container.addSubview(toVCViewSnapshot)
        container.addSubview(backgrounView)
        
        switch self.transitionStyle {
        case .toViewAlways:
            
            container.addSubview(toVCSnapshot)
            
            UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModeCubic, animations: {
                backgrounView.frame = finalFrame
                toVCSnapshot.frame = finalFrame
            }, completion: { isFinished in
                toVCSnapshot.removeFromSuperview()
                backgrounView.removeFromSuperview()
                transitionContext.completeTransition(isFinished)
            })
            break
        case .fromViewAlways:
            
            guard let originViewSnapshot = fromVC.view.snapshotView(afterScreenUpdates: false) else {
                transitionContext.completeTransition(true)
                return
            }
            
            originViewSnapshot.layer.cornerRadius = cornerRadius
            originViewSnapshot.frame = originFrame
            container.addSubview(originViewSnapshot)
            
            UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModeCubic, animations: {
                backgrounView.frame = finalFrame
                originViewSnapshot.frame = finalFrame
            }, completion: { isFinished in
                originViewSnapshot.removeFromSuperview()
                backgrounView.removeFromSuperview()
                transitionContext.completeTransition(isFinished)
            })
            break
        case .mixed:
            
            guard let originViewSnapshot = fromVC.view.snapshotView(afterScreenUpdates: false) else {
                transitionContext.completeTransition(true)
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
                toVCSnapshot.removeFromSuperview()
                originViewSnapshot.removeFromSuperview()
                backgrounView.removeFromSuperview()
                transitionContext.completeTransition(isFinished)
            })
            break
        }
        
    }
    
}
