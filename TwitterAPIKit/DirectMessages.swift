//
//  DirectMessages.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/05.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

public protocol MultipleDirectMessagesResponseType {
    func directMessagesFromObject(AnyObject, NSHTTPURLResponse) -> [DirectMessage]?
}

public protocol SingleDirectMessageResponseType {
    func directMessageFromObject(AnyObject, NSHTTPURLResponse) -> DirectMessage?
}

public extension MultipleDirectMessagesResponseType {
    public func directMessagesFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> [DirectMessage]? {
        guard let array = object as? Array<[String: AnyObject]> else {
            return nil
        }
        
        var messages: [DirectMessage] = []
        for element in array {
            guard let dm = DirectMessage(dictionary: element) else {
                return nil
            }
            messages.append(dm)
        }
        
        return messages
    }
}

public extension SingleDirectMessageResponseType {
    public func directMessageFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> DirectMessage? {
        guard let
            dictionary = object as? [String: AnyObject],
            dm = DirectMessage(dictionary: dictionary) else {
                
                return nil
        }
        
        return dm
    }
}

public protocol DirectMessagesGetRequest: Request {}
public protocol DirectMessagesPostRequest: Request {}

public extension DirectMessagesGetRequest {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1")!
    }
    public var requestBodyBuilder: RequestBodyBuilder {
        return .JSON(writingOptions: .PrettyPrinted)
    }
    public var responseBodyParser: ResponseBodyParser {
        return .JSON(readingOptions: .AllowFragments)
    }
}

public extension DirectMessagesPostRequest {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1")!
    }
    public var requestBodyBuilder: RequestBodyBuilder {
        return .URL(encoding: NSUTF8StringEncoding)
    }
    public var responseBodyParser: ResponseBodyParser {
        return .JSON(readingOptions: .AllowFragments)
    }
}

public class TwitterDirectMessages: API {}

public extension TwitterDirectMessages {
    
    ///
    /// https://dev.twitter.com/rest/reference/get/direct_messages/sent
    ///
    public struct Sent: DirectMessagesGetRequest, MultipleDirectMessagesResponseType {
        public typealias Response = [DirectMessage]
        
        public let client: OAuthAPIClient
        
        public var method: APIKit.HTTPMethod {
            return .GET
        }
        
        public var path: String {
            return "/direct_messages/sent.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: [String: AnyObject] {
            return queryStringsFromParameters(_parameters)
        }
        
        public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authorizationHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            sinceIDStr: String? = nil,
            maxIDStr: String? = nil,
            count: Int = 50,
            page: Int? = nil,
            includeEntities: Bool = false){
                
                self.client = client
                self._parameters = [
                    "since_id": sinceIDStr,
                    "max_id": maxIDStr,
                    "count": count,
                    "page": page,
                    "include_entities": includeEntities
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Sent.Response? {
            return self.directMessagesFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/get/direct_messages/show
    ///
    public struct Show: DirectMessagesGetRequest, MultipleDirectMessagesResponseType {
        public typealias Response = [DirectMessage]
        
        public let client: OAuthAPIClient
        
        public var method: APIKit.HTTPMethod {
            return .GET
        }
        
        public var path: String {
            return "/direct_messages/show.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: [String: AnyObject] {
            return queryStringsFromParameters(_parameters)
        }
        
        public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authorizationHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            idStr: String){
                
                self.client = client
                self._parameters = ["id": idStr]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Show.Response? {
            return self.directMessagesFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/get/direct_messages
    ///
    public struct Received: DirectMessagesGetRequest, MultipleDirectMessagesResponseType {
        public typealias Response = [DirectMessage]
        
        public let client: OAuthAPIClient
        
        public var method: APIKit.HTTPMethod {
            return .GET
        }
        
        public var path: String {
            return "/direct_messages.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: [String: AnyObject] {
            return queryStringsFromParameters(_parameters)
        }
        
        public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authorizationHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            sinceIDStr: String? = nil,
            maxIDStr: String? = nil,
            count: Int = 50,
            includeEntities: Bool = false,
            skipStatus: Bool = true){
                
                self.client = client
                self._parameters = [
                    "since_id": sinceIDStr,
                    "max_id": maxIDStr,
                    "count": count,
                    "include_entities": includeEntities,
                    "skip_status": skipStatus
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Received.Response? {
            return self.directMessagesFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/post/direct_messages/destroy
    ///
    public struct Destroy: DirectMessagesPostRequest, SingleDirectMessageResponseType {
        public typealias Response = DirectMessage
        
        public let client: OAuthAPIClient
        
        public var method: APIKit.HTTPMethod {
            return .POST
        }
        
        public var path: String {
            return "/direct_messages/destroy.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: [String: AnyObject] {
            return queryStringsFromParameters(_parameters)
        }
        
        public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authorizationHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            idStr: String,
            includeEntities: Bool = false){
                
                self.client = client
                self._parameters = [
                    "id": idStr,
                    "include_entities": includeEntities
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Destroy.Response? {
            return self.directMessageFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/post/direct_messages/new
    ///
    public struct New: DirectMessagesPostRequest, SingleDirectMessageResponseType {
        public typealias Response = DirectMessage
        
        public let client: OAuthAPIClient
        
        public var method: APIKit.HTTPMethod {
            return .POST
        }
        
        public var path: String {
            return "/direct_messages/new.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: [String: AnyObject] {
            return queryStringsFromParameters(_parameters)
        }
        
        public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authorizationHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            user: User,
            text: String){
                
                self.client = client
                self._parameters = [
                    user.key: user.obj,
                    "text": text
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> New.Response? {
            return self.directMessageFromObject(object, URLResponse)
        }
    }
}


// MARK: - Models

public struct DirectMessage {
    let createdAt: String
    
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
    let entities: Entities?
    let id: Int
    let idStr: String
    
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
    let recipient: Account
    
    let recipientID: Int
    let recipientScreenName: String
    let sender: Account
    let senderID: Int
    let senderScreenName: String
    let text: String
    
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


