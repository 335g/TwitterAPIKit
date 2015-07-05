//
//  OAuth.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/06/20.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

extension Twitter {
    public class OAuth {
        
        ///
        /// MARK: - Methods
        ///
        public class Post: APIKit.API {
            public override class var baseURL: NSURL {
                return NSURL(string: "https://api.twitter.com/oauth")!
            }
            public override class var requestBodyBuilder: RequestBodyBuilder {
                return .URL(encoding: NSUTF8StringEncoding)
            }
            public override class var responseBodyParser: ResponseBodyParser {
                return .URL(encoding: NSUTF8StringEncoding)
            }
        }
        
        /// 
        /// Other
        ///
        public class func authorizeURL(requestToken: String) -> NSURL {
            return NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=" + requestToken)!
        }
        
        ///
        /// MARK: APIs
        ///
        
        ///
        /// https://dev.twitter.com/oauth/reference/post/oauth/request_token
        ///
        public class RequestToken: APIKit.Request {
            public typealias Response = Dictionary<String, String>
            public typealias Method = Twitter.OAuth.Post
            
            private let client: OAuthClient
            private let callback: String
            
            public init(_ client: OAuthClient, callback: String) {
                self.client = client
                self.callback = callback
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                
                let lastPath = "/request_token"
                let fullPathStr = Post.baseURL.absoluteString + lastPath
                let url = NSURL(string: fullPathStr)
                
                var queryParams: [String: String] = [:]
                queryParams["oauth_callback"] = self.callback
                
                let authorizationHeader: String = client.authorizationHeader(.POST, url!, queryParams, isUpload: false)
                
                var request = Post.URLRequest(
                    method: .POST,
                    path: lastPath,
                    parameters: queryParams,
                    requestBodyBuilder: Post.requestBodyBuilder
                )
                request?.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
                
                return request
            }
        }
        
        ///
        /// https://dev.twitter.com/oauth/reference/post/oauth/access_token
        ///
        public class AccessToken: APIKit.Request {
            public typealias Response = Dictionary<String, String>
            public typealias Method = Twitter.OAuth.Post
            
            private let client: OAuthClient
            
            public init(_ client: OAuthClient) {
                self.client = client
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                
                let lastPath = "/access_token"
                let fullPathStr = Post.baseURL.absoluteString + lastPath
                let url = NSURL(string: fullPathStr)
                
                var queryParams: [String: String] = [:]
                if let accessToken = self.client.accessToken {
                    if let verifier = accessToken.verifier {
                        queryParams["oauth_verifier"] = verifier
                    }
                    queryParams["oauth_token"] = accessToken.key
                }
                
                let authorizationHeader = client.authorizationHeader(.POST, url!, queryParams, isUpload: false)
                var request = Post.URLRequest(
                    method: .POST,
                    path: lastPath,
                    parameters: queryParams,
                    requestBodyBuilder: Post.requestBodyBuilder
                )
                request?.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
                
                return request
            }
        }
    }
}