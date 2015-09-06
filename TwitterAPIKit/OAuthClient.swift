//
//  OAuthClient.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/02.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

public protocol OAuthClientType {
    
    ///
    /// Default Implemented
    ///
    var version: String { get }
    var signatureMethod: String { get }
    var dataEncoding: UInt { get }
    func authorizationHeader(method: APIKit.HTTPMethod, _ url: String, _ params: [String: AnyObject], _ isUpload: Bool) -> String
    func signature(method: APIKit.HTTPMethod, _ url: String, _ params: [String: AnyObject]) -> String
    
    ///
    /// MARK: Other
    ///
    var consumerKey: String { get }
    var consumerSecret: String { get }
    var key: String? { get }
    var secret: String? { get }
}

public extension OAuthClientType {
    
    var version: String {
        return "1.0"
    }
    
    var signatureMethod: String {
        return "HMAC-SHA1"
    }
    
    var dataEncoding: UInt {
        return NSUTF8StringEncoding
    }
    
    func authorizationHeader(method: APIKit.HTTPMethod, _ url: String, _ params: [String: AnyObject], _ isUpload: Bool) -> String {
        
        var authParams = Dictionary<String, AnyObject>()
        authParams["oauth_version"] = version
        authParams["oauth_signature_method"] = signatureMethod
        authParams["oauth_consumer_key"] = consumerKey
        authParams["oauth_timestamp"] = String(Int(NSDate().timeIntervalSince1970))
        authParams["oauth_nonce"] = NSUUID().UUIDString
        
        if let key = self.key {
            authParams["oauth_token"] = key
        }
        
        for (key, value) in params {
            if key.hasPrefix("oauth_") {
                authParams.updateValue(value, forKey: key)
            }
        }
        
        var combinedParams: Dictionary<String, AnyObject> = authParams
        for (key, value) in params {
            combinedParams[key] = value
        }
        
        let finalParams = isUpload ? authParams : combinedParams
        
        let signature = self.signature(method, url, finalParams)
        authParams["oauth_signature"] = signature
        
        var authParamComponents = authParams.urlEncodedQueryStringWithEncoding(dataEncoding).componentsSeparatedByString("&") as [String]
        authParamComponents.sortInPlace { $0 < $1 }
        
        var headerComponents: [String] = []
        for component in authParamComponents {
            let subcomponent = component.componentsSeparatedByString("=") as [String]
            if subcomponent.count == 2 {
                headerComponents.append("\(subcomponent[0])=\"\(subcomponent[1])\"")
            }
        }
        
        return "OAuth " + headerComponents.joinWithSeparator(", ")
    }
    
    func signature(method: APIKit.HTTPMethod, _ url: String, _ params: [String: AnyObject]) -> String {
        
        var signingKey: String = consumerSecret.urlEncodedStringWithEncoding(dataEncoding) + "&"
        if let encodedTokenSecret: String = self.secret?.urlEncodedStringWithEncoding(dataEncoding) {
            signingKey += encodedTokenSecret
        }
        
        var components: [String] = params.urlEncodedQueryStringWithEncoding(dataEncoding).componentsSeparatedByString("&")
        components.sortInPlace { $0 < $1 }
        
        let paramStr: String = components.joinWithSeparator("&")
        let encodedParamStr: String = paramStr.urlEncodedStringWithEncoding(dataEncoding)
        let encodedUrl: String = url.urlEncodedStringWithEncoding(dataEncoding)
        let signatureBaseStr: String = "\(method.rawValue)&\(encodedUrl)&\(encodedParamStr)"
        
        let options = NSDataBase64EncodingOptions()
        return signatureBaseStr.SHA1DigestWithKey(signingKey, encoding: dataEncoding).base64EncodedStringWithOptions(options)
    }
}

public struct OAuthRequestTokenClient: OAuthClientType {
    public let _consumerKey: String
    public let _consumerSecret: String
    
    public var consumerKey: String {
        return _consumerKey
    }
    
    public var consumerSecret: String {
        return _consumerSecret
    }
    
    public var key: String? {
        return nil
    }
    
    public var secret: String? {
        return nil
    }
    
    public init (consumerKey: String, consumerSecret: String){
        _consumerKey = consumerKey
        _consumerSecret = consumerSecret
    }
}

public struct OAuthAccessTokenClient: OAuthClientType {
    public let _consumerKey: String
    public let _consumerSecret: String
    public let _requestToken: String
    public let _requestTokenSecret: String
    
    public var consumerKey: String {
        return _consumerKey
    }
    
    public var consumerSecret: String {
        return _consumerSecret
    }
    
    public var key: String? {
        return _requestToken
    }
    
    public var secret: String? {
        return _requestTokenSecret
    }
    
    public init(consumerKey: String, consumerSecret: String, requestToken: String, requestTokenSecret: String){
        _consumerKey = consumerKey
        _consumerSecret = consumerSecret
        _requestToken = requestToken
        _requestTokenSecret = requestTokenSecret
    }
}

public struct OAuthAPIClient: OAuthClientType {
    public let _consumerKey: String
    public let _consumerSecret: String
    public let _oauthToken: String
    public let _oauthTokenSecret: String
    
    public var consumerKey: String {
        return _consumerKey
    }
    
    public var consumerSecret: String {
        return _consumerSecret
    }
    
    public var key: String? {
        return _oauthToken
    }
    
    public var secret: String? {
        return _oauthTokenSecret
    }
    
    public init(consumerKey: String, consumerSecret: String, oauthToken: String, oauthTokenSecret: String){
        _consumerKey = consumerKey
        _consumerSecret = consumerSecret
        _oauthToken = oauthToken
        _oauthTokenSecret = oauthTokenSecret
    }
}
