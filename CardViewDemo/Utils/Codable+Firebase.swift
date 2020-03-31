//
//  Codable+Firebase.swift
//  Admin-mystuff
//
//  Created by Ravi Dhorajiya on 13/11/18.
//  Copyright © 2018 Ravi Dhorajiya. All rights reserved.
//

import Foundation

extension Decodable {
  
  public static func deserialize(from dict: [String: Any]?) -> Self? {
    guard let dict = dict else {
      return nil
    }
    do {
      let data = try JSONSerialization.data(withJSONObject: dict as Any, options: [])
      return try JSONDecoder().decode(self, from: data)
    } catch {
      print("Error deserializing dictionary: ", error)
      return nil
    }
  }
  
  public static func deserialize(from string: String?) -> Self? {
    guard let string = string else {
      return nil
    }
    guard let data = string.data(using: String.Encoding.utf8) else {
      return nil
    }
    do {
      return try JSONDecoder().decode(self, from: data)
    } catch {
      print("Error deserializing string: ", error)
      return nil
    }
  }
}

extension Encodable {
  
  public func toJSON() -> [String: Any]? {
    do {
      let data = try JSONEncoder().encode(self)
      let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
      guard let object = jsonObject as? [String: Any] else {
        print("Error converting jsonObject to dictionary")
        return nil
      }
      return object
    } catch {
      print("Error serializing object to json: ", error)
      return nil
    }
  }
}
