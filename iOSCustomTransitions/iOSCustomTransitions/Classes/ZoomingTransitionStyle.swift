//
//  ZoomingTransitionStyle.swift
//  iOSCustomTransitions
//
//  Created by Lima, Charles de Jesus on 20/06/18.
//

import UIKit

public enum ZoomingTransitionStyle {
    /// inserts the destination view snapshot in the begining of the animation and resize it to final frame.
    case toViewAlways
    /// animate the given origin view snapshot until it is fullt hidden, then shows the destination view until it is fully visible.
    case mixed
    /// inserts the given origin view snapshot in the begining of the animation and resize it to final frame, then replace it with the destination view.
    case fromViewAlways
}
