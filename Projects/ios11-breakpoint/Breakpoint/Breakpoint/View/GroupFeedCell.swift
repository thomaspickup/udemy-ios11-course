//
//  GroupFeedCell.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 03/11/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    // View Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Functions
    func configureCell(profileImage: UIImage, email: String, content: String) {
        self.imgProfile.image = profileImage
        self.lblEmail.text = email
        self.lblContent.text = content
    }
}
