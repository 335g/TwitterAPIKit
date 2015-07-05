//
//  Friends.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/06/20.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

extension Twitter {
    public class Friends {
        
        ///
        /// MARK: - Methods
        ///
        public class Get: APIKit.API {
            public override class var baseURL: NSURL {
                return NSURL(string: "https://api.twitter.com/1.1/friends")!
            }
            public override class var requestBodyBuilder: RequestBodyBuilder {
                return .JSON(writingOptions: nil)
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
            default:
                fatalError("must GET")
            }
            
            let fullPathStr = baseURL.absoluteString + lastPath
            let url = NSURL(string: fullPathStr)
            
            var queryParams = queryStringsFromParameters(parameters)
            
            var request: NSMutableURLRequest?
            switch method {
            case .GET:
                request = Get.URLRequest(method: .GET, path: lastPath, parameters: queryParams, requestBodyBuilder: Get.requestBodyBuilder)
            default:
                ()
            }
            
            var header: String
            switch method {
            case .GET:
                header = client.authorizationHeader(.GET, url!, queryParams, isUpload: false)
                request?.setValue(header, forHTTPHeaderField: "Authorization")
                
            default:
                ()
            }
            
            return request
        }
        
        // MARK: - APIs
        
        ///
        /// https://dev.twitter.com/rest/reference/get/friends/ids
        ///
        public class Ids: Friends, APIKit.Request {
            public typealias Response = Dictionary<String, AnyObject>
            public typealias Method = Twitter.Friends.Get
            
            public init(
                _ client: OAuthClient,
                user: User,
                count: Int = 5000,
                cursor: Int64 = -1,
                stringifyIds: Bool = true){
                    
                    let (key, obj) = userKeyObject(user)
                    let aCount: Int = count > 5000 ? 5000 : count
                    
                    super.init(client, parameters: [
                        key: obj,
                        "cursor": cursor as? AnyObject,
                        "stringify_ids": stringifyIds,
                        "count": aCount
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/ids.json", method: .GET)
            }
        }
        
        ///
        /// https://dev.twitter.com/rest/reference/get/friends/list
        ///
        public class List: Friends, APIKit.Request {
            public typealias Response = Dictionary<String, AnyObject>
            public typealias Method = Twitter.Friends.Get
            
            public init(
                _ client: OAuthClient,
                user: User,
                count: Int = 50,
                cursor: Int64 = -1,
                skipStatus: Bool = true,
                includeUserEntities: Bool = false){
                    
                    let (key, obj) = userKeyObject(user)
                    var aCount: Int = count > 200 ? 200 : count
                    
                    super.init(client, parameters: [
                        key: obj,
                        "count": count,
                        "cursor": cursor as? AnyObject,
                        "skip_status": skipStatus,
                        "include_user_entities": includeUserEntities
                        ]
                    )
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("/list.json", method: .GET)
            }
        }
    }
}