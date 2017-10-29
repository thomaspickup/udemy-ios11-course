//
//  vcPost.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 29/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

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
        
        txtMessage.delegate = self
    }
    
    // Actions
    @IBAction func onSendPressed(_ sender: Any) {
        
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
