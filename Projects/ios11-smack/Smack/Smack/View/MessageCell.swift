//
//  MessageCell.swift
//  Smack
//
//  Created by Thomas Pickup on 05/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    // Outlets
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTimestamp: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var imgUser: RoundedImage!
    
    // Views
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Functions
    func configureCell(message: Message) {
        lblMessage.text = message.message
        lblUsername.text = message.userName
        imgUser.image = UIImage(named: message.userAvatar)
        imgUser.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColour)
        
        guard var isoDate = message.timestamp else { return }
        
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormater = DateFormatter()
        newFormater.dateFormat = "d MMM, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormater.string(from: finalDate)
            lblTimestamp.text = finalDate
        }
    }
}
