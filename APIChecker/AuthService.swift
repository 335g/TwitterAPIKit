//
//  AuthService.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/04/20.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

class AuthService {
    static let sharedService: AuthService = AuthService()
    
    private(set) var consumerKey: String = ""
    private(set) var consumerSecret: String = ""
    
    static let callback: String = "apichecker://granted"
    static let callbackNotification: String = "org.TwitterAPIKit.APIChecker.NotificationName.callbackNotification"
    
    init() {
        if let filePath = NSBundle.mainBundle().pathForResource("AppInfo", ofType: "plist") {
            if let info = NSDictionary(contentsOfFile: filePath) {
                consumerKey = info["consumerKey"] as! String
                consumerSecret = info["consumerSecret"] as! String
            }
        }
    }
}