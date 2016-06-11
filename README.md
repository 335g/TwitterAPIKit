# TwitterAPIKit
[![MIT Lincese](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

TwitterAPIKit is a library to access Twitter API easily.

Thanks to  
- [APIKit](https://github.com/ishkawa/APIKit)
- [HMAC](https://github.com/norio-nomura/HMAC)

## How To

1. [Authorize](#authorize)
1. [Access to API](#access-to-api)

### Authorize
Twitter uses OAuth to provide authorized access to its API. There will first need to get `request token`.  

```Swift
let consumerKey = "xxxx"
let consumerSecret = "yyyy"
let callback = "callback://"

let client = OAuthRequestTokenClient(consumerKey: consumerKey, consumerSecret: consumerSecret) // (1)
let requestTokenRequet = TwitterOAuth.RequestToken(client: client, callback: callback) // (2)

Session.sendRequest(request){ result in
    switch result {
    case .Success(let response):

         ...

    }
} // (3)
```

(1) is a process to prepare `client object`. There is 3 type `client object`.  
- `OAuthRequestTokenClient` is a client to access `oauth/request_token`.
- `OAuthAccessTokenClient` is a client to access `oauth/access_token`.
- `OAuthAPIClient` is a client to access some api.

(2) is a process to make `Request`. Please see [APIKit Document](https://github.com/ishkawa/APIKit) if you want to know detail.  
(3) is a process to access endpoint `oauth/request_token`. Trailing Closure is a response handling. `result` is a `Result<T, E>`. Please see [APIKit Document](https://github.com/ishkawa/APIKIT) too this.  

Next, You have to open URL `https://api.twitter.com/oauth/authorize`.

```Swift
let url = TwitterOAuth.authorizeURL(response.requestToken)
UIApplication.sharedApplication().openURL(url)
```

When you come back by callback, you have to get `access token`.

```Swift
let client = OAuthAccessTokenClient(
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    requestToken: response.requestToken,
    requestTokenSecret: response.requestTokenSecret
)
let accessTokenRequest = TwitterOAuth.AccessToken(client: client, verifier: verifier)
TwitterOAuth.sendRequest(accessTokenRequest){ result in
    switch result {
    case .Success(let response):

    let client = OAuthAPIClient(
        consumerKey: consumerKey,
        consumerSecret: consumerSecret,
        oauthToken: response.oauthToken,
        oauthTokenSecret: response.oauthTokenSecret
    )

    let user = User.withID(response.userID)

    /// You use this client when you access some API.
    /// Please use `User` if necessary.

    }
}
```

### Access to API
You can access some API by using previous `OAuthAPIClient` object. Please see [document](https://github.com/335g/TwitterAPIKit/blob/master/support.md) when you want to know supported APIs.


## License
Copyright (c) 2015 Yoshiki Kudo.  
TwitterAPIKit is available under the MIT license. See the LICENSE file for more info.
