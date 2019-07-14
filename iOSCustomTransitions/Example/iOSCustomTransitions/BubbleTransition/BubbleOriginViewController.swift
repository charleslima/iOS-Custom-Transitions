//
//  BubbleOriginViewController.swift
//  iOSCustomTransitions
//
//  Created by Lima, Charles de Jesus on 21/06/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import iOSCustomTransitions

class BubbleOriginViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addButton.layer.cornerRadius = self.addButton.frame.height / 2
        self.addButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = self
    }
    
}

extension BubbleOriginViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BubblePresentAnimatorController(originCenter: self.addButton.center, bubbleColor: self.addButton.backgroundColor ?? .white)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return BubbleDismissAnimatorController(destinationCenter: self.addButton.center, bubbleColor: self.addButton.backgroundColor ?? .white)
        
    }
    
}
