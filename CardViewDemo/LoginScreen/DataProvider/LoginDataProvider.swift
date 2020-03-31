//
//  LoginDataProvider.swift
//  CardViewDemo
//
//  Created by Ajay Sangani on 2/21/19.
//  Copyright © 2019 Ajay Sangani. All rights reserved.
//

import Foundation
import PromiseKit
import FirebaseFirestore
import FirebaseAuth

class LoginDataProvider {
  
  func login(email: String, password: String) -> Promise<Any> {
    return Promise { seal in
      Auth.auth().signIn(withEmail: email, password: password, completion: { (authResult, error) in
        if error != nil {
          print(error!.localizedDescription)
          seal.reject(error!)
          return
        }
        guard let authUser = authResult?.user else {
          seal.reject(error!)
          return
        }
        let user = User(id: authUser.uid)
        seal.fulfill(user)
      })
    }
  }
}
