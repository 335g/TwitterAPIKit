# Support Twitter APIs

### Statuses
- [x] GET  [statuses/mentions_timeline](https://dev.twitter.com/rest/reference/get/statuses/mentions_timeline)
- [x] GET  [statuses/user_timeline](https://dev.twitter.com/rest/reference/get/statuses/user_timeline)
- [x] GET  [statuses/home_timeline](https://dev.twitter.com/rest/reference/get/statuses/home_timeline)
- [x] GET  [statuses/retweets_of_me](https://dev.twitter.com/rest/reference/get/statuses/retweets_of_me)
- [x] GET  [statuses/retweets/:id](https://dev.twitter.com/rest/reference/get/statuses/retweets/%3Aid)
- [x] GET  [statuses/show/:id](https://dev.twitter.com/rest/reference/get/statuses/show/%3Aid)
- [x] POST [statuses/destroy/:id](https://dev.twitter.com/rest/reference/post/statuses/destroy/%3Aid)
- [x] POST [statuses/update](https://dev.twitter.com/rest/reference/post/statuses/update)
- [x] POST [statuses/retweet/:id](https://dev.twitter.com/rest/reference/post/statuses/retweet/%3Aid)
- [ ] POST [statuses/update_with_media](https://dev.twitter.com/rest/reference/post/statuses/update_with_media)
- [ ] GET  [statuses/oembed](https://dev.twitter.com/rest/reference/get/statuses/oembed)
- [x] GET  [statuses/retweeters/ids](https://dev.twitter.com/rest/reference/get/statuses/retweeters/ids)
- [ ] GET  [statuses/lookup](https://dev.twitter.com/rest/reference/get/statuses/lookup)

### Direct Messages
- [x] GET  [direct_messages/sent](https://dev.twitter.com/rest/reference/get/direct_messages/sent)
- [x] GET  [direct_messages/show](https://dev.twitter.com/rest/reference/get/direct_messages/show)
- [x] GET  [direct_messages](https://dev.twitter.com/rest/reference/get/direct_messages)
- [x] POST [direct_messages/destroy](https://dev.twitter.com/rest/reference/post/direct_messages/destroy)
- [x] POST [direct_messages/new](https://dev.twitter.com/rest/reference/post/direct_messages/new)

### Users
- [x] GET  [users/lookup](https://dev.twitter.com/rest/reference/get/users/lookup)
- [x] GET  [users/show](https://dev.twitter.com/rest/reference/get/users/show)
- [ ] GET  [users/search](https://dev.twitter.com/rest/reference/get/users/search)
- [ ] GET  [users/profile_banner](https://dev.twitter.com/rest/reference/get/users/profile_banner)
- [ ] GET  [users/suggestions/:slug](https://dev.twitter.com/rest/reference/get/users/suggestions/%3Aslug)
- [ ] GET  [users/suggestions](https://dev.twitter.com/rest/reference/get/users/suggestions)
- [ ] GET  [users/suggestions/:slug/members](https://dev.twitter.com/rest/reference/get/users/suggestions/%3Aslug/members)
- [ ] POST [users/report_spam](https://dev.twitter.com/rest/reference/post/users/report_spam)

### Friendships
- [ ] GET  [friendships/no_retweets](https://dev.twitter.com/rest/reference/get/friendships/no_retweets/ids)
- [ ] GET  [friendships/incoming](https://dev.twitter.com/rest/reference/get/friendships/incoming)
- [ ] GET  [friendships/outgoing](https://dev.twitter.com/rest/reference/get/friendships/outgoing)
- [x] POST [friendships/create](https://dev.twitter.com/rest/reference/post/friendships/create)
- [x] POST [friendships/destroy](https://dev.twitter.com/rest/reference/post/friendships/destroy)
- [ ] POST [friendships/update](https://dev.twitter.com/rest/reference/post/friendships/update)
- [ ] GET  [friendships/show](https://dev.twitter.com/rest/reference/get/friendships/show)
- [ ] GET  [friendships/lookup](https://dev.twitter.com/rest/reference/get/friendships/lookup)

### Account
- [ ] GET  [account/settings](https://dev.twitter.com/rest/reference/get/account/settings)
- [ ] GET  [account/verify_credentials](https://dev.twitter.com/rest/reference/get/account/verify_credentials)
- [ ] POST [account/settings](https://dev.twitter.com/rest/reference/post/account/settings)
- [ ] POST [account/update_delivery_device](https://dev.twitter.com/rest/reference/post/account/update_delivery_device)
- [ ] POST [account/update_profile](https://dev.twitter.com/rest/reference/post/account/update_profile)
- [ ] POST [account/update_profile_background_image](https://dev.twitter.com/rest/reference/post/account/update_profile_background_image)
- [ ] POST [account/update_profile-image](https://dev.twitter.com/rest/reference/post/account/update_profile_image)
- [ ] POST [account/remove_profile_banner](https://dev.twitter.com/rest/reference/post/account/remove_profile_banner)
- [ ] POST [account/update_profile_banner](https://dev.twitter.com/rest/reference/post/account/update_profile_banner)

### Friends
- [x] GET  [friends/ids](https://dev.twitter.com/rest/reference/get/friends/ids)
- [x] GET  [friends/list](https://dev.twitter.com/rest/reference/get/friends/list)

### Followers
- [x] GET  [followers/ids](https://dev.twitter.com/rest/reference/get/followers/ids)
- [x] GET  [followers/list](https://dev.twitter.com/rest/reference/get/followers/list)

### Search
- [x] GET  [search/tweets](https://dev.twitter.com/rest/reference/get/search/tweets)

### Mutes
- [x] GET  [mutes/users/ids](https://dev.twitter.com/rest/reference/get/mutes/users/ids)
- [x] GET  [mutes/users/list](https://dev.twitter.com/rest/reference/get/mutes/users/list)
- [x] POST [mutes/users/create](https://dev.twitter.com/rest/reference/post/mutes/users/create)
- [x] POST [mutes/users/destroy](https://dev.twitter.com/rest/reference/post/mutes/users/destroy)

### Lists
- [ ] GET  [lists/list](https://dev.twitter.com/rest/reference/get/lists/list)
- [ ] GET  [lists/statuses](https://dev.twitter.com/rest/reference/get/lists/statuses)
- [ ] POST [lists/members/destroy](https://dev.twitter.com/rest/reference/post/lists/members/destroy)
- [x] GET  [lists/memberships](https://dev.twitter.com/rest/reference/get/lists/memberships)
- [ ] GET  [lists/subscribers](https://dev.twitter.com/rest/reference/get/lists/subscribers)
- [ ] POST [lists/subscribers/create](https://dev.twitter.com/rest/reference/post/lists/subscribers/create)
- [ ] GET  [lists/subscribers/show](https://dev.twitter.com/rest/reference/get/lists/subscribers/show)
- [ ] POST [lists/subscribers/destroy](https://dev.twitter.com/rest/reference/post/lists/subscribers/destroy)
- [ ] POST [lists/members/create_all](https://dev.twitter.com/rest/reference/post/lists/members/create_all)
- [ ] GET  [lists/members/show](https://dev.twitter.com/rest/reference/get/lists/members/show)
- [ ] GET  [lists/members](https://dev.twitter.com/rest/reference/get/lists/members)
- [ ] POST [lists/members/create](https://dev.twitter.com/rest/reference/post/lists/members/create)
- [ ] POST [lists/destroy](https://dev.twitter.com/rest/reference/post/lists/destroy)
- [ ] POST [lists/update](https://dev.twitter.com/rest/reference/post/lists/update)
- [ ] POST [lists/create](https://dev.twitter.com/rest/reference/post/lists/create)
- [ ] GET  [lists/show](https://dev.twitter.com/rest/reference/get/lists/show)
- [ ] GET  [lists/subscriptions](https://dev.twitter.com/rest/reference/get/lists/subscriptions)
- [ ] POST [lists/members/destroy_all](https://dev.twitter.com/rest/reference/post/lists/members/destroy_all)
- [ ] GET  [lists/ownerships](https://dev.twitter.com/rest/reference/get/lists/ownerships)
