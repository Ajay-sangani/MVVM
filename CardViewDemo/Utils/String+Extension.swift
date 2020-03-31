//
//  String+Extension.swift
//  WoldyouRatherProduction
//
//  Created by Ajay Sangani on 6/30/18.
//  Copyright © 2018 Ajay Sangani. All rights reserved.
//

import Foundation

extension String {
  
  func toUrl() -> URL {
    return URL(string: self)!
  }
  
  func toDouble() -> Double {
    return Double((self as NSString).doubleValue)
  }
  
  func toInt() -> Int {
    return self.isEmpty ? 0 : Int(self)!
  }
  
  func appendStringWith(_ string:String) ->String {
    return self.appending(string)
  }
  
  func toDateTime() -> NSDate {    
    let formatter = DateFormatter()
    formatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateFromString : NSDate = formatter.date(from: self)! as NSDate
    return dateFromString
  }
  
  func trim() -> String {
    return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
  }
  
  func replaceWith(find: String,with string:String) -> String {
    return self.replacingOccurrences(of: find, with: string)
  }
}
