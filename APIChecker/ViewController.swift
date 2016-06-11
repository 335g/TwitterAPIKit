//
//  ViewController.swift
//  APIChecker
//
//  Created by Yoshiki Kudo on 2015/04/20.
//  Copyright (c) 2015年 Yoshiki Kudo. All rights reserved.
//

import UIKit
import APIKit
import TwitterAPIKit

class ViewController: UIViewController {
    
    weak var observer: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func authorize(sender: UIControl) {
        
        let service = AuthService.sharedService
        let consumerKey = service.consumerKey
        let consumerSecret = service.consumerSecret
        let callback = AuthService.callback
        
        let client = OAuthRequestTokenClient(consumerKey: consumerKey, consumerSecret: consumerSecret)
        let requestTokenRequet = TwitterOAuth.RequestToken(client: client, callback: callback)
		
        Session.sendRequest(requestTokenRequet){ result in
            switch result {
            case .Success(let response):
                self.observer = NSNotificationCenter
                    .defaultCenter()
                    .addObserverForName(AuthService.callbackNotification, object: nil, queue: nil){ [weak self] notification in
                        
                        let url: NSURL = notification.object as! NSURL
                        let info = url.query!.parametersFromQueryString()
                        
                        if let verifier = info["oauth_verifier"] {
                            let client = OAuthAccessTokenClient(
                                consumerKey: consumerKey,
                                consumerSecret: consumerSecret,
                                requestToken: response.requestToken,
                                requestTokenSecret: response.requestTokenSecret
                            )
                            let accessTokenRequest = TwitterOAuth.AccessToken(client: client, verifier: verifier)
							
							Session.sendRequest(accessTokenRequest){ result in
                                switch result {
                                case .Success(let response):
                                    let client = OAuthAPIClient(
                                        consumerKey: consumerKey,
                                        consumerSecret: consumerSecret,
                                        oauthToken: response.oauthToken,
                                        oauthTokenSecret: response.oauthTokenSecret
                                    )
                                    
                                    //let user = User.withName(response.screenName)
                                    let user = User.withID(response.userID)
                                    
                                    let navController = self?.storyboard?.instantiateViewControllerWithIdentifier("navVC") as! UINavigationController
                                    let viewController = navController.topViewController as! APIsViewController
                                    viewController.client = client
                                    viewController.user = user
									
									print(client)
									print(user)
									print(response)
                                        
                                    self?.presentViewController(navController, animated: true, completion: nil)
                                    
                                case .Failure(let error):
                                    print(error)
                                }
                            }
                        }
                        
                        if let observer = self?.observer {
                            NSNotificationCenter
                                .defaultCenter()
                                .removeObserver(observer, name: AuthService.callbackNotification, object: nil)
                        }
                }
                
                let url = TwitterOAuth.authorizeURL(response.requestToken)
                UIApplication.sharedApplication().openURL(url)
                
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    func callback(notification: NSNotification) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: AuthService.callbackNotification, object: nil)
    }
}

