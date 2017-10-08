//
//  vcProfile.swift
//  Smack
//
//  Created by Thomas Pickup on 03/09/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcProfile: UIViewController {
    // Outlets
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var vcBG: UIView!
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }

    // Actions
    @IBAction func onClosePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onLogOutPressed(_ sender: Any) {
        UserDataService.instance.logOutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    // Functions
    func setUpView() {
        imgProfile.image = UIImage(named: UserDataService.instance.avatarName)
        imgProfile.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        lblUsername.text = UserDataService.instance.name
        lblEmail.text = UserDataService.instance.email
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(vcProfile.closeTap(_:)))
        vcBG.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

}
