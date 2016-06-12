//
//  FoundationExtension.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/04/06.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import HMAC

extension Dictionary {
    func urlEncodedQueryStringWithEncoding(encoding: NSStringEncoding) -> String {
        var parts = [String]()
        
        for (key, value) in self {
            let keyString: String = "\(key)".urlEncodedStringWithEncoding(encoding)
            let valueString: String = "\(value)".urlEncodedStringWithEncoding(encoding)
            let query: String = "\(keyString)=\(valueString)"
            parts.append(query)
        }
        
        return parts.joinWithSeparator("&")
    }
}

extension String {
    func urlEncodedStringWithEncoding(encoding: NSStringEncoding) -> String {
        let charactersToBeEscaped = ":/?&=;+!@#$()',*" as CFStringRef
        let charactersToLeaveUnescaped = "[]." as CFStringRef
        
        let str = self as NSString
        
        let result = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, str as CFString, charactersToLeaveUnescaped, charactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding)) as NSString
        
        return result as String
    }
    
    public func parametersFromQueryString() -> Dictionary<String, String> {
        var parameters = Dictionary<String, String>()
        
        let scanner = NSScanner(string: self)
        
        var key: NSString?
        var value: NSString?
        
        while !scanner.atEnd {
            key = nil
            scanner.scanUpToString("=", intoString: &key)
            scanner.scanString("=", intoString: nil)
            
            value = nil
            scanner.scanUpToString("&", intoString: &value)
            scanner.scanString("&", intoString: nil)
            
            if let key = key, value = value {
                let key = key as String
                let value = value as String
                parameters.updateValue(value, forKey: key)
            }
        }
        
        return parameters
    }
    
    func SHA1DigestWithKey(key: String, encoding: NSStringEncoding) -> NSData {
        let hmac = HMAC(algorithm: .SHA1, key: key).update(self)
        var val: [UInt8] = hmac.final()
        return NSData(bytes: &val, length: val.count)
    }
}