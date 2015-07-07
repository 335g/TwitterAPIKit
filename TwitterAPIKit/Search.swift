//
//  Search.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/07.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

// MARK: Request

public protocol SearchGetRequest: Request {}

public extension SearchGetRequest {
    public var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1/search")!
    }
    public var requestBodyBuilder: RequestBodyBuilder {
        return .JSON(writingOptions: .PrettyPrinted)
    }
    public var responseBodyParser: ResponseBodyParser {
        return .JSON(readingOptions: .AllowFragments)
    }
}

// MARK: API

public class TwitterSearch: API {
    public enum ResultType: String {
        case Popular = "popular"
        case Recent = "recent"
        case Mixed = "mixed"
    }
    
    public struct Date {
        let year: Int
        let month: Int
        let day: Int
        
        private func dateString() -> String {
            let yearStr = NSString(format: "%04d", year) as String
            let monthStr = NSString(format: "%02d", month) as String
            let dayStr = NSString(format: "%02d", day) as String
            
            return yearStr + "-" + monthStr + "-" + dayStr
        }
    }
    
    public struct Geo {
        public enum Unit: String {
            case mi = "mi"
            case km = "km"
        }
        
        let latitude: String
        let longitude: String
        let unit: Unit
        
        internal func geoString() -> String {
            return latitude + "," + longitude + "," + unit.rawValue
        }
    }
}

public extension TwitterSearch {
    
    ///
    /// https://dev.twitter.com/rest/reference/get/search/tweets
    ///
    public struct Tweets: SearchGetRequest {
        public typealias Response = SearchResult
        
        public let client: OAuthAPIClient
        
        public var method: APIKit.HTTPMethod {
            return .GET
        }
        
        public var path: String {
            return "/tweets.json"
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
            q: String,
            geocode: Geo? = nil,
            lang: String? = nil,
            locale: String? = nil,
            resultType: ResultType? = nil,
            count: Int? = 15,
            until: Date? = nil,
            sinceIDStr: String? = nil,
            maxIDStr: String? = nil,
            includeEntities: Bool = false,
            callback: String? = nil){
                
                self.client = client
                self._parameters = [
                    "q": q,
                    "geocode": geocode?.geoString(),
                    "lang": lang,
                    "locale": locale,
                    "result_type": resultType?.rawValue,
                    "count": count,
                    "until": until?.dateString(),
                    "since_id": sinceIDStr,
                    "max_id": maxIDStr,
                    "include_entities": includeEntities,
                    "callback": callback
                ]
        }
        
        public func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Tweets.Response? {
            guard let
                dictionary = object as? [String: AnyObject],
                searchResult = SearchResult(dictionary: dictionary) else {
                    
                    return nil
            }
            
            return searchResult
        }
    }
}