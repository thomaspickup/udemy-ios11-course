//
//  vcEmailSignIn.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 17/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit

class vcEmailSignIn: UIViewController {
    // Outlets
    @IBOutlet weak var txtEmail: InSetTextField!
    @IBOutlet weak var txtPassword: InSetTextField!
    
    // Variables
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.delegate = self
        txtPassword.delegate = self
    }
    
    // Actions
    @IBAction func onSignInPressed(_ sender: Any) {
    }

    @IBAction func onClosePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Functions
}

extension vcLogin: UITextFieldDelegate {
    
}
