//
//  TwitterService.swift
//  TweetFellows
//
//  Created by Bradley Johnson on 3/31/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation
import Social
import Accounts

class TwitterService {
  
  var twitterAccount : ACAccount?
  
  init() {
    //intentionally left blank
  }
  
  func fetchHomeTimeline( completionHandler : ([Tweet]?, String?) -> ()) {
  
    let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    twitterRequest.account = self.twitterAccount
  
          twitterRequest.performRequestWithHandler(){ (data, response, error) -> Void in
            switch response.statusCode {
            case 200...299:
              println("this is great!")
              let tweets = TweetJSONParser.tweetsFromJSONData(data)
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completionHandler(tweets, nil)
                })
            case 300...499:
              println("this is bad!")
              completionHandler(nil, "Please try another query")
              case 500...599:
              completionHandler(nil, "The servers are busy")
            default:
              println("default case fired")
            completionHandler(nil, "something bad happened")
            }
    }
  }
}
