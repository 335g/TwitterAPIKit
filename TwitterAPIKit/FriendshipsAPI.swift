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

public protocol FriendshipsRequestType: TwitterAPIRequestType {}
public protocol FriendshipsGetRequestType: FriendshipsRequestType {}
public protocol FriendshipsPostRequestType: FriendshipsRequestType {}

public extension FriendshipsRequestType {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1/friendships")!
    }
}

public extension FriendshipsGetRequestType {
	public var method: APIKit.HTTPMethod {
		return .GET
	}
}

public extension FriendshipsPostRequestType {
	public var method: APIKit.HTTPMethod {
		return .POST
	}
}

// MARK: - API

public enum TwitterFriendships {
	
	///
	/// https://dev.twitter.com/rest/reference/post/friendships/create
	///
	public struct Create: FriendshipsPostRequestType, SingleUserResponseType {
		public typealias Response = Users
		
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
	public struct Destroy: FriendshipsPostRequestType, SingleUserResponseType {
		public typealias Response = Users
		
		public let client: OAuthAPIClient
		
		public var path: String {
			return "/destroy.json"
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
		
		public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Destroy.Response {
			return try userFromObject(object, URLResponse)
		}
	}
}
