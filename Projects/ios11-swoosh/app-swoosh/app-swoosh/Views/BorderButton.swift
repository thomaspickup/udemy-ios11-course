//
//  BorderButton.swift
//  app-swoosh
//
//  Created by Thomas Pickup on 27/08/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class BorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
    }

}
