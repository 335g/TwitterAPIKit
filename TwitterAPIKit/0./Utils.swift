//
//  Utils.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/06/20.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

internal func isID(user: Twitter.User) -> Bool {
    switch user {
    case .UserID(_):
        return true
    default:
        return false
    }
}

internal func isScreenName(user: Twitter.User) -> Bool {
    switch user {
    case .ScreenName(_):
        return true
    default:
        return false
    }
}

internal func stringValue(user: Twitter.User) -> String {
    switch user {
    case .ScreenName(let name):
        return name
    case .UserID(let id):
        return String(id)
    }
}

internal func screenNames(users: [Twitter.User]) -> [String] {
    return users
        .filter(isScreenName)
        .map(stringValue)
}

internal func userIds(users: [Twitter.User]) -> [String] {
    return users
        .filter(isID)
        .map(stringValue)
}

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

internal func userKeyObject(user: Twitter.User) -> (String, String) {
    
    var key: String = ""
    var obj: String = ""
    
    switch user {
    case .ScreenName(let name):
        key = "screen_name"
        obj = name
    case .UserID(let id):
        key = "user_id"
        obj = String(id)
    }
    
    return (key, obj)
}