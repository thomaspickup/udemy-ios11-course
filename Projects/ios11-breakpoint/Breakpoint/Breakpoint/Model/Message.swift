//
//  Message.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 29/10/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import Foundation

class Message {
    // Variables
    private var _content: String
    private var _senderID: String
    
    var content: String {
        return _content
    }
    var senderID: String {
        return _senderID
    }
    
    // Functions
    init(content: String, senderID: String) {
        self._content = content
        self._senderID = senderID
    }
}
