//
//  Followers.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/05.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

// MARK: - Request

public protocol FollowersGetRequest: RequestType {}

public extension FollowersGetRequest {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1/followers")!
    }
	
	public var dataParser: DataParserType {
		return JSONDataParser(readingOptions: .AllowFragments)
	}
}

// MARK: - API

public enum TwitterFollowers {
	///
	/// https://dev.twitter.com/rest/reference/get/followers/ids
	///
	public struct Ids: FollowersGetRequest {
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
			  user: User,
			  count: Int = 5000,
			  cursorStr: String = "-1",
			  stringifyIds: Bool = true){
			
			self.client = client
			self._parameters = [
				user.key: user.obj,
				"cursor": cursorStr,
				"stringify_ids": stringifyIds,
				"count": count
			]
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
	/// https://dev.twitter.com/rest/reference/get/friends/list
	///
	public struct List: FollowersGetRequest {
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
			  user: User,
			  count: Int = 50,
			  cursorStr: String = "-1",
			  skipStatus: Bool = true,
			  includeUserEntities: Bool = false){
			
			self.client = client
			self._parameters = [
				user.key: user.obj,
				"cursor": cursorStr,
				"count": count,
				"skip_status": skipStatus,
				"include_user_entities": includeUserEntities
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
}
