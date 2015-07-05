//
//  Statuses.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/06/20.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

extension Twitter {
    public class Statuses {
        
        ///
        /// MARK: - Methods
        ///
        public class Get: APIKit.API {
            public override class var baseURL: NSURL {
                return NSURL(string: "https://api.twitter.com/1.1/statuses")!
            }
            public override class var requestBodyBuilder: RequestBodyBuilder {
                return .JSON(writingOptions: nil)
            }
            public override class var responseBodyParser: ResponseBodyParser {
                return .JSON(readingOptions: nil)
            }
        }
        
        public class Post: APIKit.API {
            public override class var baseURL: NSURL {
                return NSURL(string: "https://api.twitter.com/1.1/statuses")!
            }
            public override class var requestBodyBuilder: RequestBodyBuilder {
                return .URL(encoding: NSUTF8StringEncoding)
            }
            public override class var responseBodyParser: ResponseBodyParser {
                return .JSON(readingOptions: nil)
            }
        }
        
        // MARK: Property
        
        var client: OAuthClient!
        var parameters: [String: AnyObject?]!
        
        // MARK: Initializer
        
        private init(_ client: OAuthClient, parameters: [String: AnyObject?]){
            self.client = client
            self.parameters = parameters
        }
        
        // MARK: Common Function
        
        func getURLRequest(lastPath: String, method: APIKit.Method) -> NSURLRequest? {
            
            var baseURL: NSURL!
            switch method {
            case .GET:
                baseURL = Get.baseURL
            case .POST:
                baseURL = Post.baseURL
            default:
                fatalError("must GET or POST")
            }
            
            let fullPathStr = baseURL.absoluteString + lastPath
            let url = NSURL(string: fullPathStr)
            
            var queryParams = queryStringsFromParameters(parameters)
            
            var request: NSMutableURLRequest?
            switch method {
            case .GET:
                request = Get.URLRequest(method: .GET, path: lastPath, parameters: queryParams, requestBodyBuilder: Get.requestBodyBuilder)
            case .POST:
                request = Post.URLRequest(method: .POST, path: lastPath, parameters: queryParams, requestBodyBuilder: Post.requestBodyBuilder)
            default:
                ()
            }
            
            var header: String
            switch method {
            case .GET:
                header = client.authorizationHeader(.GET, url!, queryParams, isUpload: false)
                request?.setValue(header, forHTTPHeaderField: "Authorization")
                
            case .POST:
                header = client.authorizationHeader(.POST, url!, queryParams, isUpload: false)
                request?.setValue(header, forHTTPHeaderField: "Authorization")
                
            default:
                ()
            }
            
            return request
        }
        
        ///
        /// MARK: APIs
        ///
        
        ///
        /// https://dev.twitter.com/rest/reference/get/statuses/mentions_timeline
        ///
        public class MensionsTimeLine: Statuses, APIKit.Request {
            public typealias Response = [Dictionary<String, AnyObject>]
            public typealias Method = Twitter.Statuses.Get
            
