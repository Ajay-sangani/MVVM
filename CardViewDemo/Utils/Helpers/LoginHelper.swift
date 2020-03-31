//
//  LoginHelper.swift
//  WoldyouRatherProduction
//
//  Created by Ajay Sangani on 6/30/18.
//  Copyright © 2018 Ajay Sangani. All rights reserved.
//

import Foundation

class LoginHelper {
  
  static let sharedInstance = LoginHelper()
  
  func isUserLoggedIn() -> Bool  {
    if UserDefaults().contains(key: Key.UserDefaults.k_UserLoggedIn) {
      return UserDefaults().getBoolForKey(Key.UserDefaults.k_UserLoggedIn)
    } else {
      return false
    }
  }
  
  func setLoggedInUser() {
    UserDefaults().setBoolForKey(Key.UserDefaults.k_UserLoggedIn, value: true)
  }
  
  func logout() {
    if isUserLoggedIn() {
      UserDefaults().setBoolForKey(Key.UserDefaults.k_UserLoggedIn, value: false)
    }
  }
}
