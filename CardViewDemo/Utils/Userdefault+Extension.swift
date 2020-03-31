//
//  Userdefault+Extension.swift
//  WYR_CommentModule
//
//  Created by Ajay Sangani on 6/29/18.
//  Copyright © 2018 Ajay Sangani. All rights reserved.
//

import Foundation
extension UserDefaults {
  
  func contains(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
  }
  
  func setBoolForKey(_ key: String,value:Bool) {
    UserDefaults.standard.set(value, forKey: key)
  }
  
  func getBoolForKey(_ key: String) -> Bool {
    return UserDefaults.standard.bool(forKey: key)
  }
  
  func setValueForKey(_ key: String,value: Int) {
    UserDefaults.standard.set(value, forKey: key)
  }
  
  func setValueForKey(_ key: String,value: Any) {
    UserDefaults.standard.set(value, forKey: key)
  }
  
  func getValueForKey(_ key: String) -> [Int] {
    if contains(key: key) {
      if let value = UserDefaults.standard.value(forKey: key) as? [Int] {
        return value
      }
      return []
    } else {
      return []
    }
  }
  
  func getValueForKey(_ key: String) -> Int {
    if contains(key: key) {
      if let value = UserDefaults.standard.value(forKey: key) as? Int {
        return value
      }
      return 0
    } else {
      return 0
    }
  }
  
  func removeObjectForKey(_ key: String) -> Bool {
    if contains(key: key) {
      UserDefaults.standard.removeObject(forKey: key)
      return true
    } else {
      return false
    }
  }
  
  func setUserForKey(_ user: User)  {
    UserDefaults.standard.set(try! PropertyListEncoder().encode(user), forKey: Key.UserDefaults.k_user)
  }
  
  func getUser() -> User?  {
    if contains(key: Key.UserDefaults.k_user) {
      let storedObject: Data = UserDefaults.standard.object(forKey: Key.UserDefaults.k_user) as! Data
      return try! PropertyListDecoder().decode(User.self, from: storedObject)
    } else {
      return nil
    }
  }
}
