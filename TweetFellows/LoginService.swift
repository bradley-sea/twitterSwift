//
//  LoginService.swift
//  TweetFellows
//
//  Created by Bradley Johnson on 3/31/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation
import Accounts


class LoginService {
  
  class func requestTwitterAccount(callback : (String?,ACAccount?) -> (Void)) {
  
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted : Bool, error : NSError!) -> Void in
      if granted {
        let accounts = accountStore.accountsWithAccountType(accountType)
        if !accounts.isEmpty {
          //if more than one twitter account, offer the user a chance to choose which account
          let twitterAccount = accounts.first as ACAccount
          callback(nil,twitterAccount)
        } else {
          callback("please add a twitter account to your phone's settings", nil)
        }
      } else {
        callback("This app needs access to your twitter account to function, if you want to use this app please change your access settings",nil)
        }
      }
    }
}