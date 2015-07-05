//
//  User.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/05.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

public enum User {
    case ScreenName(String)
    case UserID(Int64)
}

public extension User {
    public static func withID(id: Int64) -> User {
        return .UserID(id)
    }
    public static func withName(name: String) -> User {
        return .ScreenName(name)
    }
}

public extension User {
    var key: String {
        switch self {
        case .ScreenName(_):
            return "screen_name"
        case .UserID(_):
            return "user_id"
        }
    }
    
    var obj: String {
        switch self {
        case .ScreenName(let name):
            return name
        case .UserID(let id):
            return String(id)
        }
    }
}

internal func isID(user: User) -> Bool {
    switch user {
    case .UserID(_):
        return true
    default:
        return false
    }
}

internal func isScreenName(user: User) -> Bool {
    switch user {
    case .ScreenName(_):
        return true
    default:
        return false
    }
}

internal func stringValue(user: User) -> String {
    switch user {
    case .ScreenName(let name):
        return name
    case .UserID(let id):
        return String(id)
    }
}

internal func screenNames(users: [User]) -> [String] {
    return users
        .filter(isScreenName)
        .map(stringValue)
}

internal func userIds(users: [User]) -> [String] {
    return users
        .filter(isID)
        .map(stringValue)
}