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
    
    //      Private
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    //      Public
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
    
    // Functions
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
        if groupKey != nil {
            // TO DO: Send to groups ref
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderID": uid])
            sendComplete(true)
        }
    }
    
    func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) {
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnap) in
            guard let feedMessageSnap = feedMessageSnap.children.allObjects as? [DataSnapshot] else { return }
            
            for message in feedMessageSnap {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderID = message.childSnapshot(forPath: "senderID").value as! String
                
                let message = Message(content: content, senderID: senderID)
                
                messageArray.append(message)
            }
            
            handler(messageArray)
        }
    }
    
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func getEmail(forSearchQuery searchQuery: String, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emails = [String]()
        
        REF_USERS.observe(.value) { (userSnap) in
            guard let userSnap = userSnap.children.allObjects as? [DataSnapshot] else { return }
            
            for users in userSnap {
                let email = users.childSnapshot(forPath: "email").value as! String
                
                if email.contains(searchQuery) == true && email != Auth.auth().currentUser?.email {
                    emails.append(email)
                }
            }
            
            handler(emails)
        }
    }
}
