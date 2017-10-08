//
//  RoundedImage.swift
//  Smack
//
//  Created by Thomas Pickup on 02/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedImage: UIImageView {

    
    override func awakeFromNib() {
        self.setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.setUpView()
    }
    
}
