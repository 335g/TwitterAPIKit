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
public enum Tweets {
    
    ///
    /// (Own, Quoted)
    ///
    case Original((UserInfo, TweetsInfo), (UserInfo, TweetsInfo)?)
    
    ///
    /// (Own, Retweeted)
    ///
    case Retweet((UserInfo, TweetsInfo), (UserInfo, TweetsInfo))
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            ownTweet = TweetsInfo(dictionary: dictionary),
            ownUser = UserInfo(dictionary: dictionary["user"] as? [String: AnyObject]) else {
                
                return nil
        }
        
        if let
            _retweetedInfo = dictionary["retweeted_status"] as? [String: AnyObject],
            retweetedUser = UserInfo(dictionary: _retweetedInfo["user"] as? [String: AnyObject]),
            retweetedTweet = TweetsInfo(dictionary: _retweetedInfo) {
            
                self = Retweet((ownUser, ownTweet), (retweetedUser, retweetedTweet))
            
        }else {
            if let
                quotedInfo = dictionary["quoted_status"] as? [String: AnyObject],
                quotedTweet = TweetsInfo(dictionary: quotedInfo),
                quotedUser = UserInfo(dictionary: quotedInfo["user"] as? [String: AnyObject]) {
                    
                    self = .Original((ownUser, ownTweet), (quotedUser, quotedTweet))
            }else {
                self = .Original((ownUser, ownTweet), nil)
            }
        }
    }
}

extension Tweets: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .Original((ownTweetUserInfo, ownTweetInfo), quotedInfo):
            var str = "\n"
            str += "  [.Original]\n"
            str += "{ user: "
            str += ownTweetUserInfo.description
            str += " },\n"
            str += "{ tweet: "
            str += ownTweetInfo.description
            str += " }"
            if let quotedInfo = quotedInfo {
                switch quotedInfo {
                case let (quotedUser, quotedTweet):
                    str += ",\n{ user(quoted): "
                    str += quotedUser.description
                    str += ",\n{ tweet(quoted): "
                    str += quotedTweet.description
                    str += " }"
                }
            }
            str += "\n"
            return str
            
        case let .Retweet((ownTweetUserInfo, ownTweetInfo), (retweetedUser, retweetedTweet)):
            var str = "\n"
            str += "  [.Retweet]\n"
            str += "{ user: "
            str += ownTweetUserInfo.description
            str += " },\n"
            str += "{ tweet: "
            str += ownTweetInfo.description
            str += " },\n"
            str += "{ user(retweeted): "
            str += retweetedUser.description
            str += " },\n"
            str += "{ tweet(retweeted): "
            str += retweetedTweet.description
            str += " }\n"
            return str
        }
    }
}

public struct TweetsInfo {
    
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
    //public let quotedStatus: Tweets?
    public let retweetCount: Int
    public let retweeted: Bool
    //public let retweetedStatus: Box<Tweets?>
    public let scopes: Scopes?
    public let source: String
    public let text: String
    public let truncated: Bool
    public let withheldCopyright: Bool?
    public let withheldInCountries: [String]?
    public let withheldScope: String?
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
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
            truncated           = dictionary["truncated"]       as? Bool else {
                
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
        
        self.coordinates = Coordinates(dictionary: dictionary["coordinates"] as? [String: AnyObject])
        self.createdAt = createdAt
        self.currentUserRetweet = Retweet(dictionary: dictionary["current_user_retweet"] as? [String: AnyObject])
        self.entities = Entities(dictionary: dictionary["entities"] as? [String: AnyObject])
        self.favoriteCount = favoriteCount
        self.favorited = favorited
        self.geo = dictionary["geo"] as? String
        self.id = id
        self.idStr = idStr
        self.inReplyToScreenName = dictionary["in_reply_to_screen_name"] as? String
        self.inReplyToStatusId = dictionary["in_reply_to_status_id"] as? Int
        self.inReplyToStatusIdStr = dictionary["in_reply_to_status_id_str"] as? String
        self.inReplyToUserId = dictionary["in_reply_to_user_id"] as? Int
        self.inReplyToUserIdStr = dictionary["in_reply_to_user_id_str"] as? String
        self.lang = lang
        self.place = Places(dictionary: dictionary["place"] as? [String: AnyObject])
        self.possiblySensitive = dictionary["possibly_sensitive"] as? Bool
        self.quotedStatusId = dictionary["quoted_status_id"] as? Int
        self.quotedStatusIdStr = dictionary["quoted_status_id_str"] as? String
        self.retweetCount = retweetCount
        self.retweeted = retweeted
        self.scopes = Scopes(dictionary: dictionary["scopes"] as? [String: AnyObject])
        self.source = source
        self.text = text
        self.truncated = truncated
        self.withheldCopyright = dictionary["withheld_copyright"] as? Bool
        self.withheldInCountries = dictionary["withheld_in_countries"] as? [String]
        self.withheldScope = dictionary["withheld_scope"] as? String
    }
}

extension TweetsInfo: CustomStringConvertible {
    public var description: String {
        return "TweetsInfo: { id: " + String(self.id) + ", id_str: " + self.idStr + "}"
    }
}

// MARK: Contributors

public struct Contributors {
    let id: Int
    let idStr: String
    let screenName: String
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
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
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        
        guard let dictionary = _dictionary else {
            return nil
        }
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
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
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
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        self.follwers = dictionary["followers"] as? Bool
    }
}