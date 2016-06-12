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
    func tweetFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) throws -> Tweets
}

public extension SingleTweetResponseType {
    public func tweetFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) throws -> Tweets {
        guard let
            dictionary = object as? [String: AnyObject],
            tweet = Tweets(dictionary: dictionary) else {
                
                throw DecodeError.Fail
        }
        
        return tweet
    }
}

// MARK: - Tweets (Multiple)

public protocol MultipleTweetsResponseType {
    func tweetsFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) throws -> [Tweets]
}

public extension MultipleTweetsResponseType {
    public func tweetsFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) throws -> [Tweets] {
        guard let array = object as? Array<[String: AnyObject]> else {
            throw DecodeError.Fail
        }
        
        var tweets: [Tweets] = []
        for element in array {
            guard let tweet = Tweets(dictionary: element) else {
                throw DecodeError.Fail
            }
            
            tweets.append(tweet)
        }
        
        return tweets
    }
}

// MARK: - DirectMessage

public enum SingleDirectMessageResponseError: ErrorType {
	case DecodeError
}

public protocol SingleDirectMessageResponseType {
	func directMessageFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) throws -> DirectMessage
}

public extension SingleDirectMessageResponseType {
	public func directMessageFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) throws -> DirectMessage {
		guard let
			dictionary = object as? [String: AnyObject],
			dm = DirectMessage(dictionary: dictionary) else {
				throw SingleDirectMessageResponseError.DecodeError
		}
		
		return dm
	}
}

// MARK: - DirectMessage (Multiple)

public protocol MultipleDirectMessagesResponseType {
	func directMessagesFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) throws -> [DirectMessage]
}

public extension MultipleDirectMessagesResponseType {
	public func directMessagesFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) throws -> [DirectMessage] {
		guard let array = object as? Array<[String: AnyObject]> else {
			throw DecodeError.Fail
		}
		
		var messages: [DirectMessage] = []
		for element in array {
			guard let dm = DirectMessage(dictionary: element) else {
				throw DecodeError.Fail
			}
			messages.append(dm)
		}
		
		return messages
	}
}

// MARK: - Users

public protocol SingleUserResponseType {
    func userFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) throws -> Users
}

public extension SingleUserResponseType {
    public func userFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) throws -> Users {
        guard let
            dictionary = object as? [String: AnyObject],
            user = Users(dictionary: dictionary) else {
                
                throw DecodeError.Fail
        }
        
        return user
    }
}

// MARK: - Users (Multiple)

public protocol MultipleUsersResponesType {
    func usersFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) throws -> [Users]
}

public extension MultipleUsersResponesType {
    public func usersFromObject(object: AnyObject, _ URLResponse: NSHTTPURLResponse) throws -> [Users] {
        guard let _users = object as? Array<[String: AnyObject]> else {
            throw DecodeError.Fail
        }
        
        var users: [Users] = []
        for _user in  _users {
            guard let user = Users(dictionary: _user) else {
                throw DecodeError.Fail
            }
            users.append(user)
        }
        
        return users
    }
}



