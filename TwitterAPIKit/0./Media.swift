//
//  Media.swift
//  TwitterAPIKit
//
//  Created by Yoshiki Kudo on 2015/06/21.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import Foundation
import APIKit

extension Twitter {
    public class Media {
        
        ///
        /// MARK: - Methods
        ///
        public class Post: APIKit.API {
            public override class var baseURL: NSURL {
                return NSURL(string: "https://api.twitter.com/1.1/")!
            }
            public override class var requestBodyBuilder: RequestBodyBuilder {
                return .URL(encoding: NSUTF8StringEncoding)
            }
            public override class var responseBodyParser: ResponseBodyParser {
                return .JSON(readingOptions: nil)
            }
        }
        
        // TODO: Upload
    }
}