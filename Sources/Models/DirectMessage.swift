//
//  DirectMessage.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/06.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

public struct DirectMessage {
    public let createdAt: String
    
    public struct Entities {
        let hashtags: [String]
        let urls: [String]
        let userMentions: [String]
        
        public init?(dictionary: [String: AnyObject]){
            guard let
                hashtags = dictionary["hashtags"] as? [String],
                urls = dictionary["urls"] as? [String],
                userMentions = dictionary["user_mentions"] as? [String] else {
                    
                    return nil
            }
            
            self.hashtags = hashtags
            self.urls = urls
            self.userMentions = userMentions
        }
    }
    public let entities: Entities?
    public let id: Int
    public let idStr: String
    
    public struct Account {
        public let contributorsEnabled: Bool
        public let createdAt: String
        public let defaultProfile: Bool
        public let defaultProfileImage: Bool
        public let description: String
        public let favouritesCount: Int
        public let followRequestSent: Bool
        public let followersCount: Int
        public let following: Bool
        public let friendsCount: Int
        public let geoEnabled: Bool
        public let id: Int
        public let idStr: String
        public let isTranslator: Bool
        public let lang: String
        public let listedCount: Int
        public let location: String
        public let name: String
        public let notifications: Bool
        public let profileBackgroundColor: String
        public let profileBackgroundImageUrl: String
        public let profileBackgroundImageUrlHttps: String
        public let profileBackgroundTile: Bool
        public let profileImageUrl: String
        public let profileImageUrlHttps: String
        public let profileLinkColor: String
        public let profileSidebarBorderColor: String
        public let profileSidebarFillColor: String
        public let profileTextColor: String
        public let profileUseBackgroundImage: Bool
        public let protected: Bool
        public let screenName: String
        public let statusesCount: Int
        public let timeZone: String
        public let url: String
        public let utcOffset: Int
        public let verified: Bool
        
        public init?(dictionary: [String: AnyObject]){
            guard let
                contributorsEnabled = dictionary["contributors_enabled"] as? Bool,
                createdAt = dictionary["created_at"] as? String,
                defaultProfile = dictionary["default_profile"] as? Bool,
                defaultProfileImage = dictionary["default_profile_image"] as? Bool,
                description = dictionary["description"] as? String,
                favouritesCount = dictionary["favourites_count"] as? Int,
                followRequestSent = dictionary["follow_request_sent"] as? Bool,
                followersCount = dictionary["followers_count"] as? Int,
                following = dictionary["following"] as? Bool,
                friendsCount = dictionary["friends_count"] as? Int,
                geoEnabled = dictionary["geo_enabled"] as? Bool,
                id = dictionary["id"] as? Int,
                idStr = dictionary["id_str"] as? String,
                isTranslator = dictionary["is_translator"] as? Bool,
                lang = dictionary["lang"] as? String,
                listedCount = dictionary["listed_count"] as? Int,
                location = dictionary["location"] as? String,
                name = dictionary["name"] as? String,
                notifications = dictionary["notifications"] as? Bool,
                profileBackgroundColor = dictionary["profile_background_color"] as? String,
                profileBackgroundImageUrl = dictionary["profile_background_image_url"] as? String,
                profileBackgroundImageUrlHttps = dictionary["profile_background_image_url_https"] as? String,
                profileBackgroundTile = dictionary["profile_background_tile"] as? Bool,
                profileImageUrl = dictionary["profile_image_url"] as? String,
                profileImageUrlHttps = dictionary["profile_image_url_https"] as? String,
                profileLinkColor = dictionary["profile_link_color"] as? String,
                profileSidebarBorderColor = dictionary["profile_sidebar_border_color"] as? String,
                profileSidebarFillColor = dictionary["profile_sidebar_fill_color"] as? String,
                profileTextColor = dictionary["profile_text_color"] as? String,
                profileUseBackgroundImage = dictionary["profile_use_background_image"] as? Bool,
                protected = dictionary["protected"] as? Bool,
                screenName = dictionary["screen_name"] as? String,
                statusesCount = dictionary["statuses_count"] as? Int,
                timeZone = dictionary["time_zone"] as? String,
                url = dictionary["url"] as? String,
                utcOffset = dictionary["utc_offset"] as? Int,
                verified = dictionary["verifier"] as? Bool else {
                    
                    return nil
            }
            
            self.contributorsEnabled = contributorsEnabled
            self.createdAt = createdAt
            self.defaultProfile = defaultProfile
            self.defaultProfileImage = defaultProfileImage
            self.description = description
            self.favouritesCount = favouritesCount
            self.followRequestSent = followRequestSent
            self.followersCount = followersCount
            self.following = following
            self.friendsCount = friendsCount
            self.geoEnabled = geoEnabled
            self.id = id
            self.idStr = idStr
            self.isTranslator = isTranslator
            self.lang = lang
            self.listedCount = listedCount
            self.location = location
            self.name = name
            self.notifications = notifications
            self.profileBackgroundColor = profileBackgroundColor
            self.profileBackgroundImageUrl = profileBackgroundImageUrl
            self.profileBackgroundImageUrlHttps = profileBackgroundImageUrlHttps
            self.profileBackgroundTile = profileBackgroundTile
            self.profileImageUrl = profileImageUrl
            self.profileImageUrlHttps = profileImageUrlHttps
            self.profileLinkColor = profileLinkColor
            self.profileSidebarBorderColor = profileSidebarBorderColor
            self.profileSidebarFillColor = profileSidebarFillColor
            self.profileTextColor = profileTextColor
            self.profileUseBackgroundImage = profileUseBackgroundImage
            self.protected = protected
            self.screenName = screenName
            self.statusesCount = statusesCount
            self.timeZone = timeZone
            self.url = url
            self.utcOffset = utcOffset
            self.verified = verified
        }
    }
    public let recipient: Account
    
    public let recipientID: Int
    public let recipientScreenName: String
    public let sender: Account
    public let senderID: Int
    public let senderScreenName: String
    public let text: String
    
    public init?(dictionary: [String: AnyObject]){
        guard let
            createdAt = dictionary["created_at"] as? String,
            _entities = dictionary["entities"] as? [String: AnyObject],
            id = dictionary["id"] as? Int,
            idStr = dictionary["id_str"] as? String,
            _recipient = dictionary["recipient"] as? [String: AnyObject],
            recipientID = dictionary["recipient_id"] as? Int,
            recipientScreenName = dictionary["recipient_screen_name"] as? String,
            _sender = dictionary["sender"] as? [String: AnyObject],
            senderID = dictionary["sender_id"] as? Int,
            senderScreenName = dictionary["sender_screen_name"] as? String,
            text = dictionary["text"] as? String else {
                
                return nil
        }
        
        guard let
            entities = Entities(dictionary: _entities),
            sender = Account(dictionary: _sender),
            recipient = Account(dictionary: _recipient) else {
                
                return nil
        }
        
        self.createdAt = createdAt
        self.entities = entities
        self.id = id
        self.idStr = idStr
        self.recipient = recipient
        self.recipientID = recipientID
        self.recipientScreenName = recipientScreenName
        self.sender = sender
        self.senderID = senderID
        self.senderScreenName = senderScreenName
        self.text = text
    }
}
