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
    
    // Default Functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Functions
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool) {
        self.imgProfile.image = image
        self.lblUser.text = email
        
        if isSelected {
            imgCheckmark.isHidden = false
        } else {
           imgCheckmark.isHidden = true
        }
    }
}
