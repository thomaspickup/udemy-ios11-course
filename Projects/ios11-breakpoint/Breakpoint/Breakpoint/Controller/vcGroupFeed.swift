//
//  vcGroupFeed.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 03/11/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcGroupFeed: UIViewController {
    // Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblMembers: UILabel!
    @IBOutlet weak var txtMessage: InSetTextField!
    @IBOutlet weak var messageView: UIView!
    
    // Variables
    var group: Group?
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        messageView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lblTitle.text = group?.title
        DataService.instance.getEmail(forGroup: group!) { (emailsReturned) in
            self.lblMembers.text = emailsReturned.joined(separator: ", ")
        }
    }
    // Actions
    @IBAction func onBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onSendPressed(_ sender: Any) {
    }
    
    // Functions
    func initData(forGroup group: Group) {
        self.group = group
    }
}
