//  Copyright © 2016 Yoshiki Kudo. All rights reserved.

import APIKit

public protocol TwitterAuthenticationRequestType: RequestType {
	associatedtype Client: OAuthClientType
	var client: Client { get }
}

public extension TwitterAuthenticationRequestType {
	public func interceptURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
		let url = self.baseURL.absoluteString + self.path
		let header = client.authHeader(self.method, url, parameters, false)
		URLRequest.setValue(header, forHTTPHeaderField: "Authorization")
		return URLRequest
	}
}

public protocol TwitterAPIRequestType: TwitterAuthenticationRequestType {
	var client: OAuthAPIClient { get }
}
