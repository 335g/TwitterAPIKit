//
//  Entities.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/05.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

public struct Entities {
    
    public let hashTags: [Hashtag]
    public let media: [Media]
    public let urls: [URL]
    public let userMensions: [UserMension]
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            _hashTags = dictionary["hash_tags"] as? Array<[String: AnyObject]>,
            _medias = dictionary["media"] as? Array<[String: AnyObject]>,
            _urls = dictionary["urls"] as? Array<[String: AnyObject]>,
            _userMesions = dictionary["user_mesions"] as? Array<[String: AnyObject]> else {
                
                return nil
        }
        
        var hashTags: [Hashtag] = []
        for _hashtag in _hashTags {
            guard let hashtag = Hashtag(dictionary: _hashtag) else {
                return nil
            }
            hashTags.append(hashtag)
        }
        
        var medias: [Media] = []
        for _media in _medias {
            guard let media = Media(dictionary: _media) else {
                return nil
            }
            medias.append(media)
        }
        
        var urls: [URL] = []
        for _url in _urls {
            guard let url = URL(dictionary: _url) else {
                return nil
            }
            urls.append(url)
        }
        
        var userMensions: [UserMension] = []
        for _userMension in _userMesions {
            guard let userMension = UserMension(dictionary: _userMension) else {
                return nil
            }
            userMensions.append(userMension)
        }
        
        self.hashTags = hashTags
        self.media = medias
        self.urls = urls
        self.userMensions = userMensions
    }
}

public struct Hashtag {
    public let indices: [Int]
    public let text: String
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            indices = dictionary["indicies"] as? [Int],
            text = dictionary["text"] as? String else {
                
                return nil
        }
        
        self.indices = indices
        self.text = text
    }
}

public struct Media {
    public let displayUrl: String
    public let expandedUrl: String
    public let idStr: String
    public let indicies: [Int]
    public let mediaUrl: String
    public let mediaUrlHttps: String
    public let sizes: Sizes
    public let sourceStatusId: Int
    public let sourceStatusIdStr: String
    public let type: String
    public let url: String
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            displayUrl = dictionary["display_url"] as? String,
            expandedUrl = dictionary["expanded_url"] as? String,
            idStr = dictionary["id_str"] as? String,
            indicies = dictionary["indicies"] as? [Int],
            mediaUrl = dictionary["media_url"] as? String,
            mediaUrlHttps = dictionary["media_url_https"] as? String,
            sizes = Sizes(dictionary: dictionary["sizes"] as? [String: AnyObject]),
            sourceStatusId = dictionary["source_status_id"] as? Int,
            sourceStatusIdStr = dictionary["source_status_id_str"] as? String,
            type = dictionary["type"] as? String,
            url = dictionary["url"] as? String else {
                
                return nil
        }
        
        self.displayUrl = displayUrl
        self.expandedUrl = expandedUrl
        self.idStr = idStr
        self.indicies = indicies
        self.mediaUrl = mediaUrl
        self.mediaUrlHttps = mediaUrlHttps
        self.sizes = sizes
        self.sourceStatusId = sourceStatusId
        self.sourceStatusIdStr = sourceStatusIdStr
        self.type = type
        self.url = url
    }
}

public struct Sizes {
    public let thumb: Size
    public let large: Size
    public let medium: Size
    public let small: Size
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            thumb = Size(dictionary: dictionary["thumb"] as? [String: AnyObject]),
            large = Size(dictionary: dictionary["large"] as? [String: AnyObject]),
            medium = Size(dictionary: dictionary["medium"] as? [String: AnyObject]),
            small = Size(dictionary: dictionary["small"] as? [String: AnyObject]) else {
                
                return nil
        }
        
        self.thumb = thumb
        self.large = large
        self.medium = medium
        self.small = small
    }
}

public struct Size {
    public let h: Int
    public let resize: String
    public let w: Int
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            h = dictionary["h"] as? Int,
            resize = dictionary["resize"] as? String,
            w = dictionary["w"] as? Int else {
                
                return nil
        }
        
        self.h = h
        self.resize = resize
        self.w = w
    }
}

public struct URL {
    public let displayUrl: String
    public let expandedUrl: String
    public let indicies: [Int]
    public let url: String
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            displayUrl = dictionary["display_url"] as? String,
            expandedUrl = dictionary["expanded_url"] as? String,
            indicies = dictionary["indicies"] as? [Int],
            url = dictionary["url"] as? String else {
                
                return nil
        }
        
        self.displayUrl = displayUrl
        self.expandedUrl = expandedUrl
        self.indicies = indicies
        self.url = url
    }
}

public struct UserMension {
    public let id: Int
    public let idStr: String
    public let indicies: [Int]
    public let name: String
    public let screenName: String
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            id = dictionary["id"] as? Int,
            idStr = dictionary["id_str"] as? String,
            indicies = dictionary["indicies"] as? [Int],
            name = dictionary["name"] as? String,
            screenName = dictionary["screen_name"] as? String else {
                
                return nil
        }
        
        self.id = id
        self.idStr = idStr
        self.indicies = indicies
        self.name = name
        self.screenName = screenName
    }
}