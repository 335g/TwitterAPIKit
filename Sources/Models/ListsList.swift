//
//  ListsList.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/06.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

public struct ListsList {
    public let lists: [Lists]
    public let nextCursor: Int
    public let nextCursorStr: String
    public let previousCursor: Int
    public let previousCursorStr: String
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            _listsList = dictionary["lists"] as? Array<[String: AnyObject]>,
            nextCursor = dictionary["next_cursor"] as? Int,
            nextCursorStr = dictionary["next_cursor_str"] as? String,
            previousCursor = dictionary["previous_cursor"] as? Int,
            previousCursorStr = dictionary["previous_cursor_str"] as? String else {
                
                return nil
        }
        
        var listsList: [Lists] = []
        for _lists in _listsList {
            guard let lists = Lists(dictionary: _lists) else {
                return nil
            }
            listsList.append(lists)
        }
        
        self.lists = listsList
        self.nextCursor = nextCursor
        self.nextCursorStr = nextCursorStr
        self.previousCursor = previousCursor
        self.previousCursorStr = previousCursorStr
    }
}

public struct Lists {
    public let id: Int
    public let idStr: String
    public let name: String
    public let uri: String
    public let subscriberCount: Int
    public let memberCount: Int
    public let mode: String
    public let innerDescription: String // 'description'
    public let slug: String
    public let fullName: String
    public let createdAt: String
    public let following: Bool
    public let user: Users
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            id = dictionary["id"] as? Int,
            idStr = dictionary["id_str"] as? String,
            name = dictionary["name"] as? String,
            uri = dictionary["uri"] as? String,
            subscriberCount = dictionary["subscriber_count"] as? Int,
            memberCount = dictionary["member_count"] as? Int,
            mode = dictionary["mode"] as? String,
            innerDescription = dictionary["description"] as? String,
            slug = dictionary["slug"] as? String,
            fullName = dictionary["full_name"] as? String,
            createdAt = dictionary["created_at"] as? String,
            following = dictionary["following"] as? Bool,
            user = Users(dictionary: dictionary["user"] as? [String: AnyObject]) else {
                
                return nil
        }
        
        self.id = id
        self.idStr = idStr
        self.name = name
        self.uri = uri
        self.subscriberCount = subscriberCount
        self.memberCount = memberCount
        self.mode = mode
        self.innerDescription = innerDescription
        self.slug = slug
        self.fullName = fullName
        self.createdAt = createdAt
        self.following = following
        self.user = user
    }
}