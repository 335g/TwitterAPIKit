//
//  User.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/04.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

//
// MARK: - Users
//
// https://dev.twitter.com/overview/api/users
//
//
public struct Users {
    
    public let contributorsEnabled: Bool?
    public let createdAt: String?
    public let defaultProfile: Bool?
    public let defaultProfileImage: Bool?
    public let description: String?
    public let entities: Entities?
    public let favouritesCount: Int?
    public let followRequestSent: Bool?
    public let followersCount: Int?
    public let following: Bool?
    public let friendsCount: Int?
    public let geoEnabled: Bool?
    public let id: Int
    public let idStr: String
    public let isTranslator: Bool?
    public let lang: String?
    public let listedCount: Int?
    public let location: String?
    public let name: String?
    public let notifications: Bool?
    public let profileBackgroundColor: String?
    public let profileBackgroundImageUrl: String?
    public let profileBackgroundImageUrlHttps: String?
    public let profileBackgroundTile: Bool?
    public let profileBannerUrl: String?
    public let profileImageUrl: String?
    public let profileImageUrlHttps: String?
    public let profileLinkColor: String?
    public let profileSidebarBorderColor: String?
    public let profileSidebarFillColor: String?
    public let profileTextColor: String?
    public let profileUseBackgroundImage: Bool?
    public let protected: Bool?
    public let screenName: String?
    public let showAllInlineMedia: Bool?
    public let status: Tweets?
    public let statusesCount: Int?
    public let timeZone: String?
    public let url: String?
    public let utcOffset: Int?
    public let verified: Bool?
    public let withheldInCountries: String?
    public let withheldScope: String?
    
    public init?(dictionary: [String: AnyObject]){
        guard let
            id = dictionary["id"] as? Int,
            idStr = dictionary["id_str"] as? String else {
                
                return nil
        }
        
        self.contributorsEnabled = dictionary["contributors_enabled"] as? Bool
        self.createdAt = dictionary["created_at"] as? String
        self.defaultProfile = dictionary["default_profile"] as? Bool
        self.defaultProfileImage = dictionary["default_profile_image"] as? Bool
        self.description = dictionary["description"] as? String
        
        if let entities = dictionary["entities"] as? [String: AnyObject] {
            self.entities = Entities(dictionary: entities)
        }else {
            self.entities = nil
        }
        
        self.favouritesCount = dictionary["favourites_count"] as? Int
        self.followRequestSent = dictionary["follow_request_sent"] as? Bool
        self.followersCount = dictionary["followers_count"] as? Int
        self.following = dictionary["following"] as? Bool
        self.friendsCount = dictionary["friends_count"] as? Int
        self.geoEnabled = dictionary["geo_enabled"] as? Bool
        self.id = id
        self.idStr = idStr
        self.isTranslator = dictionary["is_translator"] as? Bool
        self.lang = dictionary["lang"] as? String
        self.listedCount = dictionary["listed_count"] as? Int
        self.location = dictionary["location"] as? String
        self.name = dictionary["name"] as? String
        self.notifications = dictionary["notifications"] as? Bool
        self.profileBackgroundColor = dictionary["profile_background_color"] as? String
        self.profileBackgroundImageUrl = dictionary["profile_background_image_url"] as? String
        self.profileBackgroundImageUrlHttps = dictionary["profile_background_image_url_https"] as? String
        self.profileBackgroundTile = dictionary["profile_background_tile"] as? Bool
        self.profileBannerUrl = dictionary["profile_banner_url"] as? String
        self.profileImageUrl = dictionary["profile_image_url"] as? String
        self.profileImageUrlHttps = dictionary["profile_image_url_https"] as? String
        self.profileLinkColor = dictionary["profile_link_color"] as? String
        self.profileSidebarBorderColor = dictionary["profile_sidebar_border_color"] as? String
        self.profileSidebarFillColor = dictionary["profile_sidebar_fill_color"] as? String
        self.profileTextColor = dictionary["profile_text_color"] as? String
        self.profileUseBackgroundImage = dictionary["profile_use_background_image"] as? Bool
        self.protected = dictionary["protected"] as? Bool
        self.screenName = dictionary["screen_name"] as? String
        self.showAllInlineMedia = dictionary["show_all_inline_media"] as? Bool
        
        if let status = dictionary["status"] as? [String: AnyObject] {
            self.status = Tweets(dictionary: status)
        }else {
            self.status = nil
        }
        
        self.statusesCount = dictionary["statuses_count"] as? Int
        self.timeZone = dictionary["time_zone"] as? String
        self.url = dictionary["url"] as? String
        self.utcOffset = dictionary["utc_offset"] as? Int
        self.verified = dictionary["verified"] as? Bool
        self.withheldInCountries = dictionary["withheld_in_countries"] as? String
        self.withheldScope = dictionary["withheld_scope"] as? String
    }
}
