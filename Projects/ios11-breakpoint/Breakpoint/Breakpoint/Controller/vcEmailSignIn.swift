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
        if txtEmail.text != nil && txtPassword.text != nil {
            AuthService.instance.loginUser(withEmail: txtEmail.text!, withPassword: txtPassword.text!, userLoginComplete: { (success, error) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing: error?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.txtEmail.text!, withPassword: self.txtPassword.text!, userCreationComplete: { (success, error) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.txtEmail.text!, withPassword: self.txtPassword.text!, userLoginComplete: { (success, nil) in
                            self.dismiss(animated: true, completion: nil)
                        })
                    } else {
                        print(String(describing: error?.localizedDescription))
                    }
                })
            })
        }
    }

    @IBAction func onClosePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Functions
}

extension vcEmailSignIn: UITextFieldDelegate {
    
}
