//
//  ViewEmbedder.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 12/11/21.
//

import Foundation
import UIKit

class ViewEmbedder {
    
    class func addChild(childController: UIViewController, parentController: UIViewController, containerView: UIView) {
        
        // Add child view controller to parent view controller
        parentController.addChild(childController)
        
        // Add child view controller's view to container view
        containerView.addSubview(childController.view)
        
        // Configure child view controller
        childController.view.frame = containerView.bounds
        childController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Move child view controller to parent view controller
        childController.didMove(toParent: parentController)
        
    }
    
    class func removeChild(childController: UIViewController, parentController: UIViewController, containerView: UIView) {
        
        // Move child view controller to nil
        childController.willMove(toParent: nil)
        
        // Remove child view controller's view from superview (container view)
        childController.view.removeFromSuperview()
        
        // Hide child view controller
        childController.view.isHidden = true
        
        // Remove child view controller from parent view controller
        childController.removeFromParent()
        
    }
    
}
