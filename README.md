# TwitterAPIKit
[![MIT Lincese](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

TwitterAPIKit is a library to access Twitter API easily.
  
Thanks to  
- [APIKit](https://github.com/ishkawa/APIKit)
- [HMAC](https://github.com/norio-nomura/HMAC)
  
## Installation

### Using Carthage
- Insert `github "335g/TwitterAPIKit"` to your Cartfile.
- Run `carthage udpate`

## How To

1. [Authorize](#authorize)
1. [Access to API](#access-to-api)

### Authorize
Twitter uses OAuth to provide authorized access to its API. There will first need to get `request token`.  

```Swift
let consumerKey = "xxxx"
let consumerSecret = "yyyy"
let callback = "callback://"

let client = OAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: nil) // (1)
let request = Twitter.OAuth.RequestToken(client, callback: callback) // (2)
Twitter.OAuth.Post.sendRequest(request){ response in
    switch response {
    case .Success(let box):

         ...
         
    }
} // (3)
```

(1) is a process to prepare `client object`. This is needed to access some API.  
(2) is a process to make `Request`. Please see [APIKit Document](https://github.com/ishkawa/APIKit) if you want to know detail.
(3) is a process to access endpoint `OAuth/request_token`. Trailing Closure is a response handling. Argument `response` is [LlamaKit](https://github.com/LlamaKit/LlamaKit).Result<T, E>. Please see [APIKit Document](https://github.com/ishkawa/APIKIT) too this.  

Next, You have to open URL `https://api.twitter.com/oauth/authorize`. 

```Swift
let url = Twitter.API.OAuth.authorizeURL(requestToken)
UIApplication.sharedApplication().openURL(url)
```

When you come back by callback, you have to get `access token`.

```Swift
let accessToken = OAuthClient.AccessToken(key: requestToken, secret: requestTokenSecret, verifier: verifier)
let client = OAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: accessToken)
let request = Twitter.OAuth.AccessToken(client)
Twitter.OAuth.Post.sendRequest(request){ response in
    switch response {
    case .Success(let box):
        let info = box.unbox

        let userID = info["user_id"]
        let screenName = info["screen_name"]
        let accessToken = info["oauth_token"]
        let accessTokenSecret = info["oauth_token_secret"]

        let authorizedAccessToken = OAuthClient.AccessToken(key: accessToken, secret: accessTokenSecret, screenName: screenName, userID: userID)
        let client = OAuthClient(consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: authorizedAccessToken)

        // You use this client when you access some API.

    }
}
```

### Access to API
You can access some API by using previous `OAuthClient` object. Please see [document](https://github.com/335g/TwitterAPIKit/blob/master/support.md) when you want to know supported APIs.


## License
Copyright (c) 2015 Yoshiki Kudo.  
TwitterAPIKit is available under the MIT license. See the LICENSE file for more info.

