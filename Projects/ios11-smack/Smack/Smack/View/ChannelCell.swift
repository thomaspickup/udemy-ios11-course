//
//  ChannelCell.swift
//  Smack
//
//  Created by Thomas Pickup on 03/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }

    func configureCell(channel : Channel) {
        let title = channel.title ?? ""
        lblName.text = "#\(title)"
        lblName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                lblName.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
            }
        }
    }
}
