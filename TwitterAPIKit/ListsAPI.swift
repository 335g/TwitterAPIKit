//
//  Lists.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/06.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

// MARK: - Request

public protocol ListsRequestType: RequestType {}
public protocol ListsGetRequestType: ListsRequestType {}

public extension ListsRequestType {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1/lists")!
    }
}

public extension ListsGetRequestType {
	public var dataParser: DataParserType {
		return JSONDataParser(readingOptions: .AllowFragments)
	}
	
	public var method: APIKit.HTTPMethod {
		return .GET
	}
}

// MARK: - API

public enum TwitterLists {
    
    ///
    /// https://dev.twitter.com/rest/reference/get/lists/memberships
    ///
    public struct Memberships: ListsGetRequestType {
        public typealias Response = ListsList
        
        public let client: OAuthAPIClient
        
        public var path: String {
            return "/memberships.json"
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
            count: Int = 20,
            cursorStr: String = "-1",
            filterToOwnedLists: Bool = false){
                
                self.client = client
                self._parameters = [
                    user.key: user.obj,
                    "count": count,
                    "cursor": cursorStr,
                    "filter_to_owned_lists": filterToOwnedLists
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Memberships.Response {
            guard let
                dictionary = object as? [String: AnyObject],
                list = ListsList(dictionary: dictionary) else {
                    
                    throw DecodeError.Fail
            }
            
            return list
        }
    }
}