//
//  OAuth.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/02.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

public protocol OAuthRequestType: TwitterAuthenticationRequestType {}

public extension OAuthRequestType {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/oauth")!
    }
}

public protocol OAuthPostRequestType: OAuthRequestType {}
public extension OAuthPostRequestType {
	public var dataParser: DataParserType {
		return FormURLEncodedDataParser(encoding: NSUTF8StringEncoding)
	}
	
	public var method: HTTPMethod {
		return .POST
	}
}

public enum TwitterOAuth {
	
	public static func authorizeURL(requestToken: String) -> NSURL {
		return NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=" + requestToken)!
	}
	
    ///
    /// https://dev.twitter.com/oauth/reference/post/oauth/request_token
    ///
    public struct RequestToken: OAuthPostRequestType {
        public let client: OAuthRequestTokenClient
        public let callback: String
        
        public var path: String {
            return "/request_token"
        }
        
        public var parameters: AnyObject? {
            return ["oauth_callback": callback]
        }
		
		public init(client: OAuthRequestTokenClient, callback: String){
            self.client = client
            self.callback = callback
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> RequestTokenResult {
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
    public struct AccessToken: OAuthPostRequestType {
        public let client: OAuthAccessTokenClient
        public let verifier: String
        
        public var path: String {
            return "/access_token"
        }
        
        public var parameters: AnyObject? {
            return ["oauth_verifier": verifier]
        }
		
        public init(client: OAuthAccessTokenClient, verifier: String){
            self.client = client
            self.verifier = verifier
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> AccessTokenResult {
            guard
                let dictionary = object as? [String: AnyObject],
                let result = AccessTokenResult(dictionary: dictionary) else {
                    
					throw DecodeError.Fail
            }
			
            return result
        }
    }
}

