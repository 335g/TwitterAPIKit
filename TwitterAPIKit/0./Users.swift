//
//  Users.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/06/20.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

extension Twitter {
    public class Users {
        
        ///
        /// MARK: - Methods
        ///
        public class Get: APIKit.API {
            public override class var baseURL: NSURL {
                return NSURL(string: "https://api.twitter.com/1.1/users")!
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
                return NSURL(string: "https://api.twitter.com/1.1/users")!
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
        /// https://dev.twitter.com/rest/reference/get/users/lookup
        ///
        public class Lookup: Users, APIKit.Request {
            public typealias Response = [Dictionary<String, AnyObject>]
            public typealias Method = Twitter.Users.Get
            
            public init(
                _ client: OAuthClient,
                users: [User],
                includeEntities: Bool = false){
                    
                    super.init(client, parameters: [
                        "screen_name": ",".join(screenNames(users)),
                        "user_id": ",".join(userIds(users)),
                        "include_entities": includeEntities
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/lookup.json", method: .GET)
                
                // TODO: 複数指定 (","が2回エンコードされてる？ , -> %2c -> %252c)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/get/users/show
        ///
        public class Show: Users, APIKit.Request {
            public typealias Response = Dictionary<String, AnyObject>
            public typealias Method = Twitter.Users.Get
            
            public init(
                _ client: OAuthClient,
                user: User,
                includeEntities: Bool = false){
                    
                    let (key, obj) = userKeyObject(user)
                    
                    super.init(client, parameters: [
                        key: obj,
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
    }
}