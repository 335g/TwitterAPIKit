//
//  UserIDs.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/06.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

public struct UserIDs {
    public let ids: [Int]?
    public let idStrs: [String]?
    public let nextCursor: Int
    public let nextCursorStr: String
    public let previousCursor: Int
    public let previousCursorStr: String
    
    public init?(dictionary: [String: AnyObject]){
        guard let
            nextCursor = dictionary["next_cursor"] as? Int,
            nextCursorStr = dictionary["next_cursor_str"] as? String,
            previousCursor = dictionary["previous_cursor"] as? Int,
            previousCursorStr = dictionary["previous_cursor_str"] as? String else {
                
                return nil
        }
        
        self.ids = dictionary["ids"] as? [Int]
        self.idStrs = dictionary["ids"] as? [String]
        self.nextCursor = nextCursor
        self.nextCursorStr = nextCursorStr
        self.previousCursor = previousCursor
        self.previousCursorStr = previousCursorStr
    }
}