//
//  Group.swift
//  Breakpoint
//
//  Created by Thomas Pickup on 02/11/2017.
//  Copyright © 2017 Thomas Pickup. All rights reserved.
//

import Foundation

class Group {
    // Variables
    // Private
    private var _groupTitle: String
    private var _groupDesc: String
    private var _key: String
    private var _memberCount: Int
    private var _members: [String]
    
    // Public
    var title: String {
        return _groupTitle
    }
    
    var description: String {
        return _groupDesc
    }
    
    var key: String {
        return _key
    }
    
    var count: Int {
        return _memberCount
    }
    
    var members: [String] {
        return _members
    }
    
    // Initializer
    init(title: String, description: String, key: String, memberCount: Int, members: [String]) {
        self._groupTitle = title
        self._groupDesc = description
        self._key = key
        self._memberCount = memberCount
        self._members = members
    }
}
