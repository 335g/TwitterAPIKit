//
//  OAuth.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/02.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

public protocol OAuthPostRequest: RequestType {}

public extension OAuthPostRequest {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/oauth")!
    }
	
	public var dataParser: DataParserType {
		return JSONDataParser(readingOptions: .AllowFragments)
	}
}

public enum TwitterOAuth {
	
	public static func authorizeURL(requestToken: String) -> NSURL {
		return NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=" + requestToken)!
	}
	
    ///
    /// https://dev.twitter.com/oauth/reference/post/oauth/request_token
    ///
    public struct RequestToken: OAuthPostRequest {
        public typealias Response = RequestTokenResult
        
        public let client: OAuthRequestTokenClient
        public let callback: String
        
        public var method: HTTPMethod {
            return .POST
        }
        
        public var path: String {
            return "/request_token"
        }
        
        public var parameters: [String: AnyObject] {
            return ["oauth_callback": callback]
        }
        
        public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authorizationHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(client: OAuthRequestTokenClient, callback: String){
            self.client = client
            self.callback = callback
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> RequestToken.Response {
            guard
                let dictionary = object as? [String: AnyObject],
                let result = RequestTokenResult(dictionary: dictionary) else {
                    
                    throw DecodeError.Fail
            }
            
            return result
        }
    }
    
    ///
    /// https://dev.twitter.com/oauth/reference/post/oauth/access_token
    ///
    public struct AccessToken: OAuthPostRequest {
        public typealias Response = AccessTokenResult
        public let client: OAuthAccessTokenClient
        public let verifier: String
        
        public var method: HTTPMethod {
            return .POST
        }
        
        public var path: String {
            return "/access_token"
        }
        
        public var parameters: [String: AnyObject] {
            return ["oauth_verifier": verifier]
        }
        
        public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authorizationHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(client: OAuthAccessTokenClient, verifier: String){
            self.client = client
            self.verifier = verifier
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> AccessToken.Response {
            guard
                let dictionary = object as? [String: AnyObject],
                let result = AccessTokenResult(dictionary: dictionary) else {
                    
					throw DecodeError.Fail
            }
			
            return result
        }
    }
}

// MARK: - Models

public struct RequestTokenResult {
    public let requestToken: String
    public let requestTokenSecret: String
    
    public init?(dictionary: [String: AnyObject]){
        guard let
            requestToken = dictionary["oauth_token"] as? String,
            requestTokenSecret = dictionary["oauth_token_secret"] as? String else {
        
                return nil
        }
        
        self.requestToken = requestToken
        self.requestTokenSecret = requestTokenSecret
    }
}

public struct AccessTokenResult {
    public let oauthToken: String
    public let oauthTokenSecret: String
    public let screenName: String
    public let userID: Int64
    
    public init?(dictionary: [String: AnyObject]){
        guard let
            oauthToken = dictionary["oauth_token"] as? String,
            oauthTokenSecret = dictionary["oauth_token_secret"] as? String,
            screenName = dictionary["screen_name"] as? String,
            userID = dictionary["user_id"] as? String else {
                
                return nil
        }
        
        self.oauthToken = oauthToken
        self.oauthTokenSecret = oauthTokenSecret
        self.screenName = screenName
        self.userID = Int64(userID)!
    }
}