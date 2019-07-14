//
//  BubblePresentAnimatorController.swift
//  iOSCustomTransitions
//
//  Created by Lima, Charles de Jesus on 21/06/18.
//  Copyright © 2018 Charles Lima. All rights reserved.
//

import UIKit

public class BubblePresentAnimatorController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originCenter: CGPoint
    private let bubbleColor: UIColor
    private let duration: TimeInterval
    
    /**
     
     Instantiate a BubblePresentAnimatorController with the given parameters
     
     - Parameters:
     - duration: (Optional) The transition duration in seconds (default is 0.5)
     - originCenter: The origin center where bubble animation ends.
     - bubbleColor: Color to fill the background of animation.
     - returns:
     A new BubblePresentAnimatorController object
     */
    public init(duration: TimeInterval = 0.5, originCenter: CGPoint, bubbleColor: UIColor) {
        self.duration = duration
        self.originCenter = originCenter
        self.bubbleColor = bubbleColor
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toVC = transitionContext.viewController(forKey: .to),
            let toVCSnapshot = toVC.view.snapshotView(afterScreenUpdates: true)
            else { return }
        
        let container = transitionContext.containerView
        let finalCenter = toVC.view.center
        let finalFrame = transitionContext.finalFrame(for: toVC).size
        toVC.view.isHidden = true
        container.addSubview(toVC.view)
        
        let bubbleView = UIView(frame: frameForBubble(finalCenter, size: finalFrame, start: originCenter))
        bubbleView.center = originCenter
        bubbleView.backgroundColor = bubbleColor
        bubbleView.layer.cornerRadius = bubbleView.frame.height / 2
        bubbleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        container.addSubview(bubbleView)
        
        toVCSnapshot.center = originCenter
        toVCSnapshot.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        toVCSnapshot.alpha = 0.0
        
        container.addSubview(toVCSnapshot)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            toVCSnapshot.center = finalCenter
            toVCSnapshot.alpha = 1.0
            toVCSnapshot.transform = .identity
            bubbleView.transform = .identity
        }) { (isFinished) in
            bubbleView.removeFromSuperview()
            toVCSnapshot.removeFromSuperview()
            toVC.view.isHidden = false
            transitionContext.completeTransition(isFinished)
        }
        
    }
    
    private func frameForBubble(_ originalCenter: CGPoint, size originalSize: CGSize, start: CGPoint) -> CGRect {
        let lengthX = fmax(start.x, originalSize.width - start.x)
        let lengthY = fmax(start.y, originalSize.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
}
