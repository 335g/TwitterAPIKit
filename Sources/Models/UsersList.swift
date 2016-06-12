//
//  UsersList.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/06.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

public struct UsersList {
    public let users: [Users]
    public let nextCursor: Int
    public let nextCursorStr: String
    public let previousCursor: Int
    public let previousCursorStr: String
    
    public init?(dictionary: [String: AnyObject]){
        guard let
            _users = dictionary["users"] as? Array<[String: AnyObject]>,
            nextCursor = dictionary["next_cursor"] as? Int,
            nextCursorStr = dictionary["next_cursor_str"] as? String,
            previousCursor = dictionary["previous_cursor"] as? Int,
            previousCursorStr = dictionary["previous_cursor_str"] as? String else {
                
                return nil
        }
        
        var users: [Users] = []
        for _user in _users {
            guard let user = Users(dictionary: _user) else {
                return nil
            }
            
            users.append(user)
        }
        
        self.users = users
        self.nextCursor = nextCursor
        self.nextCursorStr = nextCursorStr
        self.previousCursor = previousCursor
        self.previousCursorStr = previousCursorStr
    }
}