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
        let logoutPopup = UIAlertController(title: "Log Out?", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Log Out", style: .destructive) { (buttonTapped) in
            do{
                try Auth.auth().signOut()
                let vcLogin = self.storyboard?.instantiateViewController(withIdentifier: "vcLogin") as? vcLogin
                self.present(vcLogin!, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        logoutPopup.addAction(logoutAction)
        logoutPopup.addAction(cancelAction)
        
        present(logoutPopup, animated: true, completion: nil)
    }
    
    // Functions
}
