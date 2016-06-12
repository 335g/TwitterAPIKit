//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

public struct RequestTokenResult {
	public let requestToken: String
	public let requestTokenSecret: String
	
	public init?(dictionary: [String: AnyObject]){
		guard let
			requestToken = dictionary["oauth_token"] as? String,
			requestTokenSecret = dictionary["oauth_token_secret"] as? String else {
				
				return nil
		}
		
		self.requestToken = requestToken
		self.requestTokenSecret = requestTokenSecret
	}
}

public struct AccessTokenResult {
	public let oauthToken: String
	public let oauthTokenSecret: String
	public let screenName: String
	public let userID: Int64
	
	public init?(dictionary: [String: AnyObject]){
		guard let
			oauthToken = dictionary["oauth_token"] as? String,
			oauthTokenSecret = dictionary["oauth_token_secret"] as? String,
			screenName = dictionary["screen_name"] as? String,
			userID = dictionary["user_id"] as? String else {
				
				return nil
		}
		
		self.oauthToken = oauthToken
		self.oauthTokenSecret = oauthTokenSecret
		self.screenName = screenName
		self.userID = Int64(userID)!
	}
}
