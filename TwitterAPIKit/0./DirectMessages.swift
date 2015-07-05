//
//  DirectMessages.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/06/21.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

extension Twitter {
    public class DirectMessages {
        
        ///
        /// MARK: - Methods
        ///
        public class Get: APIKit.API {
            public override class var baseURL: NSURL {
                return NSURL(string: "https://api.twitter.com/1.1")!
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
                return NSURL(string: "https://api.twitter.com/1.1")!
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
        /// https://dev.twitter.com/rest/reference/get/direct_messages/sent
        ///
        public class Sent: DirectMessages, APIKit.Request {
            public typealias Response = [Dictionary<String, AnyObject>]
            public typealias Method = Twitter.DirectMessages.Get
            public static var maxCount: Int = 200
            
            public init(
                _ client: OAuthClient,
                sinceID: Int64? = nil,
                maxID: Int64? = nil,
                count: Int = 50,
                page: Int? = nil,
                includeEntities: Bool = false
                ){
                    let aCount = count > self.dynamicType.maxCount ? self.dynamicType.maxCount : count
                    super.init(client, parameters: [
                        "since_id": sinceID as? AnyObject,
                        "max_id": maxID as? AnyObject,
                        "count": aCount,
                        "page": page,
                        "include_entities": includeEntities
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/direct_messages/sent.json", method: .GET)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/get/direct_messages/show
        ///
        public class Show: DirectMessages, APIKit.Request {
            public typealias Response = [Dictionary<String, AnyObject>]
            public typealias Method = Twitter.DirectMessages.Get
            
            public init(
                _ client: OAuthClient,
                id: Int64
                ){
                    super.init(client, parameters: ["id": id as? AnyObject])
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/direct_messages/show.json", method: .GET)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/get/direct_messages
        ///
        public class Received: DirectMessages, APIKit.Request {
            public typealias Response = [Dictionary<String, AnyObject>]
            public typealias Method = Twitter.DirectMessages.Get
            public static var maxCount: Int = 200
            
            public init(
                _ client: OAuthClient,
                sinceID: Int64? = nil,
                maxID: Int64? = nil,
                count: Int = 50,
                includeEntities: Bool = false,
                skipStatus: Bool = true
                ){
                    let aCount = count > self.dynamicType.maxCount ? self.dynamicType.maxCount : count
                    super.init(client, parameters: [
                        "since_id": sinceID as? AnyObject,
                        "max_id": maxID as? AnyObject,
                        "count": aCount,
                        "include_entities": includeEntities,
                        "skip_status": skipStatus
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/direct_messages.json", method: .GET)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/post/direct_messages/destroy
        ///
        public class Destroy: DirectMessages, APIKit.Request {
            public typealias Response = Dictionary<String, AnyObject>
            public typealias Method = Twitter.DirectMessages.Post
            public static var maxCount: Int = 200
            
            public init(
                _ client: OAuthClient,
                id: Int64,
                includeEntities: Bool = false
                ){
                    super.init(client, parameters: [
                        "id": id as? AnyObject,
                        "include_entities": includeEntities
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/direct_messages/destroy.json", method: .POST)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/post/direct_messages/new
        ///
        public class New: DirectMessages, APIKit.Request {
            public typealias Response = Dictionary<String, AnyObject>
            public typealias Method = Twitter.DirectMessages.Post
            
            public init(
                _ client: OAuthClient,
                user: User,
                text: String
                ){
                    let (key, obj) = userKeyObject(user)
                    super.init(client, parameters: [
                        key: obj,
                        "text": text
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/direct_messages/new.json", method: .POST)
            }
        }
    }
}