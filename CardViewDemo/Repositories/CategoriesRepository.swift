//
//  CategoriesRepository.swift
//  Admin-mystuff
//
//  Created by Ajay on 14/11/18.
//  Copyright © 2018 Ajay. All rights reserved.
//

import Foundation
import PromiseKit
import FirebaseFirestore
import FirebaseStorage
import Firebase

class CategoriesRepository {
  
  func fetchData() -> Promise<[Detail]> {
    
    return Promise { resolver in
      Firestore.firestore()
        .collection(FSCollection.data)
        .order(by: "id", descending: true)
        .addSnapshotListener({ (snapshot, error) in
          
        guard error == nil else {
          resolver.reject(error!)
          return
        }
        if let items = snapshot?.documents
          .map({ (snapshot) -> Detail? in
            guard let data = snapshot.dataWithIDIncluded() else {
              return nil
            }
            return Detail.deserialize(from: data)
          })
          .compactMap({
            return $0
          }) {
          resolver.fulfill(items)
        } else {
          resolver.fulfill([])
        }
      })
    }
  }
  
  func deleteCategory(_ id: String) -> Promise<Bool> {    
    return Promise { resolver in
      Firestore.firestore().collection(FSCollection.data).document(id).delete(completion: { (error) in
        guard error == nil else {
          resolver.reject(error!)
          return
        }
        resolver.fulfill(true)
      })
    }
  }
  
  func fetchUser() -> Promise<[User]> {
    
    return Promise { resolver in
      Firestore.firestore().collection(FSCollection.user).getDocuments(completion: { (snapshot, error) in
        guard error == nil else {
          resolver.reject(error!)
          return
        }
        if let items = snapshot?.documents
          .map({ (snapshot) -> User? in
            guard let data = snapshot.dataWithIDIncluded() else {
              return nil
            }
            return User.deserialize(from: data)
          })
          .compactMap({
            return $0
          }) {
          resolver.fulfill(items)
        } else {
          resolver.fulfill([])
        }
      })
    }
  }
}
