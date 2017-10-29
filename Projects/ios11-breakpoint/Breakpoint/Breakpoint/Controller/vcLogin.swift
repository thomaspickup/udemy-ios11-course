//
//  vcLogin.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 17/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import UIKit
import Firebase

class vcLogin: UIViewController {
    // Outlets
    
    // Variables
    
    // View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    // Actions
    @IBAction func onEmailPressed(_ sender: Any) {
        let vcEmailSignIn = storyboard?.instantiateViewController(withIdentifier: "vcEmailSignIn")
        present(vcEmailSignIn!, animated: true, completion: nil)
    }
    @IBAction func onFacebookPressed(_ sender: Any) {
    }
    @IBAction func onGooglePressed(_ sender: Any) {
    }
    
    // Functions
    
}
