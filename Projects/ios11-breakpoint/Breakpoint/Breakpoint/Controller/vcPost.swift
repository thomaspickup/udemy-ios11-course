//
//  vcPost.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 29/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit
import Firebase

class vcPost: UIViewController {
    // Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    
    // Variables
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.instance.getUsername(forUID: (Auth.auth().currentUser?.uid)!) { (returnedUser) in
            self.lblUser.text = returnedUser
        }
        txtMessage.delegate = self
        btnSend.bindToKeyboard()
        imgProfile.image = #imageLiteral(resourceName: "defaultProfileImage")
    }
    
    // Actions
    @IBAction func onSendPressed(_ sender: Any) {
        if txtMessage.text != nil && txtMessage.text != "Say Something Here..." {
            btnSend.isEnabled = false
            DataService.instance.uploadPost(withMessage: txtMessage.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
                if isComplete {
                    self.btnSend.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.btnSend.isEnabled = true
                    print("There was an error")
                }
            })
        }
    }
    
    @IBAction func onExitPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Functions
    
}

extension vcPost: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        txtMessage.text = ""
    }
}