            public init(
                _ client: OAuthClient,
                count: Int,
                sinceID: Int64? = nil,
                maxID: Int64? = nil,
                trimUser: Bool = true,
                contributorDetails: Bool = false,
                includeEntities: Bool = false)
            {
                super.init(client, parameters: [
                    "count": count,
                    "since_id": sinceID as? AnyObject,
                    "max_id": maxID as? AnyObject,
                    "trim_user": trimUser,
                    "contributor_details": contributorDetails,
                    "include_entities": includeEntities
                    ]
                )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/mentions_timeline.json", method: .GET)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/get/statuses/user_timeline
        ///
        public class UserTimeLine: Statuses, APIKit.Request {
            public typealias Response = [Dictionary<String, AnyObject>]
            public typealias Method = Twitter.Statuses.Get
            
            public init(
                _ client: OAuthClient,
                user: User,
                count: Int,
                sinceID: Int64? = nil,
                maxID: Int64? = nil,
                trimUser: Bool = true,
                excludeReplies: Bool = true,
                contributorDetails: Bool = false,
                includeRts: Bool = true
                ){
                    super.init(client, parameters: [
                        "user": user as? AnyObject,
                        "count": count,
                        "since_id": sinceID as? AnyObject,
                        "max_id": maxID as? AnyObject,
                        "trim_user": trimUser,
                        "exclude_replies": excludeReplies,
                        "include_rts": includeRts
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/user_timeline.json", method: .GET)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/get/statuses/home_timeline
        ///
        public class HomeTimeLine: Statuses, APIKit.Request {
            public typealias Response = [Dictionary<String, AnyObject>]
            public typealias Method = Twitter.Statuses.Get
            
            public init(
                _ client: OAuthClient,
                count: Int,
                sinceID: Int64? = nil,
                maxID: Int64? = nil,
                trimUser: Bool = true,
                excludeReplies: Bool = true,
                contributorDetails: Bool = false,
                includeEntities: Bool = false
                ){
                    super.init(client, parameters: [
                        "count": count,
                        "since_id": sinceID as? AnyObject,
                        "max_id": maxID as? AnyObject,
                        "trim_user": trimUser,
                        "exclude_replies": excludeReplies,
                        "contributor_details": contributorDetails,
                        "include_entities": includeEntities
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/home_timeline.json", method: .GET)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/get/statuses/retweets_of_me
        ///
        public class RetweetsOfMe: Statuses, APIKit.Request {
            public typealias Response = [Dictionary<String, AnyObject>]
            public typealias Method = Twitter.Statuses.Get
            
            public init(
                _ client: OAuthClient,
                count: Int,
                sinceID: Int64? = nil,
                maxID: Int64? = nil,
                trimUser: Bool = true,
                includeEntities: Bool = false,
                includeUserEntities: Bool = false
                ){
                    var aCount = count > 100 ? 100 : count
                    super.init(client, parameters: [
                        "count": count,
                        "since_id": sinceID as? AnyObject,
                        "max_id": maxID as? AnyObject,
                        "trim_user": trimUser,
                        "include_entities": includeEntities,
                        "include_user_entities": includeUserEntities
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/retweets_of_me.json", method: .GET)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/get/statuses/retweets/%3Aid
        ///
        public class Retweets: Statuses, APIKit.Request {
            public typealias Response = Dictionary<String, AnyObject>
            public typealias Method = Twitter.Statuses.Get
            
            private let id: Int64
            
            public init(
                _ client: OAuthClient,
                id: Int64,
                count: Int = 20,
                trimUser: Bool = true
                ){
                    self.id = id
                    super.init(client, parameters: [
                        "id": id as? AnyObject,
                        "count": count,
                        "trim_user": trimUser
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/retweets/" + String(self.id) + ".json", method: .GET)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/get/statuses/show/%3Aid
        ///
        public class Show: Statuses, APIKit.Request {
            public typealias Response = Dictionary<String, AnyObject>
            public typealias Method = Twitter.Statuses.Get
            
            public init(
                _ client: OAuthClient,
                id: Int64,
                trimUser: Bool = true,
                includeMyRetweet: Bool = true,
                includeEntities: Bool = false
                ){
                    super.init(client, parameters: [
                        "id": id as? AnyObject,
                        "trim_user": trimUser,
                        "include_my_retweet": includeMyRetweet,
                        "include_entities": includeEntities
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/show.json", method: .GET)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/post/statuses/destroy/%3Aid
        ///
        public class Destroy: Statuses, APIKit.Request {
            public typealias Response = Dictionary<String, AnyObject>
            public typealias Method = Twitter.Statuses.Post
            
            private let id: Int64
            
            public init(
                _ client: OAuthClient,
                id: Int64,
                trimUser: Bool = true
                ){
                    self.id = id
                    super.init(client, parameters: [
                        "id": id as? AnyObject,
                        "trim_user": trimUser
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/destroy/" + String(self.id) + ".json", method: .POST)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/post/statuses/update
        ///
        public class Update: Statuses, APIKit.Request {
            public typealias Response = Dictionary<String, AnyObject>
            public typealias Method = Twitter.Statuses.Post
            
            public init(
                _ client: OAuthClient,
                status: String,
                inReplyToStatusID: Int64? = nil,
                possiblySensitive: Bool = false,
                lat: Double? = nil,
                long: Double? = nil,
                placeID: String? = nil,
                displayCoordinates: Bool = false,
                trimUser: Bool = true,
                mediaIDs: [String]? = nil
                ){
                    super.init(client, parameters: [
                        "status": status,
                        "in_reply_to_status_id": inReplyToStatusID as? AnyObject,
                        "possibly_sensitive": possiblySensitive,
                        "lat": lat,
                        "long": long,
                        "place_id": placeID,
                        "display_coordinates": displayCoordinates,
                        "trim_user": trimUser,
                        
                        // TODO: media_ids 対応
                        "media_ids": nil
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/update.json", method: .POST)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/post/statuses/retweet/%3Aid
        ///
        public class Retweet: Statuses, APIKit.Request {
            public typealias Response = Dictionary<String, AnyObject>
            public typealias Method = Twitter.Statuses.Post
            
            private let id: Int64
            
            public init(
                _ client: OAuthClient,
                id: Int64,
                trimUser: Bool = true
                ){
                    self.id = id
                    super.init(client, parameters: [
                        "id": id as? AnyObject,
                        "trim_user": trimUser
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/retweet/" + String(self.id) + ".json", method: .POST)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/get/statuses/retweeters/ids
        ///
        public class Retweeters: Statuses, APIKit.Request {
            public typealias Response = Dictionary<String, AnyObject>
            public typealias Method = Twitter.Statuses.Get
            
            public init(
                _ client: OAuthClient,
                id: Int64,
                cursor: Int64 = -1,
                stringifyIds: Bool = true
                ){
                    super.init(client, parameters: [
                        "id": id as? AnyObject,
                        "cursor": cursor as? AnyObject,
                        "stringify_ids": stringifyIds
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/retweeters/ids.json", method: .GET)
            }
        }
        
    }
}