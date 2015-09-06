//
//  ResponseType.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/06.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

// MARK: - Tweets

public protocol SingleTweetResponseType {
    func tweetFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> Tweets?
}

public extension SingleTweetResponseType {
    public func tweetFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> Tweets? {
        guard let
            dictionary = object as? [String: AnyObject],
            tweet = Tweets(dictionary: dictionary) else {
                
                return nil
        }
        
        return tweet
    }
}

// MARK: - Tweets (Multiple)

public protocol MultipleTweetsResponseType {
    func tweetsFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> [Tweets]?
}

public extension MultipleTweetsResponseType {
    public func tweetsFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> [Tweets]? {
        guard let array = object as? Array<[String: AnyObject]> else {
            return nil
        }
        
        var tweets: [Tweets] = []
        for element in array {
            guard let tweet = Tweets(dictionary: element) else {
                return nil
            }
            
            tweets.append(tweet)
        }
        
        return tweets
    }
}

// MARK: - DirectMessage

public protocol SingleDirectMessageResponseType {
    func directMessageFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> DirectMessage?
}

public extension SingleDirectMessageResponseType {
    public func directMessageFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> DirectMessage? {
        guard let
            dictionary = object as? [String: AnyObject],
            dm = DirectMessage(dictionary: dictionary) else {
                
                return nil
        }
        
        return dm
    }
}

// MARK: - DirectMessage (Multiple)

public protocol MultipleDirectMessagesResponseType {
    func directMessagesFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> [DirectMessage]?
}

public extension MultipleDirectMessagesResponseType {
    public func directMessagesFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> [DirectMessage]? {
        guard let array = object as? Array<[String: AnyObject]> else {
            return nil
        }
        
        var messages: [DirectMessage] = []
        for element in array {
            guard let dm = DirectMessage(dictionary: element) else {
                return nil
            }
            messages.append(dm)
        }
        
        return messages
    }
}

// MARK: - Users

public protocol SingleUserResponseType {
    func userFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> Users?
}

public extension SingleUserResponseType {
    public func userFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> Users? {
        guard let
            dictionary = object as? [String: AnyObject],
            user = Users(dictionary: dictionary) else {
                
                return nil
        }
        
        return user
    }
}

// MARK: - Users (Multiple)

public protocol MultipleUsersResponesType {
    func usersFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> [Users]?
}

public extension MultipleUsersResponesType {
    public func usersFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) -> [Users]? {
        guard let _users = object as? Array<[String: AnyObject]> else {
            return nil
        }
        
        var users: [Users] = []
        for _user in  _users {
            guard let user = Users(dictionary: _user) else {
                return nil
            }
            users.append(user)
        }
        
        return users
    }
}



