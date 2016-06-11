//
//  UsersAPI.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/07.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

// MARK: Request

public protocol UsersRequestType: RequestType {}
public protocol UsersGetRequestType: UsersRequestType {}

public extension UsersRequestType {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1/users")!
    }
}

public extension UsersGetRequestType {
	public var dataParser: DataParserType {
		return JSONDataParser(readingOptions: .AllowFragments)
	}
	
	public var method: APIKit.HTTPMethod {
		return .GET
	}
}

// MARK: API

public enum TwitterUsers {
    
    ///
    /// https://dev.twitter.com/rest/reference/get/users/lookup
    ///
    public struct Lookup: UsersGetRequestType, MultipleUsersResponesType {
        public typealias Response = [Users]
        
        public let client: OAuthAPIClient
		
        public var path: String {
            return "/lookup.json"
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
            users: [User],
            includeEntities: Bool = false){
                
                self.client = client
                self._parameters = [
                    "screen_name": screenNames(users).joinWithSeparator(","),
                    "user_id": userIds(users).joinWithSeparator(","),
                    "include_entities": includeEntities
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Lookup.Response {
            print(object)
            return try usersFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/get/users/show
    ///
    public struct Show: UsersGetRequestType, SingleUserResponseType {
        public typealias Response = Users
        
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
            user: User,
            includeEntities: Bool = false){
                
                self.client = client
                self._parameters = [
                    user.key: user.obj,
                    "include_entities": includeEntities
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Show.Response {
            return try userFromObject(object, URLResponse)
        }
    }
    
    
}