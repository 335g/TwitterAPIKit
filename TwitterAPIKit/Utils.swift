//
//  Utils.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/04.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

internal func queryStringsFromParameters(infos: [String: AnyObject?]) -> [String: String] {
    var strings: [String: String] = [:]
    for (key, obj) in infos {
        if let obj: AnyObject = obj {
            let objString = obj as? String ?? "\(obj)"
            if objString != "" {
                strings[key] = objString
            }
        }
    }
    
    return strings
}
