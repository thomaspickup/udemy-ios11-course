//
//  ShadowView.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 17/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    // Functions
    override func awakeFromNib() {
        setUpView()
        super.awakeFromNib()
    }
    
    func setUpView() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
