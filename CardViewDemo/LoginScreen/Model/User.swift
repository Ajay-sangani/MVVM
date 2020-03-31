//
//  User.swift
//  CardViewDemo
//
//  Created by Ajay Sangani on 2/21/19.
//  Copyright © 2019 Ajay Sangani. All rights reserved.
//

import Foundation

struct User: Codable {
  
  var id: String?
  
  enum CodingKeys: String, CodingKey {
    case id = "userID"
  }
  
  init(id: String) {
    self.id = id
  }
}
