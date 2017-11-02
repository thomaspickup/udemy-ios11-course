//
//  GroupCell.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 02/11/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblMembers: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    // Functions
    func configureCell(title: String, description: String, memberCount: Int) {
        self.lblTitle.text = title
        self.lblDescription.text = description
        self.lblMembers.text = "\(memberCount) Members"
    }
}
