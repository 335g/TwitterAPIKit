//
//  Client.swift
//  OreOre
//
//  Created by Yoshiki Kudo on 2015/04/19.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

public struct OAuthClient {
    
    public struct AccessToken {
        public private(set) var key: String
        public private(set) var secret: String
        public private(set) var verifier: String?
        public private(set) var screenName: String?
        public private(set) var userID: String?
        
        public init(key: String, secret: String, verifier: String?, screenName: String?, userID: String?){
            self.key = key
            self.secret = secret
            self.verifier = verifier
            self.screenName = screenName
            self.userID = userID
        }
        
        public init(key: String, secret: String, screenName: String, userID: String) {
            self.init(key: key, secret: secret, verifier: nil, screenName: screenName, userID: userID)
        }
        
        public init(key: String, secret: String, verifier: String){
            self.init(key: key, secret: secret, verifier: verifier, screenName: nil, userID: nil)
        }
        
        public init(key: String, secret: String){
            self.init(key: key, secret: secret, verifier: nil, screenName: nil, userID: nil)
        }
        
    }
    
    private let version: String
    private let signatureMethod: String
    private let dataEncoding: NSStringEncoding
    
    public let consumerKey: String
    public let consumerSecret: String
    public let accessToken: AccessToken?
    
    private init(version: String, signatureMethod: String, dataEncoding: NSStringEncoding, consumerKey: String, consumerSecret: String, accessToken: AccessToken?){
        self.version = version
        self.signatureMethod = signatureMethod
        self.dataEncoding = dataEncoding
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.accessToken = accessToken
    }
    
    public init(consumerKey key: String, consumerSecret secret: String, accessToken: AccessToken?){
        self.init(
            version: "1.0",
            signatureMethod: "HMAC-SHA1",
            dataEncoding: NSUTF8StringEncoding,
            consumerKey: key,
            consumerSecret: secret,
            accessToken: accessToken
        )
    }
    
    func authorizationHeader(method: APIKit.Method, _ url: NSURL, _ params: [String: String], isUpload: Bool) -> String {
        
        var authParams = Dictionary<String, String>()
        authParams["oauth_version"] = version
        authParams["oauth_signature_method"] = signatureMethod
        authParams["oauth_consumer_key"] = consumerKey
        authParams["oauth_timestamp"] = String(Int(NSDate().timeIntervalSince1970))
        authParams["oauth_nonce"] = NSUUID().UUIDString
        
        if let accessToken = self.accessToken {
            authParams["oauth_token"] = accessToken.key
        }
        
        for (key, value) in params {
            if key.hasPrefix("oauth_") {
                authParams.updateValue(value, forKey: key)
            }
        }
        
        var combinedParams: Dictionary<String, String> = authParams
        for (key, value) in params {
            combinedParams[key] = value
        }
        
        var finalParams = isUpload ? authParams : combinedParams
        
        var signature = self.signature(method, url: url, params: finalParams)
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
        
        return "OAuth " + join(", ", headerComponents)
    }
    
    func signature(method: APIKit.Method, url: NSURL, params: [String: AnyObject]) -> String {
        
        var signingKey: String = consumerSecret.urlEncodedStringWithEncoding(dataEncoding) + "&"
        if let encodedTokenSecret: String = self.accessToken?.secret.urlEncodedStringWithEncoding(dataEncoding) {
            signingKey += encodedTokenSecret
        }
        
        var components: [String] = params.urlEncodedQueryStringWithEncoding(dataEncoding).componentsSeparatedByString("&")
        components.sortInPlace { $0 < $1 }
        
        let paramStr: String = "&".join(components)
        let encodedParamStr: String = paramStr.urlEncodedStringWithEncoding(dataEncoding)
        let encodedUrl: String = url.absoluteString.urlEncodedStringWithEncoding(dataEncoding)
        let signatureBaseStr: String = "\(method.rawValue)&\(encodedUrl)&\(encodedParamStr)"
        
        return signatureBaseStr.SHA1DigestWithKey(signingKey, encoding: dataEncoding).base64EncodedStringWithOptions(nil)
    }
}