//
//  NoSwipeSegmentedControl.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/9/21.
//

import Foundation
import UIKit

class NoSwipeSegmentedControl: UISegmentedControl {
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
