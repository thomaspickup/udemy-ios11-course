//
//  UIViewControllerExt.swift
//  Goal Post
//
//  Created by Thomas Pickup on 13/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetails(_ viewControllerToPresent: UIViewController) {
        // Creates Transition
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        // Adds Transition
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        // Presents view controller
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetails() {
        // Creates Transition
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        
        // Adds Transition
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        // Presents view controller
        dismiss(animated: false, completion: nil)
    }
}
