//
//  Statuses.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/04.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

public protocol StatusesRequestType: RequestType {}
public protocol StatusesGetRequestType: StatusesRequestType {}
public protocol StatusesPostRequestType: StatusesRequestType {}

public extension StatusesRequestType {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1/statuses")!
    }
}

public extension StatusesGetRequestType {
	public var dataParser: DataParserType {
		return JSONDataParser(readingOptions: .AllowFragments)
	}
	
	public var method: APIKit.HTTPMethod {
		return .GET
	}
}

public extension StatusesPostRequestType {
	public var dataParser: DataParserType {
		return JSONDataParser(readingOptions: .AllowFragments)
	}
	
	public var method: APIKit.HTTPMethod {
		return .POST
	}
}


public enum TwitterStatuses {
    
    ///
    /// https://dev.twitter.com/rest/reference/get/statuses/mentions_timeline
    ///
    public struct MentionsTimeline: StatusesGetRequestType, MultipleTweetsResponseType {
        public typealias Response = [Tweets]
        
        public let client: OAuthAPIClient
		
        public var path: String {
            return "/mentions_timeline.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
        
        public func interceptURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            count: Int,
            sinceIDStr: String? = nil,
            maxIDStr: String? = nil,
            trimUser: Bool = false,
            contributorDetails: Bool = false,
            includeEntities: Bool = false){
                self.client = client
                self._parameters = [
                    "count": count,
                    "since_id": sinceIDStr,
                    "max_id": maxIDStr,
                    "trim_user": trimUser,
                    "contributor_details": contributorDetails,
                    "include_entities": includeEntities
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> MentionsTimeline.Response {
            return try tweetsFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/get/statuses/user_timeline
    ///
    public struct UserTimeline: StatusesGetRequestType, MultipleTweetsResponseType {
        public typealias Response = [Tweets]
        
        public let client: OAuthAPIClient
        
        public var path: String {
            return "/user_timeline.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
        
        public func interceptURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            user: User,
            count: Int,
            sinceIDStr: String? = nil,
            maxIDStr: String? = nil,
            trimUser: Bool = false,
            excludeReplies: Bool = true,
            contributorDetails: Bool = false,
            includeRts: Bool = true){
                
                self.client = client
                self._parameters = [
                    "user": user as? AnyObject,
                    "count": count,
                    "since_id": sinceIDStr,
                    "max_id": maxIDStr,
                    "trim_user": trimUser,
                    "exclude_replies": excludeReplies,
                    "include_rts": includeRts
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> MentionsTimeline.Response {
            return try tweetsFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/get/statuses/home_timeline
    ///
    public struct HomeTimeline: StatusesGetRequestType, MultipleTweetsResponseType {
        public typealias Response = [Tweets]
        
        public let client: OAuthAPIClient
        
        public var path: String {
            return "/home_timeline.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
        
        public func interceptURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            count: Int,
            sinceIDStr: String? = nil,
            maxIDStr: String? = nil,
            trimUser: Bool = false,
            excludeReplies: Bool = true,
            contributorDetails: Bool = false,
            includeEntities: Bool = false){
                
                self.client = client
                self._parameters = [
                    "count": count,
                    "since_id": sinceIDStr,
                    "max_id": maxIDStr,
                    "trim_user": trimUser,
                    "exclude_replies": excludeReplies,
                    "contributor_details": contributorDetails,
                    "include_entities": includeEntities
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> MentionsTimeline.Response {
            return try tweetsFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/get/statuses/retweets_of_me
    ///
    public struct RetweetsOfMe: StatusesGetRequestType, MultipleTweetsResponseType {
        public typealias Response = [Tweets]
        
        public let client: OAuthAPIClient
		
        public var path: String {
            return "/retweets_of_me.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
        
        public func interceptURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            count: Int,
            sinceIDStr: String? = nil,
            maxIDStr: String? = nil,
            trimUser: Bool = true,
            includeEntities: Bool = false,
            includeUserEntities: Bool = false){
                
                self.client = client
                self._parameters = [
                    "count": count,
                    "since_id": sinceIDStr,
                    "max_id": maxIDStr,
                    "trim_user": trimUser,
                    "include_entities": includeEntities,
                    "include_user_entities": includeUserEntities
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> MentionsTimeline.Response {
            return try tweetsFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/get/statuses/retweets/%3Aid
    ///
    public struct Retweets: StatusesGetRequestType, MultipleTweetsResponseType {
        public typealias Response = [Tweets]
        
        public let client: OAuthAPIClient
        public let idStr: String
		
        public var path: String {
            return "/retweets/" + idStr + ".json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
        
        public func interceptURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            idStr: String,
            count: Int = 20,
            trimUser: Bool = true){
                
                self.client = client
                self.idStr = idStr
                self._parameters = [
                    "id": idStr,
                    "count": count,
                    "trim_user": trimUser
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> MentionsTimeline.Response {
            return try tweetsFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/get/statuses/show/%3Aid
    ///
    public struct Show: StatusesGetRequestType, SingleTweetResponseType {
        public typealias Response = Tweets
        
        public let client: OAuthAPIClient
        
        public var path: String {
            return "/show.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
        
        public func interceptURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            idStr: String,
            trimUser: Bool = false,
            includeMyRetweet: Bool = true,
            includeEntities: Bool = false){
                
                self.client = client
                self._parameters = [
                    "id": idStr,
                    "trim_user": trimUser,
                    "include_my_retweet": includeMyRetweet,
                    "include_entities": includeEntities
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Show.Response {
            return try tweetFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/post/statuses/destroy/%3Aid
    ///
    public struct Destroy: StatusesPostRequestType, SingleTweetResponseType {
        public typealias Response = Tweets
        
        public let client: OAuthAPIClient
        public let idStr: String
        
        public var path: String {
            return "/destroy/" + idStr + ".json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
        
        public func interceptURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            idStr: String,
            trimUser: Bool = false){
                
                self.client = client
                self.idStr = idStr
                self._parameters = [
                    "id": idStr,
                    "trim_user": trimUser
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Destroy.Response {
            return try tweetFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/post/statuses/update
    ///
    public struct Update: StatusesPostRequestType, SingleTweetResponseType {
        public typealias Response = Tweets
        
        public let client: OAuthAPIClient
		
        public var path: String {
            return "/update.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
        
        public func interceptURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            status: String,
            inReplyToStatusIDStr: String? = nil,
            possiblySensitive: Bool = false,
            lat: Double? = nil,
            long: Double? = nil,
            placeID: String? = nil,
            displayCoordinates: Bool = false,
            trimUser: Bool = true,
            mediaIDs: [String]? = nil){
                
                self.client = client
                self._parameters = [
                    "status": status,
                    "in_reply_to_status_id": inReplyToStatusIDStr,
                    "possibly_sensitive": possiblySensitive,
                    "lat": lat,
                    "long": long,
                    "place_id": placeID,
                    "display_coordinates": displayCoordinates,
                    "trim_user": trimUser,
                    
                    // TODO: media_ids 対応
                    "media_ids": nil
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Destroy.Response {
            return try tweetFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/post/statuses/retweet/%3Aid
    ///
    public struct Retweet: StatusesPostRequestType, SingleTweetResponseType {
        public typealias Response = Tweets
        
        public let client: OAuthAPIClient
        public let idStr: String
        
        public var path: String {
            return "/retweet/" + idStr + ".json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
        
        public func interceptURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            idStr: String,
            trimUser: Bool = true){
                
                self.client = client
                self.idStr = idStr
                self._parameters = [
                    "id": idStr,
                    "trim_user": trimUser
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Destroy.Response {
            return try tweetFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/get/statuses/retweeters/ids
    ///
    public struct Retweeters: StatusesGetRequestType {
        public typealias Response = RetweetIDs
        
        public let client: OAuthAPIClient
        
        public var path: String {
            return "/retweeters/ids.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
        
        public func interceptURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            idStr: String,
            cursorStr: String = "-1",
            stringifyIds: Bool = true){
                
                self.client = client
                self._parameters = [
                    "id": idStr,
                    "cursor": cursorStr,
                    "stringify_ids": stringifyIds
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Retweeters.Response {
            guard let
                dictionary = object as? [String: AnyObject],
                ids = RetweetIDs(dictionary: dictionary) else {
                    
                    throw DecodeError.Fail
            }
            
            return ids
        }
    }
    
}
