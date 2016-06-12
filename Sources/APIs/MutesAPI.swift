//
//  Mutes.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/07.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

// MARK: Request

public protocol MutesRequestType: TwitterAPIRequestType {}
public protocol MutesGetRequestType: MutesRequestType {}
public protocol MutesPostRequestType: MutesRequestType {}

public extension MutesRequestType {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1/mutes/users")!
    }
}

public extension MutesGetRequestType {
	public var method: APIKit.HTTPMethod {
		return .GET
	}
}

public extension MutesPostRequestType {
	public var method: APIKit.HTTPMethod {
		return .POST
	}
}

// MARK: API

public enum TwitterMutes {
    
    ///
    /// https://dev.twitter.com/rest/reference/get/mutes/users/ids
    ///
    public struct Ids: MutesGetRequestType {
        public typealias Response = UserIDs
        
        public let client: OAuthAPIClient
        
        public var path: String {
            return "/ids.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
		
        public init(
            _ client: OAuthAPIClient,
            cursorStr: String = "-1"){
                
                self.client = client
                self._parameters = ["cursor": cursorStr]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Ids.Response {
            guard let
                dictionary = object as? [String: AnyObject],
                ids = UserIDs(dictionary: dictionary) else {
                    
                    throw DecodeError.Fail
            }
            
            return ids
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/get/mutes/users/list
    ///
    public struct List: MutesGetRequestType {
        public typealias Response = UsersList
        
        public let client: OAuthAPIClient
        
        public var path: String {
            return "/list.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
        
        public init(
            _ client: OAuthAPIClient,
            cursorStr: String = "-1",
            includeEntities: Bool = false,
            skipStatus: Bool = true){
                
                self.client = client
                self._parameters = [
                    "cursor": cursorStr,
                    "include_entities": includeEntities,
                    "skip_status": skipStatus
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> List.Response {
            guard let
                dictionary = object as? [String: AnyObject],
                list = UsersList(dictionary: dictionary) else {
                    
                    throw DecodeError.Fail
            }
            
            return list
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/post/mutes/users/create
    ///
    public struct Create: MutesPostRequestType, SingleUserResponseType {
        public let client: OAuthAPIClient
		
        public var path: String {
            return "/create.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: AnyObject? {
            return queryStringsFromParameters(_parameters)
        }
        
        public init(
            _ client: OAuthAPIClient,
            user: User){
                
                self.client = client
                self._parameters = [user.key: user.obj]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Users {
            return try userFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/post/mutes/users/destroy
    ///
    public struct Destroy: MutesPostRequestType, SingleUserResponseType {
        public let client: OAuthAPIClient
        
        public var path: String {
            return "/destory.json"
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
            user: User){
                
                self.client = client
                self._parameters = [user.key: user.obj]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Users {
            return try userFromObject(object, URLResponse)
        }
    }
}