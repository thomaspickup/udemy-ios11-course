//
//  DataService.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 15/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import Foundation
import Firebase

// Database Constant
let DB_BASE = Database.database().reference()

class DataService {
    // Variables
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    
}
