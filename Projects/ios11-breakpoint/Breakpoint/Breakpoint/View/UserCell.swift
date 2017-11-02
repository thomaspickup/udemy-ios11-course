//
//  UserCell.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 31/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgCheckmark: UIImageView!
    @IBOutlet weak var lblUser: UILabel!
    
    // Variables
    var showing = false
    
    // Default Functions`        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            if showing == false {
               imgCheckmark.isHidden = false
                showing = true
            } else {
                imgCheckmark.isHidden = true
                showing = false
            }
        }
    }

    // Functions
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool) {
        self.imgProfile.image = image
        self.lblUser.text = email
        
        if isSelected {
            self.imgCheckmark.isHidden = false
        } else {
           self.imgCheckmark.isHidden = true
        }
    }
}
