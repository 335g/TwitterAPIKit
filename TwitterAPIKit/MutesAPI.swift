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

public protocol MutesGetRequest: RequestType {}
public protocol MutesPostRequest: RequestType {}

public extension MutesGetRequest {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1/mutes/users")!
    }
	
	public var dataParser: DataParserType {
		return JSONDataParser(readingOptions: .AllowFragments)
	}
}

public extension MutesPostRequest {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1/mutes/users")!
    }
	
	public var dataParser: DataParserType {
		return JSONDataParser(readingOptions: .AllowFragments)
	}
}

// MARK: API

public enum TwitterMutes {
    
    ///
    /// https://dev.twitter.com/rest/reference/get/mutes/users/ids
    ///
    public struct Ids: MutesGetRequest {
        public typealias Response = UserIDs
        
        public let client: OAuthAPIClient
        
        public var method: APIKit.HTTPMethod {
            return .GET
        }
        
        public var path: String {
            return "/ids.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: [String: AnyObject] {
            return queryStringsFromParameters(_parameters)
        }
        
        public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authorizationHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
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
    public struct List: MutesGetRequest {
        public typealias Response = UsersList
        
        public let client: OAuthAPIClient
        
        public var method: APIKit.HTTPMethod {
            return .GET
        }
        
        public var path: String {
            return "/list.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: [String: AnyObject] {
            return queryStringsFromParameters(_parameters)
        }
        
        public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authorizationHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
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
    public struct Create: MutesPostRequest, SingleUserResponseType {
        public typealias Response = Users
        
        public let client: OAuthAPIClient
        
        public var method: APIKit.HTTPMethod {
            return .POST
        }
        
        public var path: String {
            return "/create.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: [String: AnyObject] {
            return queryStringsFromParameters(_parameters)
        }
        
        public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authorizationHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            user: User){
                
                self.client = client
                self._parameters = [user.key: user.obj]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Create.Response {
            return try userFromObject(object, URLResponse)
        }
    }
    
    ///
    /// https://dev.twitter.com/rest/reference/post/mutes/users/destroy
    ///
    public struct Destroy: MutesPostRequest, SingleUserResponseType {
        public typealias Response = Users
        
        public let client: OAuthAPIClient
        
        public var method: APIKit.HTTPMethod {
            return .POST
        }
        
        public var path: String {
            return "/destory.json"
        }
        
        private let _parameters: [String: AnyObject?]
        public var parameters: [String: AnyObject] {
            return queryStringsFromParameters(_parameters)
        }
        
        public func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
            let url = self.baseURL.absoluteString + self.path
            let header = client.authorizationHeader(self.method, url, parameters, false)
            URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
            
            return URLRequest
        }
        
        public init(
            _ client: OAuthAPIClient,
            user: User){
                
                self.client = client
                self._parameters = [user.key: user.obj]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Destroy.Response {
            return try userFromObject(object, URLResponse)
        }
    }
}