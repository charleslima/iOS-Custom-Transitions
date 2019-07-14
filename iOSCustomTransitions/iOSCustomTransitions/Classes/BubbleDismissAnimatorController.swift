//
//  BubbleDismissAnimatorController.swift
//  iOSCustomTransitions
//
//  Created by Lima, Charles de Jesus on 21/06/18.
//  Copyright © 2018 Charles Lima. All rights reserved.
//

import UIKit

public class BubbleDismissAnimatorController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let destinationCenter: CGPoint
    private let bubbleColor: UIColor
    private let duration: TimeInterval
    
    /**
     
     Instantiate a BubbleDismissAnimatorController with the given parameters
     
     - Parameters:
     - duration: (Optional) The transition duration in seconds (default is 0.5)
     - destinationCenter: The destination center where bubble animation ends.
     - bubbleColor: Color to fill the background of animation.
     - returns:
     A new BubbleDismissAnimatorController object
     */
    public init(duration: TimeInterval = 0.5, destinationCenter: CGPoint, bubbleColor: UIColor) {
        self.duration = duration
        self.destinationCenter = destinationCenter
        self.bubbleColor = bubbleColor
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from),
            let fromVCSnapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
            else { return }
        
        let container = transitionContext.containerView
        let finalCenter = toVC.view.center
        let finalFrame = transitionContext.finalFrame(for: toVC).size

        container.addSubview(toVC.view)
        
        
        let bubbleView = UIView(frame: frameForBubble(finalCenter, size: finalFrame, start: destinationCenter))
        bubbleView.center = destinationCenter
        bubbleView.backgroundColor = bubbleColor
        bubbleView.layer.cornerRadius = bubbleView.frame.height / 2
        container.addSubview(bubbleView)
        
        fromVCSnapshot.center = fromVC.view.center
        container.addSubview(fromVCSnapshot)
        
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromVCSnapshot.center = self.destinationCenter
            fromVCSnapshot.alpha = 0.0
            fromVCSnapshot.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            bubbleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }) { (isFinished) in
            bubbleView.removeFromSuperview()
            fromVCSnapshot.removeFromSuperview()
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
