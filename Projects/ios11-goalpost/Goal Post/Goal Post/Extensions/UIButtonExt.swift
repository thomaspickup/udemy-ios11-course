//
//  UIButtonExt.swift
//  Goal Post
//
//  Created by Thomas Pickup on 13/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

extension UIButton {
    func setSelectedColour() {
        self.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1)
    }
    
    func setDeselectedColour() {
        self.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.8666666667, blue: 0.6862745098, alpha: 1)
    }
}
