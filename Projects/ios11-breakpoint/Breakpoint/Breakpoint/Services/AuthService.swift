//
//  AuthService.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 20/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    // Singleton
    static let instance = AuthService()
    
    // Variables
    
    // Functions
    func registerUser(withEmail email: String, withPassword password: String, userCreationComplete: @escaping(_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provider": user.providerID, "email": user.email]
            
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, withPassword password: String, userLoginComplete: @escaping(_ status: Bool, _ error: Error?) -> ()) {
        
    }
}
