//
//  CallViewController.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/04/20.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import UIKit
import TwitterAPIKit
import APIKit
import Result

enum API: String {
    
    // statuses
    case StatusesMensionsTimeLine = "statuses/mensions_timeline"
    case StatusesUserTimeLine = "statuses/user_timeline"
    case StatusesHomeTimeLine = "statuses/home_timeline"
    case StatusesRetweetsOfMe = "statuses/retweets_of_me"
    case StatusesUpdate = "statuses/update"
    case StatusesRetweet = "statuses/retweet"
    
    // friends
    case FriendsIds = "friends/ids"
    case FriendsList = "friends/list"
    
    // followers
    case FollowersIds = "followers/ids"
    case FollowersList = "followers/list"
    
    // users
    case UsersLookup = "users/lookup"
    case UsersShow = "users/show"
    
    // lists
    case ListsMemberships = "lists/memberships"
    
    // Friendships
    case FriendshipsCreate = "friendships/create"
    case FriendshipsDestroy = "friendships/destroy"
    
    // DirectMessages
    case DirectMessagesNew = "direct_messages/new"
    
}

class CallViewController: UIViewController {
    
    var client: OAuthAPIClient!
    var user: User!
    
    var api: API = .StatusesMensionsTimeLine
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        switch api {
        case .StatusesMensionsTimeLine:
            let request = TwitterStatuses.MentionsTimeline(client, count: 1, trimUser: true)
            TwitterStatuses.sendRequest(request, handler: handle(TwitterStatuses.MentionsTimeline.self))
            
        case .StatusesUserTimeLine:
            let user = User.withName("oreore_test1")
            let request = TwitterStatuses.UserTimeline(client, user: user, count: 1, trimUser: true)
            TwitterStatuses.sendRequest(request, handler: handle(TwitterStatuses.UserTimeline.self))
            
        case .StatusesHomeTimeLine:
            let request = TwitterStatuses.HomeTimeline(client, count: 1)
            TwitterStatuses.sendRequest(request, handler: handle(TwitterStatuses.HomeTimeline.self))
            
        case .StatusesRetweetsOfMe:
            let request = TwitterStatuses.RetweetsOfMe(client, count: 1)
            TwitterStatuses.sendRequest(request, handler: handle(TwitterStatuses.RetweetsOfMe.self))
            
        case .StatusesUpdate:
            let request = TwitterStatuses.Update(client, status: "test")
            TwitterStatuses.sendRequest(request, handler: handle(TwitterStatuses.Update.self))
            
        case .StatusesRetweet:
            let request = TwitterStatuses.Retweet(client, idStr: "612495859222118404")
            TwitterStatuses.sendRequest(request, handler: handle(TwitterStatuses.Retweet.self))
            
//        case .FriendsIds:
//            let user = Twitter.User.withName("oreore_test1")
//            let request = Twitter.Friends.Ids(client, user: user)
//            Twitter.Friends.Ids.Method.sendRequest(request, handler: handle(Twitter.Friends.Ids.self))
//            
//        case .FriendsList:
//            let user = Twitter.User.withName("oreore_test1")
//            let request = Twitter.Friends.List(client, user: user)
//            Twitter.Friends.List.Method.sendRequest(request, handler: handle(Twitter.Friends.List.self))
//            
//        case .FollowersIds:
//            let user = Twitter.User.withName("oreore_test1")
//            let request = Twitter.Followers.Ids(client, user: user)
//            Twitter.Followers.Ids.Method.sendRequest(request, handler: handle(Twitter.Followers.Ids.self))
//            
//        case .FollowersList:
//            let user = Twitter.User.withName("oreore_test1")
//            let request = Twitter.Followers.List(client, user: user)
//            Twitter.Followers.List.Method.sendRequest(request, handler: handle(Twitter.Followers.List.self))
//            
//        case .UsersLookup:
//            let user = Twitter.User.withName("oreore_test1")
//            let request = Twitter.Users.Lookup(client, users: [user])
//            Twitter.Users.Lookup.Method.sendRequest(request, handler: handle(Twitter.Users.Lookup.self))
//            
//        case .UsersShow:
//            let user = Twitter.User.withName("oreore_test1")
//            let request = Twitter.Users.Show(client, user: user)
//            Twitter.Users.Show.Method.sendRequest(request, handler: handle(Twitter.Users.Show.self))
//            
//        case .ListsMemberships:
//            let user = Twitter.User.withName("oreore_test2")
//            let request = Twitter.Lists.Memberships(client, user: user)
//            Twitter.Lists.Memberships.Method.sendRequest(request, handler: handle(Twitter.Lists.Memberships.self))
//            
//        case .FriendshipsCreate:
//            let user = Twitter.User.withName("oreore_test1")
//            let request = Twitter.Friendships.Create(client, user: user)
//            Twitter.Friendships.Create.Method.sendRequest(request, handler: handle(Twitter.Friendships.Create.self))
//            
//        case .FriendshipsDestroy:
//            let user = Twitter.User.withName("oreore_test2")
//            let request = Twitter.Friendships.Destroy(client, user: user)
//            Twitter.Friendships.Destroy.Method.sendRequest(request, handler: handle(Twitter.Friendships.Destroy.self))
//            
//        case .DirectMessagesNew:
//            let user = Twitter.User.withName("oreore_test1")
//            let request = Twitter.DirectMessages.New(client, user: user, text: "test direct message")
//            Twitter.DirectMessages.New.Method.sendRequest(request, handler: handle(Twitter.DirectMessages.New.self))

        default:
            print("not implemented")
            
                ///
                /// # memo
                ///
                /// @oreore_test1 (id: )
                ///   tweet_id: 612495859222118404
                ///
                /// @oreore_test2 (id: 3251254602)
                ///
        }
    }
    
    func handle<T: APIKit.Request>(type: T.Type) -> (Result<T.Response, APIError>) -> Void {
        return { [weak self] response in
            switch response {
            case .Success(let response):
                if let val = self?.api.rawValue {
                    print(" ")
                    print("** Success - " + val + " **")
                }
                print(" ")
                print(response)
                
            case .Failure(let error):
                if let val = self?.api.rawValue {
                    print(" ")
                    print("** Failure - " + val + " **")
                }
                print(" ")
                print(error)
                
            }
        }
    }
}
