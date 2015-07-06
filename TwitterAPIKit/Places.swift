//
//  Places.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/07/05.
//  Copyright © 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation

public struct Places {
    
    public let attributes: [String: AnyObject]
    public let boundingBox: BoundingBox
    public let country: String
    public let countryCode: String
    public let fullName: String
    public let id: String
    public let name: String
    public let placeType: String
    public let url: String
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            attributes = dictionary["attributes"] as? [String: AnyObject],
            boundingBox = BoundingBox(dictionary: dictionary["bounding_box"] as? [String: AnyObject]),
            country = dictionary["country"] as? String,
            countryCode = dictionary["country_code"] as? String,
            fullName = dictionary["full_name"] as? String,
            id = dictionary["id"] as? String,
            name = dictionary["name"] as? String,
            placeType = dictionary["place_type"] as? String,
            url = dictionary["url"] as? String else {
                
                return nil
        }
        
        self.attributes = attributes
        self.boundingBox = boundingBox
        self.country = country
        self.countryCode = countryCode
        self.fullName = fullName
        self.id = id
        self.name = name
        self.placeType = placeType
        self.url = url
    }
}

public struct BoundingBox {
    public let coordinates: [[[Float]]]
    public let type: String
    
    public init?(dictionary _dictionary: [String: AnyObject]?){
        guard let dictionary = _dictionary else {
            return nil
        }
        
        guard let
            coordinates = dictionary["coordinates"] as? [[[Float]]],
            type = dictionary["type"] as? String else {
                return nil
        }
        
        self.coordinates = coordinates
        self.type = type
    }
}