//
//  API.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/04/06.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

public class Twitter {
    
    public enum User {
        case UserID(Int64)
        case ScreenName(String)
        
        public static func withID(id: Int64) -> User {
            return .UserID(id)
        }
        
        public static func withName(name: String) -> User {
            return .ScreenName(name)
        }
    }
    
    // TODO: Search以外で使わないならそちらへ移動
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
