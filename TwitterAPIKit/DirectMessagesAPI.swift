//
//  DirectMessages.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/05.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

// MARK: - Request

public protocol DirectMessagesRequestType: TwitterAPIRequestType {}
public protocol DirectMessagesGetRequestType: DirectMessagesRequestType {}
public protocol DirectMessagesPostRequestType: DirectMessagesRequestType {}

public extension DirectMessagesRequestType {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1")!
    }
}

public extension DirectMessagesGetRequestType {
	public var method: APIKit.HTTPMethod {
		return .GET
	}
}

public extension DirectMessagesPostRequestType {
	public var method: APIKit.HTTPMethod {
		return .POST
	}
}

// MARK: - API

public enum TwitterDirectMessages {
	
	///
	/// https://dev.twitter.com/rest/reference/get/direct_messages/sent
	///
	public struct Sent: DirectMessagesGetRequestType, MultipleDirectMessagesResponseType {
		public let client: OAuthAPIClient
		
		public var path: String {
			return "/direct_messages/sent.json"
		}
		
		private let _parameters: [String: AnyObject?]
		public var parameters: AnyObject? {
			return queryStringsFromParameters(_parameters)
		}
		
		public init(
			_ client: OAuthAPIClient,
			  sinceIDStr: String? = nil,
			  maxIDStr: String? = nil,
			  count: Int = 50,
			  page: Int? = nil,
			  includeEntities: Bool = false){
			
			self.client = client
			self._parameters = [
				"since_id": sinceIDStr,
				"max_id": maxIDStr,
				"count": count,
				"page": page,
				"include_entities": includeEntities
			]
		}
		
		public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> [DirectMessage] {
			return try directMessagesFromObject(object, URLResponse)
		}
	}
	
	///
	/// https://dev.twitter.com/rest/reference/get/direct_messages/show
	///
	public struct Show: DirectMessagesGetRequestType, MultipleDirectMessagesResponseType {
		public let client: OAuthAPIClient
		
		public var path: String {
			return "/direct_messages/show.json"
		}
		
		private let _parameters: [String: AnyObject?]
		public var parameters: AnyObject? {
			return queryStringsFromParameters(_parameters)
		}
		
		public init(
			_ client: OAuthAPIClient,
			  idStr: String){
			
			self.client = client
			self._parameters = ["id": idStr]
		}
		
		public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> [DirectMessage] {
			return try directMessagesFromObject(object, URLResponse)
		}
	}
	
	///
	/// https://dev.twitter.com/rest/reference/get/direct_messages
	///
	public struct Received: DirectMessagesGetRequestType, MultipleDirectMessagesResponseType {
		public let client: OAuthAPIClient
		
		public var path: String {
			return "/direct_messages.json"
		}
		
		private let _parameters: [String: AnyObject?]
		public var parameters: AnyObject? {
			return queryStringsFromParameters(_parameters)
		}
		
		public init(
			_ client: OAuthAPIClient,
			  sinceIDStr: String? = nil,
			  maxIDStr: String? = nil,
			  count: Int = 50,
			  includeEntities: Bool = false,
			  skipStatus: Bool = true){
			
			self.client = client
			self._parameters = [
				"since_id": sinceIDStr,
				"max_id": maxIDStr,
				"count": count,
				"include_entities": includeEntities,
				"skip_status": skipStatus
			]
		}
		
		public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> [DirectMessage] {
			return try directMessagesFromObject(object, URLResponse)
		}
	}
	
	///
	/// https://dev.twitter.com/rest/reference/post/direct_messages/destroy
	///
	public struct Destroy: DirectMessagesPostRequestType, SingleDirectMessageResponseType {
		public let client: OAuthAPIClient
		
		public var path: String {
			return "/direct_messages/destroy.json"
		}
		
		private let _parameters: [String: AnyObject?]
		public var parameters: AnyObject? {
			return queryStringsFromParameters(_parameters)
		}
		
		public init(
			_ client: OAuthAPIClient,
			  idStr: String,
			  includeEntities: Bool = false){
			
			self.client = client
			self._parameters = [
				"id": idStr,
				"include_entities": includeEntities
			]
		}
		
		public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> DirectMessage {
			return try directMessageFromObject(object, URLResponse)
		}
	}
	
	///
	/// https://dev.twitter.com/rest/reference/post/direct_messages/new
	///
	public struct New: DirectMessagesPostRequestType, SingleDirectMessageResponseType {
		public let client: OAuthAPIClient
		
		public var path: String {
			return "/direct_messages/new.json"
		}
		
		private let _parameters: [String: AnyObject?]
		public var parameters: AnyObject? {
			return queryStringsFromParameters(_parameters)
		}
		
		public init(
			_ client: OAuthAPIClient,
			  user: User,
			  text: String){
			
			self.client = client
			self._parameters = [
				user.key: user.obj,
				"text": text
			]
		}
		
		public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> DirectMessage {
			return try directMessageFromObject(object, URLResponse)
		}
	}
}
