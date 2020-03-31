//
//  UIColor+Extension.swift
//  CardViewDemo
//
//  Created by Ajay Sangani on 2/20/19.
//  Copyright © 2019 Ajay Sangani. All rights reserved.
//

import Foundation

extension UIColor {
  
  func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    if ((cString.count) != 6) {
      return UIColor.gray
    }
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
  static func color(_ red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
    return UIColor(
      red: 1.0 / 255.0 * CGFloat(red),
      green: 1.0 / 255.0 * CGFloat(green),
      blue: 1.0 / 255.0 * CGFloat(blue),
      alpha: CGFloat(alpha))
  }
}
