//
//  DetailModel.swift
//  CardViewDemo
//
//  Created by Ajay Sangani on 2/21/19.
//  Copyright © 2019 Ajay Sangani. All rights reserved.
//

import Foundation

class Detail: Codable {
  var id: String?
  var title: String?
  var desc: String?
  var img: String?
  var userID: String?
  
  enum CodingKeys: String, CodingKey {
    case title,id,userID
    case desc = "description"
    case img = "image"
  }
}
