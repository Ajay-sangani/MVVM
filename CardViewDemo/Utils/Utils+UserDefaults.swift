//
//  Utils+UserDefaults.swift
//  Latest Legal
//
//  Created by Ajay Sangani on 2/15/19.
//  Copyright © 2019 Ajay Sangani. All rights reserved.
//

import Foundation
import FirebaseAuth

extension Utils {
  
  func isLoggedIn() -> Bool {
    return LoginHelper.sharedInstance.isUserLoggedIn()
  }
  
  func setLoggedInUser() {
    LoginHelper.sharedInstance.setLoggedInUser()
  }
  
  func doLogout()  {
    do {
      LoginHelper.sharedInstance.logout()
      try Auth.auth().signOut()
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func setLoggedInUser(user: User) {
    UserDefaults().setUserForKey(user)
  }
  
  func getLoggedInUser() -> User? {
    return UserDefaults().getUser()
  }
  
  func removeLoggedInUser() ->Bool {
    return UserDefaults().removeObjectForKey(Key.UserDefaults.k_user)
  }
  
  func getUserId() -> String {
    if let user = getLoggedInUser() {
      if let userId = user.id {
        return String(userId)
      } else {
        return "0"
      }
    } else {
      return "0"
    }
  }
}
