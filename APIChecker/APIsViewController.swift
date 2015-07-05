//
//  APIsViewController.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/04/20.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import UIKit
import TwitterAPIKit

class APIsViewController: UITableViewController {
    
    var client: OAuthAPIClient!
    var user: User!
    
    var apis: [[API]] = [
        [
            API.StatusesMensionsTimeLine,
            API.StatusesUserTimeLine,
            API.StatusesHomeTimeLine,
            API.StatusesRetweetsOfMe,
            API.StatusesUpdate,
            API.StatusesRetweet
        ]
//        
//        [
//            API.FriendsIds,
//            API.FriendsList
//        ],
//        
//        [
//            API.FollowersIds,
//            API.FollowersList
//        ],
//        
//        [
//            API.UsersLookup,
//            API.UsersShow
//        ],
//        
//        [
//            API.ListsMemberships
//        ],
//        
//        [
//            API.FriendshipsCreate,
//            API.FriendshipsDestroy
//        ],
//        
//        [
//            API.DirectMessagesNew
//        ]
    ]

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.apis.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSection = self.apis[section]
        return inSection.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        if let textLabel = cell.textLabel {
            let row = indexPath.row
            let section = indexPath.section
            textLabel.text = self.apis[section][row].rawValue
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = sender as! NSIndexPath
        let row = indexPath.row
        let section = indexPath.section
        
        let viewController = segue.destinationViewController as! CallViewController
        viewController.client = self.client
        viewController.user = self.user
        viewController.api = self.apis[section][row]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("push", sender: indexPath)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Statuses"
        case 1:
            return "Friends"
        case 2:
            return "Followers"
        case 3:
            return "Users"
        case 4:
            return "Lists"
        case 5:
            return "Friendships"
        case 6:
            return "DirectMessages"
        default:
            return nil
        }
    }
}
