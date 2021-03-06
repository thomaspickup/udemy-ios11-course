//
//  FeedCell.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 29/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    
    // Functions
    func configureCell(profileImage: UIImage, email: String, content: String) {
        self.imgProfile.image = profileImage
        self.lblMessage.text = content
        self.lblUsername.text = email
    }
}
