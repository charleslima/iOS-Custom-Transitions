//
//  ZoomingOriginViewController.swift
//  iOSCustomTransitions
//
//  Created by Lima, Charles de Jesus on 19/06/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import iOSCustomTransitions

class ZoomingOriginViewController: UIViewController {

    @IBOutlet weak var cardButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = self
    }
}

extension ZoomingOriginViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZoomingPresentAnimator(originFrame: self.cardButton.frame, animationBackgroundColor: self.cardButton.backgroundColor ?? .white, transitionStyle: .mixed, originViewSnapshot: self.cardButton.snapshotView(afterScreenUpdates: true))
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZoomingDismissAnimator(destinationFrame: self.cardButton.frame, animationBackgroundColor: self.cardButton.backgroundColor ?? .white, transitionStyle: .mixed, destinationViewSnapshot: self.cardButton.snapshotView(afterScreenUpdates: false))
    }
}
