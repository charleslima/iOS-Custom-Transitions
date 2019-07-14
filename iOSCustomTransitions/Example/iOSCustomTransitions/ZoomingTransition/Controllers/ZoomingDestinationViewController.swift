//
//  ZoomingDestinationViewController.swift
//  iOSCustomTransitions
//
//  Created by Lima, Charles de Jesus on 19/06/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ZoomingDestinationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
