//
//  Tweets.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/05.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

//
// MARK: - Tweets
//
// https://dev.twitter.com/overview/api/tweets
//
//
public struct Tweets {
    
    public let contributors: [Contributors]?
    public let coordinates: Coordinates?
    public let createdAt: String
    public let currentUserRetweet: Retweet?
    public let entities: Entities?
    public let favoriteCount: Int
    public let favorited: Bool
    public let geo: String?     // deprecated
    public let id: Int
    public let idStr: String
    public let inReplyToScreenName: String?
    public let inReplyToStatusId: Int?
    public let inReplyToStatusIdStr: String?
    public let inReplyToUserId: Int?
    public let inReplyToUserIdStr: String?
    public let lang: String
    public let place: Places?
    public let possiblySensitive: Bool?
    public let quotedStatusId: Int?
    public let quotedStatusIdStr: String?
    public let quotedStatus: Tweets?
    public let scopes: Scopes?
    public let retweetCount: Int
    public let retweeted: Bool
    public let retweetedStatus: Tweets?
    public let source: String
    public let text: String
    public let truncated: Bool
    public let user: Users
    public let withheldCopyright: Bool?
    public let withheldInCountries: [String]?
    public let withheldScope: String?
    
    public init?(dictionary: [String: AnyObject]){
        guard let
            createdAt           = dictionary["created_at"]      as? String,
            favoriteCount       = dictionary["favorite_count"]  as? Int,
            favorited           = dictionary["favorited"]       as? Bool,
            id                  = dictionary["id"]              as? Int,
            idStr               = dictionary["id_str"]          as? String,
            lang                = dictionary["lang"]            as? String,
            retweetCount        = dictionary["retweet_count"]   as? Int,
            retweeted           = dictionary["retweeted"]       as? Bool,
            source              = dictionary["source"]          as? String,
            text                = dictionary["text"]            as? String,
            truncated           = dictionary["truncated"]       as? Bool,
            _user               = dictionary["user"]            as? [String: AnyObject] else {
                
                return nil
        }
        
        guard let user = Users(dictionary: _user) else {
            return nil
        }
        
        if let _contributors = dictionary["contributors"] as? Array<[String: AnyObject]> {
            var contributors: [Contributors] = []
            for _contributor in _contributors {
                if let contributor = Contributors(dictionary: _contributor) {
                    contributors.append(contributor)
                }
            }
            self.contributors = contributors
            
        }else {
            self.contributors = nil
        }
        
        if let _coordinates = dictionary["coordinates"] as? [String: AnyObject] {
            self.coordinates = Coordinates(dictionary: _coordinates)
        }else {
            self.coordinates = nil
        }
        
        self.createdAt = createdAt
        
        if let _retweet = dictionary["current_user_retweet"] as? [String: AnyObject] {
            self.currentUserRetweet = Retweet(dictionary: _retweet)
        }else {
            self.currentUserRetweet = nil
        }
        
        if let _entities = dictionary["entities"] as? [String: AnyObject] {
            self.entities = Entities(dictionary: _entities)
        }else {
            self.entities = nil
        }
        
        self.favoriteCount = favoriteCount
        self.favorited = favorited
        self.geo = dictionary["geo"] as? String
        self.id = id
        self.idStr = idStr
        self.inReplyToScreenName = dictionary["in_reply_to_screen_name"] as? String
        
        if let _inReplyToStatusId = dictionary["in_reply_to_status_id"] as? String {
            inReplyToStatusId = Int(_inReplyToStatusId)
        }else {
            inReplyToStatusId = nil
        }
        self.inReplyToStatusIdStr = dictionary["in_reply_to_status_id_str"] as? String
        
        if let _inReplyToUserId = dictionary["in_reply_to_user_id"] as? String {
            inReplyToUserId = Int(_inReplyToUserId)
        }else {
            inReplyToUserId = nil
        }
        self.inReplyToUserIdStr = dictionary["in_reply_to_user_id_str"] as? String
        
        self.lang = lang
        
        if let _place = dictionary["place"] as? [String: AnyObject] {
            self.place = Places(dictionary: _place)
        }else {
            self.place = nil
        }
        
        self.retweetCount = retweetCount
        self.retweeted = retweeted
        self.source = source
        self.text = text
        self.truncated = truncated
        self.user = user
    }
}

// MARK: Contributors

public struct Contributors {
    let id: Int
    let idStr: String
    let screenName: String
    
    public init?(dictionary: [String: AnyObject]){
        guard let
            id = dictionary["id"] as? Int,
            idStr = dictionary["id_str"] as? String,
            screenName = dictionary["screen_name"] as? String else {
                
                return nil
        }
        
        self.id = id
        self.idStr = idStr
        self.screenName = screenName
    }
}

public struct Coordinates {
    let coordinates: [Float]
    let type: String
    
    public init?(dictionary: [String: AnyObject]){
        guard let
            coordinates = dictionary["coordinates"] as? [Float],
            type = dictionary["type"] as? String else {
                
                return nil
        }
        
        self.coordinates = coordinates
        self.type = type
    }
}

public struct Retweet {
    let id :Int
    let idStr: String
    
    public init?(dictionary: [String: AnyObject]){
        guard let
            id = dictionary["id"] as? Int,
            idStr = dictionary["id_str"] as? String else {
        
                return nil
        }
        
        self.id = id
        self.idStr = idStr
    }
}

public struct Scopes {
    let follwers: Bool?
    
    public init?(dictionary: [String: AnyObject]){
        self.follwers = dictionary["followers"] as? Bool
    }
}