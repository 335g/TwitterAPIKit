//
//  Search.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/06/21.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

extension Twitter {
    public class Search {
        
        ///
        /// MARK: - Methods
        ///
        public class Get: APIKit.API {
            public override class var baseURL: NSURL {
                return NSURL(string: "https://api.twitter.com/1.1/search")!
            }
            public override class var requestBodyBuilder: RequestBodyBuilder {
                return .JSON(writingOptions: nil)
            }
            public override class var responseBodyParser: ResponseBodyParser {
                return .JSON(readingOptions: nil)
            }
        }
        
        ///
        /// Param
        ///
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
        
        // MARK: Property
        
        var client: OAuthClient!
        var parameters: [String: AnyObject?]!
        
        // MARK: Initializer
        
        private init(_ client: OAuthClient, parameters: [String: AnyObject?]){
            self.client = client
            self.parameters = parameters
        }
        
        // MARK: Common Function
        
        func getURLRequest(lastPath: String, method: APIKit.Method) -> NSURLRequest? {
            
            var baseURL: NSURL!
            switch method {
            case .GET:
                baseURL = Get.baseURL
            default:
                fatalError("must GET or POST")
            }
            
            let fullPathStr = baseURL.absoluteString + lastPath
            let url = NSURL(string: fullPathStr)
            
            var queryParams = queryStringsFromParameters(parameters)
            
            var request: NSMutableURLRequest?
            switch method {
            case .GET:
                request = Get.URLRequest(method: .GET, path: lastPath, parameters: queryParams, requestBodyBuilder: Get.requestBodyBuilder)
            default:
                ()
            }
            
            var header: String
            switch method {
            case .GET:
                header = client.authorizationHeader(.GET, url!, queryParams, isUpload: false)
                request?.setValue(header, forHTTPHeaderField: "Authorization")
                
            default:
                ()
            }
            
            return request
        }
        
        ///
        /// MARK: APIs
        ///
        
        ///
        /// https://dev.twitter.com/rest/reference/get/search/tweets
        ///
        public class Tweets: Search, APIKit.Request {
            public typealias Response = Dictionary<String, AnyObject>
            public typealias Method = Twitter.Search.Get
            
            public init(
                _ client: OAuthClient,
                q: String,
                geocode: Geo? = nil,
                lang: String? = nil,
                locale: String? = nil,
                resultType: ResultType? = nil,
                count: Int? = 15,
                until: Date? = nil,
                sinceID: Int64? = nil,
                maxID: Int64? = nil,
                includeEntities: Bool = false,
                callback: String? = nil
                ){
                    let aCount = count > 100 ? 100 : count
                    let parameters = [
                        "q": q,
                        "geocode": geocode?.geoString(),
                        "lang": lang,
                        "locale": locale,
                        "result_type": resultType?.rawValue,
                        "count": aCount,
                        "until": until?.dateString(),
                        "since_id": sinceID as? AnyObject,
                        "max_id": maxID as? AnyObject,
                        "include_entities": includeEntities,
                        "callback": callback
                    ]
                    
                    super.init(client, parameters: parameters)
            }
            
            public class func responseFromObject(object: AnyObject) -> Response? {
                return object as? Response
            }
            
            public var URLRequest: NSURLRequest? {
                return super.getURLRequest("./tweets.json", method: .GET)
            }
        }
    }
}