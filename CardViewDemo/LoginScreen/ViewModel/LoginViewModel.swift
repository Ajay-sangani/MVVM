//
//  LoginViewModel.swift
//  CardViewDemo
//
//  Created by Ajay Sangani on 2/21/19.
//  Copyright © 2019 Ajay Sangani. All rights reserved.
//

import Foundation

class LoginViewModel {
  
  typealias LoginUpdatedCallback = (_ status: Bool?, _ user: User?, _ error: Error?) -> Void
  
  var updatedOnLogin: LoginUpdatedCallback?
  
  private var dataProvider = LoginDataProvider()
  private(set) var isLoading = false
  
  var isLoginWithFacbook = false
  
  func login(_ email: String,_ password: String) {
    
    isLoading = true
    
    dataProvider.login(email: email, password: password)
      .done({ response in
        self.isLoading = false
        if let data = response as? User {
          self.updatedOnLogin!(true, data, nil)
        } else {
          self.updatedOnLogin!(false, nil, nil)
        }
      })
      .catch { error in
        self.isLoading = false
        self.updatedOnLogin!(false, nil, error)
    }
  }
}
