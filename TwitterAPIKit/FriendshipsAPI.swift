//
//  Friendships.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/06.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

// MARK: - Request

public protocol FriendshipsGetRequest: RequestType {}
public protocol FriendshipsPostRequest: RequestType {}

public extension FriendshipsGetRequest {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1/friendships")!
    }
	
	public var dataParser: DataParserType {
		return JSONDataParser(readingOptions: .AllowFragments)
	}
}

public extension FriendshipsPostRequest {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1/friendships")!
    }
	
	public var dataParser: DataParserType {
		return JSONDataParser(readingOptions: .AllowFragments)
	}
}

// MARK: - API

public enum TwitterFriendships {
	
	///
	/// https://dev.twitter.com/rest/reference/post/friendships/create
	///
	public struct Create: FriendshipsPostRequest, SingleUserResponseType {
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
			  user: User,
			  follow: Bool = false){
			
			self.client = client
			self._parameters = [
				user.key: user.obj,
				"follow": follow
			]
		}
		
		public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Create.Response {
			return try userFromObject(object, URLResponse)
		}
	}
	
	///
	/// https://dev.twitter.com/rest/reference/post/friendships/destroy
	///
	public struct Destroy: FriendshipsPostRequest, SingleUserResponseType {
		public typealias Response = Users
		
		public let client: OAuthAPIClient
		
		public var method: APIKit.HTTPMethod {
			return .POST
		}
		
		public var path: String {
			return "/destroy.json"
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
