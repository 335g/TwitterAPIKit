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
            Session.sendRequest(request, handler: handle(TwitterStatuses.MentionsTimeline.self))
            
        case .StatusesUserTimeLine:
            let user = User.withName("oreore_test1")
            let request = TwitterStatuses.UserTimeline(client, user: user, count: 1, trimUser: true)
            Session.sendRequest(request, handler: handle(TwitterStatuses.UserTimeline.self))
            
        case .StatusesHomeTimeLine:
            let request = TwitterStatuses.HomeTimeline(client, count: 200)
            Session.sendRequest(request, handler: handle(TwitterStatuses.HomeTimeline.self))
            
        case .StatusesRetweetsOfMe:
            let request = TwitterStatuses.RetweetsOfMe(client, count: 1)
            Session.sendRequest(request, handler: handle(TwitterStatuses.RetweetsOfMe.self))
            
        case .StatusesUpdate:
            let request = TwitterStatuses.Update(client, status: "test")
            Session.sendRequest(request, handler: handle(TwitterStatuses.Update.self))
            
        case .StatusesRetweet:
            let request = TwitterStatuses.Retweet(client, idStr: "612495859222118404")
            Session.sendRequest(request, handler: handle(TwitterStatuses.Retweet.self))
            
        case .FriendsIds:
            let user = User.withName("oreore_test1")
            let request = TwitterFriends.Ids(client, user: user)
            Session.sendRequest(request, handler: handle(TwitterFriends.Ids.self))
            
        case .FriendsList:
            let user = User.withName("oreore_test1")
            let request = TwitterFriends.List(client, user: user)
            Session.sendRequest(request, handler: handle(TwitterFriends.List.self))
            
        case .FollowersIds:
            let user = User.withName("oreore_test1")
            let request = TwitterFollowers.Ids(client, user: user)
            Session.sendRequest(request, handler: handle(TwitterFollowers.Ids.self))
            
        case .FollowersList:
            let user = User.withName("oreore_test1")
            let request = TwitterFollowers.List(client, user: user)
            Session.sendRequest(request, handler: handle(TwitterFollowers.List.self))
            
        case .UsersLookup:
            let user = User.withName("oreore_test1")
            let request = TwitterUsers.Lookup(client, users: [user])
            Session.sendRequest(request, handler: handle(TwitterUsers.Lookup.self))
            
        case .UsersShow:
            let user = User.withName("oreore_test1")
            let request = TwitterUsers.Show(client, user: user)
            Session.sendRequest(request, handler: handle(TwitterUsers.Show.self))
            
        case .ListsMemberships:
            let user = User.withName("oreore_test2")
            let request = TwitterLists.Memberships(client, user: user)
            Session.sendRequest(request, handler: handle(TwitterLists.Memberships.self))
            
        case .FriendshipsCreate:
            let user = User.withName("oreore_test1")
            let request = TwitterFriendships.Create(client, user: user)
            Session.sendRequest(request, handler: handle(TwitterFriendships.Create.self))
            
        case .FriendshipsDestroy:
            let user = User.withName("oreore_test2")
            let request = TwitterFriendships.Destroy(client, user: user)
            Session.sendRequest(request, handler: handle(TwitterFriendships.Destroy.self))
            
        case .DirectMessagesNew:
            let user = User.withName("oreore_test1")
            let request = TwitterDirectMessages.New(client, user: user, text: "test direct message")
            Session.sendRequest(request, handler: handle(TwitterDirectMessages.New.self))

//        default:
//            print("not implemented")
			
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
    
    func handle<T: APIKit.RequestType>(type: T.Type) -> Result<T.Response, SessionTaskError> -> Void {
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
