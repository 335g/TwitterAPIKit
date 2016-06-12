//
//  SearchResult.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/07.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

public struct SearchResult {
    public let tweets: [Tweets]
    public let searchMetadata: SearchMetadata
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            _tweets = dictionary["tweets"] as? Array<[String: AnyObject]>,
            searchMetadata = SearchMetadata(dictionary: dictionary["search_metadata"] as? [String: AnyObject]) else {
                
                return nil
        }
        
        var tweetsList: [Tweets] = []
        for _tweet in _tweets {
            guard let tweet = Tweets(dictionary: _tweet) else {
                return nil
            }
            tweetsList.append(tweet)
        }
        
        self.tweets = tweetsList
        self.searchMetadata = searchMetadata
    }
}

public struct SearchMetadata {
    public let maxID: Int
    public let sinceID: Int
    public let refreshUrl: String
    public let nextResults: String
    public let count: Int
    public let completedIn: Float
    public let sinceIDStr: String
    public let query: String
    public let maxIDStr: String
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            maxID = dictionary["max_id"] as? Int,
            sinceID = dictionary["since_id"] as? Int,
            refreshUrl = dictionary["refresh_url"] as? String,
            nextResults = dictionary["next_results"] as? String,
            count = dictionary["count"] as? Int,
            completedIn = dictionary["completed_in"] as? Float,
            sinceIDStr = dictionary["since_id_str"] as? String,
            query = dictionary["query"] as? String,
            maxIDStr = dictionary["max_id_str"] as? String else {
                
                return nil
        }
        
        self.maxID = maxID
        self.sinceID = sinceID
        self.refreshUrl = refreshUrl
        self.nextResults = nextResults
        self.count = count
        self.completedIn = completedIn
        self.sinceIDStr = sinceIDStr
        self.query = query
        self.maxIDStr = maxIDStr
    }
}