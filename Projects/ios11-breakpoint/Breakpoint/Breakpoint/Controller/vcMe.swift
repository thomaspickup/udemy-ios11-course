//
//  vcMe.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 29/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit
import Firebase

class vcMe: UIViewController {
    // Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUsers: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.instance.getUsername(forUID: (Auth.auth().currentUser?.uid)!) { (returnedUser) in
            self.lblUsers.text = returnedUser
        }
    }
    
    // Actions
    @IBAction func onSignOutPressed(_ sender: Any) {
        
    }
    
    // Functions
}
